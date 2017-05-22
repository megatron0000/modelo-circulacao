clear;

endtime = 4;
dt = 0.001;
timeline = 0:dt:endtime;
lastIndex = floor(endtime/dt + 1);


% Pressão ventricular (esquerda)
US = arrayfun(@(t) ElastanciaCoracao(t), timeline) * 40000 - 11000;

% Resistência da aorta
RA = 1.8  * 10^7;
% Capacitância da aorta
C1 = 0.38 * 10^-9;
% Válvula aórtica (semelhante a diodo)
RDOpen = 1.5  * 10^7;
RDClosed = 6 * 10^8;
RD = RDOpen;

% Resistência sistêmica
RS = 20 * 10^8;
% Capacitância sistêmica
C2 = 3.84 * 10^-9;

% Pressões (aorta e sistema)
UC1 = zeros(lastIndex,1); UC1(1) = 6700;
UC2 = zeros(lastIndex,2); UC2(1) = 6600;


for index = 1 : lastIndex - 1
    ID = (US(index) - UC1(index)) / RD;
    IA = (UC1(index) - UC2(index)) / RA;
    IS = UC2(index) / RS;
    if (ID < 0)
        % ID = 0;
        RD = RDClosed;
    else
        RD = RDOpen;
    end
    charge1 = C1 * UC1(index) + (ID - IA) * dt;
    charge2 = C2 * UC2(index) + (IA - IS) * dt;
    UC1(index+1) = charge1 / C1;
    UC2(index+1) = charge2 / C2;
end

figure();
plot(timeline, UC1 * 760 / 10^5, timeline, UC2 * 760 / 10^5, timeline, US * 760 / 10^5);
xlabel('Tempo (s)');
ylabel('Pressão (mmHg)');
legend('Aorta', 'Sistema', 'Ventrículo esquerdo');