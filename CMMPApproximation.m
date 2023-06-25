close all; clear all; clc; warning off;
x = [1 3 4 6 7];
y = [-2.1 -0.9 -0.6 0.6 0.9];
p = length(x);
syms a b
eqns = [a*sum(x.^2)+b*sum(x)==sum(x.*y), a*sum(x)+b*p==sum(y)];
sol = solve(eqns, [a,b]);
syms X
F(X) = sol.a*X+sol.b;
t = x(1):0.01:x(p);
tt = F(t);
figure(1)
plot(t,tt,'LineWidth', 1)
for k=1:p
hold on
plot(x(k),y(k), '*', 'LineWidth', 1)
end
axis square
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cu functii Matlab
clear all; clc;
x = [1 3 4 6 7];
y = [-2.1 -0.9 -0.6 0.6 0.9];
p = length(x);
coef = polyfit(x,y,1);
t = x(1):0.01:x(p);
tt = polyval(coef,t);
figure(2)
plot(t,tt,'LineWidth', 1)
for k=1:p
hold on
plot(x(k),y(k), '*', 'LineWidth', 1)
end
axis square
