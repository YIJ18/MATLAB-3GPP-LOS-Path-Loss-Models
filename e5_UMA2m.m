function PL_LOS = path_loss_UMa_LOS(d2D, d3D, fc, hBS, hUE)
    c = 3e8; % Velocidad de la luz en m/s
    h_BS_P = hBS - 1; % Altura del BS prima (ecuación 8 del artículo)
    h_UE_P = hUE - 1; % Altura del UE prima (ecuación 8 del artículo)
    d_BP_P = 4 * h_BS_P * h_UE_P * fc * 1e9 / c;% Distancia de ruptura prima (d_BP') (ecuación 8 del artículo)

    PL_LOS = zeros(size(d2D));
    for i = 1:length(d2D)
        if d2D(i) <= d_BP_P
            % PL1 
            PL_LOS(i) = 28.0 + 22*log10(d3D(i)) + 20*log10(fc);
        else
            % PL2 
            PL_LOS(i) = 28.0 + 40*log10(d3D(i)) + 20*log10(fc) - 9*log10((d_BP_P)^2 + (hBS-hUE)^2);
        end
    end
end

function NLOS = path_loss_UMa_NLOS(d3D, fc, hUE, PL_LOS)
    NLOS_formula = 13.54 + 39.08*log10(d3D) + 20*log10(fc) - 0.6*(hUE - 1.5);
    NLOS = max(PL_LOS, NLOS_formula);
end


fc = 37;             % Frecuencia portadora en GHz
hBS = 25;            % Altura de la estacion base
hUE = 1.5;           % Altura del usuario
d2D = 10:5:5000;     % distancia 2D
d3D = sqrt(d2D.^2 + (hBS-hUE)^2);  % distancia 3D 


PL_LOS = path_loss_UMa_LOS(d2D, d3D, fc, hBS, hUE);
PL_NLOS = path_loss_UMa_NLOS(d3D, fc, hUE, PL_LOS);
PL_CI = 32.4 + 20*log10(fc) + 30*log10(d3D);



figure;
semilogx(d2D, PL_LOS, 'b-', 'LineWidth', 2, 'DisplayName', 'UMa LOS');
hold on;
semilogx(d2D, PL_NLOS, 'r-', 'LineWidth', 2, 'DisplayName', 'UMa NLOS');
semilogx(d2D, PL_CI, 'g-', 'LineWidth', 2, 'DisplayName', 'CI model ');
xlabel('Distancia 2D (m)');
ylabel('Pérdida de Trayecto (dB)');
title(['OMNIDIRECTIONAL PATH LOSS MODELS IN THE UMa SCENARIO, f_c = ' num2str(fc) ' GHz']);
legend('Location', 'northwest');
grid on;

