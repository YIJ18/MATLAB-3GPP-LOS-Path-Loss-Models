function LOS = losProbability_UMA(d2D, huE)
    d1 = 18;  
    d2 = 63;  
    LOS_base = min(d1 ./ d2D, 1) .* (1 - exp(-d2D ./ d2)) + exp(-d2D ./ d2);
    C = zeros(size(d2D));
    
    for i = 1:length(d2D)
        if huE < 13
            C(i) = 0;
        elseif huE >= 13 && huE <= 23
            if d2D(i) <= 18
                g_val = 0;
            else
                g_val = (1.25e-6) * (d2D(i)^3) * exp(-d2D(i)/150);
            end
            C(i) = ((huE - 13)/10)^1.5 * g_val;
        end
    end
    
    LOS = LOS_base .* (1 + C);
end




d2D = 1:1:600;          % distancia para outdoor
d2D_out = d2D + 20;     % distancia para indoor
huE_bajo = 7;          % menos 13m
huE_mid = 15;           % entre 13m y 23m
huE_alto = 23;          % en 23m 

P_outdoor_bajo = zeros(size(d2D));
P_outdoor_mid = zeros(size(d2D));
P_outdoor_alto = zeros(size(d2D));
P_indoor = zeros(size(d2D));

for i = 1:length(d2D)
    P_outdoor_bajo(i) = losProbability_UMA(d2D(i), huE_bajo);
    P_outdoor_mid(i) = losProbability_UMA(d2D(i), huE_mid);
    P_outdoor_alto(i) = losProbability_UMA(d2D(i), huE_alto);
    P_indoor(i) = losProbability_UMA(d2D_out(i), huE_mid);
end

figure;
plot(d2D, P_outdoor_bajo, 'b-', 'LineWidth', 2, 'DisplayName', 'Outdoor (huE = 1.5m)');
hold on;
plot(d2D, P_outdoor_mid, 'g-', 'LineWidth', 2, 'DisplayName', 'Outdoor (huE = 15m)');
plot(d2D, P_outdoor_alto, 'm-', 'LineWidth', 2, 'DisplayName', 'Outdoor (huE = 23m)');
plot(d2D, P_indoor, 'r-', 'LineWidth', 2, 'DisplayName', 'Indoor (huE = 15m)');
xlabel('Distancia 2D (m)');
ylabel('Probabilidad de LOS');
title('UMA SCENARIO Probabilidad de LOS según 3GPP TR 38.901');
legend('Location', 'northeast');
grid on;
