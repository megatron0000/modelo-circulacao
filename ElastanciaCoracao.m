function elastance = ElastanciaCoracao(t)

% Per�odo da batida
T = 1;
% Tempo da s�stole
TS = 0.3 * sqrt(T);
% Tempo da s�stole � di�stole
TD = 0.5 * TS;
% Elast�ncia na s�stole
ES = 0.721;
% Elast�ncia na di�stole (carteado)
ED = 0.300;

% De tempo absoluto para tempo relativo ao ciclo
t = (t/T - floor(t/T)) * T;

if t < TS
    elastance = ED + (ES - ED) * (1 - cos(pi*t/TS))/2;
else
    if t < TS + TD
        elastance = ED + (ES - ED) * (1 + cos(pi * (t-TS)/TD))/2;
    else
        elastance = ED;
    end
end

end
