close all; clear all; clc;
x = [0 1 2 3];
y = [-1 0 2 1];
sum = 0;
xx = 2.5;
p = length(x);
t = x(1):0.01:x(p);
for i = 1:p
 l = 1;
 for j = 1:p
 if i~= j
 l = conv(l, poly(x(j)))/(x(i)-x(j));
 end
 end
 ll(:,i) = polyval(l, t);
 sum = sum + y(i)*l;
end
val = polyval(sum, xx);
for k=1:p
 plot(x(k),y(k),'*', 'LineWidth', 1)
 hold on
end
for k=1:p
 plot(t, ll(:,k))
 hold on
end
tt = polyval(sum, t);
plot(t,tt, 'LineWidth', 1,'color', 'r')
axis square
legend({'(x_0, y_0)', '(x_1, y_1)', '(x_2, y_2)', '(x_3,y_3)', 'l_0(x)', 'l_1(x)', 'l_2(x)', 'l_3(x)', 'L(x)'}, "Location","eastoutside")