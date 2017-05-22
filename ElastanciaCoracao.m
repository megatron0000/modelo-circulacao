function elastance = ElastanciaCoracao(t)

% Período da batida
T = 1;
% Tempo da sístole
TS = 0.3 * sqrt(T);
% Tempo da sístole à diástole
TD = 0.5 * TS;
% Elastância na sístole
ES = 0.721;
% Elastância na diástole (carteado)
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
