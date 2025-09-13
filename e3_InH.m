function LOS = LOS_Probability_InH_Mixed(d2D)
    LOS = zeros(size(d2D));
    for i = 1:length(d2D)
        if d2D(i) <= 1.2
            LOS(i) = 1;
        elseif d2D(i) > 1.2 && d2D(i) < 6.5
            LOS(i) = exp(-(d2D(i) - 1.2)/4.7);
        else % d2D >= 6.5
            LOS(i) = exp(-(d2D(i) - 6.5)/32.6) * 0.32;
        end
    end
end

function LOS = LOS_Probability_InH_Open(d2D)
    LOS = zeros(size(d2D));
    for i = 1:length(d2D)
        if d2D(i) <= 5
            LOS(i) = 1;
        elseif d2D(i) > 5 && d2D(i) < 49
            LOS(i) = exp(-(d2D(i) - 5)/70.8);
        else % d2D >= 49
            LOS(i) = exp(-(d2D(i) - 49)/211.7) * 0.54;
        end
    end
end


d2D = 0:1:600;
P_Mixed_Of = LOS_Probability_InH_Mixed(d2D);
P_Open_Of = LOS_Probability_InH_Open(d2D);

figure;
plot(d2D, P_Mixed_Of, 'b-', 'LineWidth', 2, 'DisplayName', 'InH-Mixed office');
hold on;
plot(d2D, P_Open_Of, 'r-', 'LineWidth', 2, 'DisplayName', 'InH-Open office');
xlabel('Distancia 2D (m)');
ylabel('Probabilidad de LOS');
title('LOS PROBABILITY MODELS IN THE InH SCENARIO (3GPP TR 38.901)');
legend('Location', 'northeast');
grid on;


