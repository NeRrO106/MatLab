clc; clear; close all;

%Parametrii
g=9.81; % acceleratia gravitationala
vo=550; % viteza initiala

%Valorile cautate
b = zeros(1,89); % bataia proiectilului
ymax = zeros(1,89); % altitudinea maxima 
tzbor = zeros(1,89); % timpul de zbor

sz = [ 89 4];
varTypes = ["double","double","double","double"];
varNames = ["Unghi","Bataia","Altitudinea", "Timpul de zbor"];
temps = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

for theta=1:89
    [ b(theta), ymax(theta), tzbor(theta) ] = lansare(theta);
    temps(theta, :) = {theta, b(theta), ymax(theta), tzbor(theta)};
end
x = 1:89;

figure(1);
plot(x, b, 'm-');
xlabel('theta (°)'); ylabel('b(m)'); grid;
title('Bataia in functie de unghi','Color','#D95319');
set(gca,'xLim',[0 90], 'xTick', 1:1:89);

figure(2);
plot(x, ymax, 'm-');
xlabel('theta (°)'); ylabel('y max(m)'); grid;
title('Altitudinea in functie de unghi','Color','#A2142F');
set(gca,'xLim',[1 89], 'xTick', 1:1:89);

figure(3);
plot(x, tzbor, 'm-');
xlabel('theta (°)'); ylabel('t zbor (s)'); grid;
title('Timpul de zbor in functie de unghi','Color','#7E2F8E');
set(gca,'xLim',[0 90], 'xTick', 1:1:89);

disp(temps);

save('date.mat', 'temps');
writetable(temps,'date.xlsx','Sheet',1);