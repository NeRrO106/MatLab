clc; clear; close all

m=3*1e-3;

t0=2; tf=8.5; N=1000; t=linspace(t0,tf,N); dt=t(2)-t(1);

v0=0; x0=0;

F=15*1e-3*sin(t.^2-3*t+2).^2;

a=F/m;

v=zeros(1,N); v(1)=v0;

for i=1:N-1
 v(i+1)=v(i)+a(i)*dt;
end

figure(1)

plot(t,v,'-r')

xlabel('t(s)'); ylabel('v(m/s)'); grid

disp(v(N)) 