close all; clear all; clc; format long;
% date de intrare
f = inline('x.^3+x.^2-1');
f_deriv = inline('3*x.^2+2*x');
x(1) = 0.1;
n = 1;
eps = 10^(-4);
er(1) = 1;
% interval pentru solutie pe cale grafica
t = -2:0.01:2;
f = vectorize(f);
plot(t,f(t), 'LineWidth', 2)
% iterare
while(er > eps)
 x(n+1) = x(n)-f(x(n))/f_deriv(x(n));
 er(n+1) = abs(x(n+1)-x(n));
 n = n+1;
end