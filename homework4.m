% Miscarea haotica a trei pendule gravitationale duble 

clear; close all; clc;

RT=1; % selector real time(1) / slow motion(0)
g=9.80665; % m/s^2; acceleratia gravitationala terestra

% Parametrii fizici ai sistemului mecanic

L1=2.2; L2=1.3; % m; lungimile tijelor 
m1=1.2; m2=1.7; % kg; masele corpurilor

% Conditiile initiale

% pendulul 1
theta10=150; theta20=-31; % grade; unghiurile initiale(aceleasi pentru toate 3)
theta10=theta10*pi/180; theta20=theta20*pi/180; % conversia in rad
OM10=-80; OM20=50; % grade/s; vitezele unghiulare initiale
OM10=OM10*pi/180; OM20=OM20*pi/180; % conversia in rad/s

% pendulul 2 
OM30=-79; OM40=49;
OM30=OM30*pi/180; OM40=OM40*pi/180; 

% pendulul 3 
OM50=-78; OM60=48; 
OM50=OM50*pi/180; OM60=OM60*pi/180;

% Definirea duratelor caracteristice:

omega1=sqrt(g/L1); omega2=sqrt(g/L2); % pulsatii proprii ale componentelor
T1=2*pi/omega1; T2=2*pi/omega2; % perioade proprii ale componentelor
T=max(T1,T2); % "timp caracteristic" al miscarii pendulului dublu
ti=0; tf=5*T; N=400000; t=linspace(ti,tf,N); dt=t(2)-t(1); % timpul discret

% Prealocare si valori de start:

% pendulul 1
theta1=zeros(1,N); theta2=zeros(1,N); % prealocare unghiuri
OM1=zeros(1,N); OM2=OM1; % prealocare viteze unghiulare
theta1(1)=theta10; theta2(1)=theta20; % unghiuri de start pas 1
theta1(2)=theta10+OM10*dt; theta2(2)=theta20+OM20*dt; % unghiuri de start pas 2
OM1(1)=OM10; OM2(1)=OM20; % valori de start ale vitezelor unghiulare

% pendulul 2
theta3=zeros(1,N); theta4=zeros(1,N); 
OM3=zeros(1,N); OM4=OM3;
theta3(1)=theta10; theta4(1)=theta20;
theta3(2)=theta10+OM30*dt; theta4(2)=theta20+OM40*dt;
OM3(1)=OM30; OM4(1)=OM40;

% pendulul 3
theta5=zeros(1,N); theta6=zeros(1,N);
OM5=zeros(1,N); OM6=OM5; 
theta5(1)=theta10; theta6(1)=theta20; 
theta5(2)=theta10+OM50*dt; theta6(2)=theta20+OM60*dt; 
OM1(1)=OM10; OM2(1)=OM20; % 

% Notatii ajutatoare:

miu=1+m1/m2; % coeficient adimensional
r=L2/L1; % coeficient adimensional

a11=miu; a22=r; % coeficienti diagonala principala (constanti)
b11=miu; b22=r;
c11=miu; c22=r;

tic;

for i=2:N-1 % ciclul recurentelor

    aux1=theta2(i)-theta1(i);
    aux2=theta4(i)-theta3(i);
    aux3=theta6(i)-theta5(i);
    a21=cos(aux1); a12=a21*r; % coeficienti diagonala secundara (variabili)
    b21=cos(aux2); b12=b21*r;
    c21=cos(aux3); c12=c21*r;

    % Pentru vitezele unghiulare curente folosim derivatele la stanga:

    OM1(i)=(theta1(i)-theta1(i-1))/dt; % viteza corpului 1 la pasul i
    OM2(i)=(theta2(i)-theta2(i-1))/dt; % viteza corpului 2 la pasul i
    OM3(i)=(theta3(i)-theta3(i-1))/dt; % viteza corpului 3 
    OM4(i)=(theta4(i)-theta4(i-1))/dt; % viteza corpului 4 
    OM5(i)=(theta5(i)-theta5(i-1))/dt; % viteza corpului 5 
    OM6(i)=(theta6(i)-theta6(i-1))/dt; % viteza corpului 6 

    b1=r*OM2(i)^2*sin(aux1)-g/L1*miu*sin(theta1(i)); % termen "liber" 1
    b2=-OM1(i)^2*sin(aux1)-g/L1*sin(theta2(i)); % termen "liber" 2
    b3=r*OM4(i)^2*sin(aux2)-g/L1*miu*sin(theta3(i)); % termen "liber" 3
    b4=-OM3(i)^2*sin(aux2)-g/L1*sin(theta4(i)); % termen "liber" 4
    b5=r*OM6(i)^2*sin(aux3)-g/L1*miu*sin(theta5(i)); % termen "liber" 5
    b6=-OM5(i)^2*sin(aux3)-g/L1*sin(theta6(i)); % termen "liber" 6

    A=[a11,a12;a21,a22]; B=[b1;b2]; % matrice sistem si coloana termeni liberi
    E1=A\B; % rezolvarea sistemului liniar in forma matriceala
    eps1=E1(1); eps2=E1(2); % acceleratiile unghiulare curente
    C=[b11,b12;b21,b22]; D=[b3;b4];
    E2=C\D;
    eps3=E2(1); eps4=E2(2);
    E=[c11,c12;c21,c22]; F=[b5;b6];
    E3=E\F;
    eps5=E3(1); eps6=E3(2);

    % Recurentele de ordinul II:

    theta1(i+1)=2*theta1(i)-theta1(i-1)+dt^2*eps1; % corp 1
    theta2(i+1)=2*theta2(i)-theta2(i-1)+dt^2*eps2; % corp 2
    theta3(i+1)=2*theta3(i)-theta3(i-1)+dt^2*eps3; % corp 3
    theta4(i+1)=2*theta4(i)-theta4(i-1)+dt^2*eps4; % corp 4
    theta5(i+1)=2*theta5(i)-theta5(i-1)+dt^2*eps5; % corp 5
    theta6(i+1)=2*theta6(i)-theta6(i-1)+dt^2*eps6; % corp 6
end

OM1(N)=(theta1(N)-theta1(N-1))/dt; % viteza unghiulara corp 1 la pasul N
OM2(N)=(theta2(N)-theta2(N-1))/dt; % viteza unghiulara corp 2 la pasul N
OM3(N)=(theta3(N)-theta3(N-1))/dt; % viteza unghiulara corp 3 la pasul N
OM4(N)=(theta4(N)-theta4(N-1))/dt; % viteza unghiulara corp 4 la pasul N
OM5(N)=(theta5(N)-theta5(N-1))/dt; % viteza unghiulara corp 5 la pasul N
OM6(N)=(theta6(N)-theta6(N-1))/dt; % viteza unghiulara corp 6 la pasul N

toc;

% Coordonate carteziene ale corpurilor:

x1=L1*sin(theta1); x2=x1+L2*sin(theta2); % coordonate orizontale
y1=-L1*cos(theta1); y2=y1-L2*cos(theta2); % coordonate verticale
x3=L1*sin(theta3); x4=x3+L2*sin(theta4); 
y3=-L1*cos(theta3); y4=y3-L2*cos(theta4);
x5=L1*sin(theta5); x6=x5+L2*sin(theta6); 
y5=-L1*cos(theta5); y6=y5-L2*cos(theta6);
% Reprezentarea miscarii simultane celor 3 pendule

figure(1);

Lmax=L1+L2; % semilatura cadrului grafic
coef=30; % controleaza dimensiunile grafice ale corpurilor

rg1=coef*m1^(1/3); rg2=coef*m2^(1/3); % raze "grafice"

tic; simt=0;  % porneste cronometrul si initializeaza timpul simularii

while simt<=tf % ciclul grafic

  j=abs(t-simt)==min(abs(t-simt)); % cauta cel mai apropiat t din discretizare

  plot([0 x1(j) x2(j)],[0 y1(j) y2(j)],'-c','LineWidth',5); hold on; % tije
  xlabel('x/m'); ylabel('y/m');
  plot(0,0,'.k','MarkerSize',10); % articulatie de suspensie
  plot(x1(j),y1(j),'.k','MarkerSize',rg1); % corpul 1
  plot(x1(j),y1(j),'.b','MarkerSize',10); % articulatie corp 1
  plot(x2(j),y2(j),'.r','MarkerSize',rg2); % corpul 2

  plot([0 x3(j) x4(j)],[0 y3(j) y4(j)],'-m','LineWidth',5); hold on;
  plot(x3(j),y3(j),'.k','MarkerSize',rg1); % corpul 3
  plot(x3(j),y3(j),'.b','MarkerSize',10); % articulatie corp 3
  plot(x4(j),y4(j),'.r','MarkerSize',rg2); % corpul 4
 
  plot([0 x5(j) x6(j)],[0 y5(j) y6(j)],'-g','LineWidth',5); hold on;
  plot(x5(j),y5(j),'.k','MarkerSize',rg1); % corpul 5
  plot(x5(j),y5(j),'.b','MarkerSize',10); % articulatie corp 5
  plot(x6(j),y6(j),'.r','MarkerSize',rg2); % corpul 6

  axis([-Lmax Lmax -Lmax Lmax]); axis square; % cadrul grafic

  simt=toc; % actualizeaza timpul simularii cu ceasul sistemului
  text(3/5*Lmax,4/5*Lmax,['t = ',num2str(round(t(j))),' s']);
  pause(1e-6); hold off
end