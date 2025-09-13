function LOS = path_loss_UMi_LOS(d2D, d3D, fc, hBS, hUE)
    c = 3e8; % Velocidad de la luz en m/s
    h_BS_P = hBS - 1; % Altura del BS prima (ecuación 8 del artículo)
    h_UE_P = hUE - 1; % Altura del UE prima (ecuación 8 del artículo)
    d_BP_P = 4 * h_BS_P * h_UE_P * fc * 1e9 / c; % Distancia de ruptura prima (d_BP') (ecuación 8 del artículo)
    LOS = zeros(size(d2D)); 

    for i = 1:length(d2D)
        if d2D(i) <= d_BP_P
            % Fórmula PL1 para distancias menores 
            LOS(i) = 32.4 + 21*log10(d3D(i)) + 20*log10(fc);
        else
            % Fórmula PL2 para distancias mayores 
            LOS(i) = 32.4 + 40*log10(d3D(i)) + 20*log10(fc) - 9.5*log10((d_BP_P)^2 + (hBS-hUE)^2);
        end
    end
end


function NLOS = path_loss_UMi_NLOS(d3D, fc, hUE, PL_LOS)
    NLOS_formula = 35.3*log10(d3D) + 22.4 + 21.3*log10(fc) - 0.3*(hUE - 1.5);
    NLOS = max(PL_LOS, NLOS_formula);
end


fc = 37;             % Frecuencia portadora en GHz
hBS = 10;            % Altura de la estacion base
hUE = 1.5;           % Altura del usuario
d2D = 10:5:5000;     % distancia 2D
d3D = sqrt(d2D.^2 + (hBS-hUE)^2);  % distancia 3D 


PL_LOS = path_loss_UMi_LOS(d2D, d3D, fc, hBS, hUE);
PL_NLOS = path_loss_UMi_NLOS(d3D, fc, hUE, PL_LOS);
PL_CI = 32.4 + 20*log10(fc) + 31.9*log10(d3D);


figure;
semilogx(d2D, PL_LOS, 'b-', 'LineWidth', 2, 'DisplayName', 'UMi-Street Canyon LOS');
hold on;
semilogx(d2D, PL_NLOS, 'r-', 'LineWidth', 2, 'DisplayName', 'UMi-Street Canyon NLOS');
semilogx(d2D, PL_CI, 'g-', 'LineWidth', 2, 'DisplayName', 'CI model ');
xlabel('Distancia 2D (m)');
ylabel('Pérdida de Trayecto (dB)');
title(['OMNIDIRECTIONAL PATH LOSS MODELS IN THE UMi, f_c = ' num2str(fc) ' GHz']);
legend('Location', 'northwest');
grid on;
