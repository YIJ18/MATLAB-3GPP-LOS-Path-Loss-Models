fGHz = 37;           % Frecuencia en GHz
L_glass = 2;          % Pérdida en dB por vidrio (Low-loss)
L_concrete = 5;       % Pérdida en dB por concreto
L_IRRg = 20;          % Pérdida en dB por vidrio IRR (High-loss)

d = 0:1:30;        

PLtw_low = 5 - 10 * log10(0.3 * 10.^(-L_glass/10) + 0.7 * 10.^(-L_concrete/10));
PLtw_high = 5 - 10 * log10(0.7 * 10.^(-L_IRRg/10) + 0.3 * 10.^(-L_concrete/10));
PLin = 0.5 * d;     
PL_LowLoss = PLtw_low + PLin;
PL_HighLoss = PLtw_high + PLin;

figure;
plot(d, PL_LowLoss, 'b-', 'LineWidth', 2); hold on;
plot(d, PL_HighLoss, 'r-', 'LineWidth', 2);
grid on;
xlabel('Distancia interior d (m)');
ylabel('Pérdida total (dB)');
title('PENETRATION LOSS PARAMETERS ');
legend('Low-loss', 'High-loss', 'Location', 'northwest');
