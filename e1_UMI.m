function LOS = losProbability_UMI(d2D)
    d1 = 18;  
    d2 = 36;  
    LOS = min(d1 ./ d2D, 1) .* (1 - exp(-d2D ./ d2)) + exp(-d2D ./ d2);
end

d2D = 1:1:600;          % distancia para outdoor
d2D_out = d2D + 20;     % distancia para indoor

P_outdoor = losProbability_UMI(d2D);
P_indoor = losProbability_UMI(d2D_out);

figure;
plot(d2D, P_outdoor, 'b-', 'LineWidth', 2, 'DisplayName', 'Outdoor');
hold on;
plot(d2D, P_indoor, 'r-', 'LineWidth', 2, 'DisplayName', 'Indoor');
xlabel('Distancia 2D (m)');
ylabel('Probabilidad de LOS');
title('UMi SCENARIO Probabilidad de LOS según 3GPP TR 38.901');
legend('Location', 'northeast');
grid on;
