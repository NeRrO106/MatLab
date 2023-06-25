function [b, ymax, tzbor] = lansare(alpha0)
   g = 9.80665; 
   ro = 7850;
   r = 0.13;
   m = 4/3 * pi * r^3 * ro;
   G = m*g;

    v0 = 700; 
    eta = 1.81 * 1e-5;
    b1 = 6 * pi * eta * r;
    c = 0.469;
    ro0 = 1.22;
    b2 = c * 4 * pi * r^2 * ro0/2;

    t0 = 0; tf = 2 * v0 /g*sind(alpha0);
    N = 1500;
    t = linspace(t0,tf,N); dt = t(2) - t(1);

    % Prealocare si valori de inceput:
    vx = zeros(1,N); vy = vx;
    x = zeros(1,N); y = x;
    vx(1) = v0 * cosd(alpha0);
    vy(1) = v0 * sind(alpha0);

    for i = 1:N-1
        aux = 1 - dt*(b1 + b2*sqrt(vx(i)^2 + vy(i)^2))/m;
        vx(i+1)=vx(i)*aux;
        vy(i+1)=vy(i)*aux - g*dt;
        x(i+1)=x(i) + vx(i)*dt;
        y(i+1)=y(i) + vy(i)*dt;
        if y(i+1)<0, break; end
    end

    t = t(1:i);% eliminarea valorilor in surplus
    vx=vx(1:i); % eliminarea valorilor in surplus
    vy=vy(1:i); % eliminarea valorilor in surplus
    x=x(1:i); % eliminarea valorilor in surplus
    y=y(1:i); % eliminarea valorilor in surplus

% Afisarea unor marimi de interes:
tzbor = t(i); % timpul de zbor
b = x(i); % bataia
ymax = max(y); % altitudinea maxima

end
