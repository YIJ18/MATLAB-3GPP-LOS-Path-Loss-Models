function LOS = path_Loss_InH_LOS(d3D, fc)
    LOS = 32.4 + 17.3*log10(d3D) + 20*log10(fc);
end

function NLOS = path_Loss_InH_NLOS(d3D, fc, PL_LOS)
    NLOS_formula = 17.30 + 38.3*log10(d3D) + 24.9*log10(fc);
    NLOS = max(PL_LOS, NLOS_formula);
end


fc = 37;             % Frecuencia portadora GHz
d3D = 1:1:100;       % 3D 1m a 100m (para LOS)
d3D_NLOS = 1:1:86;   % 3D 1m a 86m (para NLOS)

PL_LOS = path_Loss_InH_LOS(d3D, fc);
PL_NLOS = path_Loss_InH_NLOS(d3D_NLOS, fc, path_Loss_InH_LOS(d3D_NLOS, fc));
PL_CI = 32.4 + 20*log10(fc) + 31.9*log10(d3D_NLOS);

figure;
plot(d3D, PL_LOS, 'b-', 'LineWidth', 2, 'DisplayName', 'InH LOS');
hold on;
plot(d3D_NLOS, PL_NLOS, 'r-', 'LineWidth', 2, 'DisplayName', 'InH NLOS');
plot(d3D_NLOS, PL_CI, 'g-', 'LineWidth', 2, 'DisplayName', 'CI model');
xlabel('Distancia 3D (m)');
ylabel('Pérdida de Trayecto (dB)');
title(['OMNIDIRECTIONAL PATH LOSS MODELS IN THE InH SCENARIO, f_c = ' num2str(fc) ' GHz']);
legend('Location', 'northwest');
grid on;


