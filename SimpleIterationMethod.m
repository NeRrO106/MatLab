close all; clear all; clc; format long;
% date de intrare
g = inline('1/(x.^2+4)');
x(1) = 0.5;
C = 2/25;
eps = 10^(-4);
er = 10;
n = 1;
a = abs(x(1)-g(x(1)));
n_min = floor((log(eps*(1-C)/a))/log(C))+1;
% determinarea intervalului solutiei pe cale grafica
t = -5:0.1:5;
g = vectorize(g);
plot(t, g(t), t, t, 'LineWidth', 2)
% calculul constantei de contractie pe multime discreta
t = 0:0.0001:1;
abs_g_deriv = inline('2*x./(x.^2+4).^2');
abs_g_deriv = vectorize(abs_g_deriv);
y = abs_g_deriv(t);
C = max(y);
% iterare
% while(n <= n_min)
% x(n+1) = g(x(n));
% n = n+1;
% end
%
while(er > eps)
x(n+1) = g(x(n));
er = C^n/(1-C)*a;
n = n+1;
end