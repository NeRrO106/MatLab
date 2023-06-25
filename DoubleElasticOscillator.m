% Problema oscilatiilor cu mai multe grade de libertate

% sau Problema oscilatorului compus

% Asociat cu cursurile 6, 7 si seminarul 3

% 16.11.22

% --------------------------

clc; clear all; close all

%-------------------------------------------------------------

m1=1; m2=1; % masele celor doua corpuri [kg]

ka=1000; kb=1000; kc=1000; % constantele elastice ale resorturilor [N/m]

% ----------------------------------------

% Stabilirea intervalului de timp pentru studiul miscarii

ti=0;

% Calculam timpi caracteristici ai sistemului folosind formula perioadei oscilatorului elastic armonic (C3):

Ta1=2*pi*sqrt(m1/ka); % perioada proprie a corpului 1 legat de resortul a

Tb1=2*pi*sqrt(m1/kb); % perioada proprie a corpului 1 legat de resortul b

Tb2=2*pi*sqrt(m2/kb); % perioada proprie a corpului 2 legat de resortul b

Tc2=2*pi*sqrt(m2/kc); % perioada proprie a corpului 2 legat de resortul c

Tmax=max([Ta1 Tb1 Tb2 Tc2]); % cea mai mare dintre perioadele proprii

N1=5;tf=N1*Tmax;

N2=200;dt=Tmax/N2;

t=ti:dt:tf; % vectorul momentelor de timp

N=length(t);

% ---------------------------

% Conditiile initiale (pozitii si viteze la momentul ti):

%etai1=0.01; etai2=0.01; % deplasari initiale [m]  

%etai1=0.01; etai2=-0.01; % deplasari initiale [m]

etai1=0.01; etai2=0; % deplasari initiale [m]

%vi1=0.1; vi2=0.1; % viteze initiale [m/s]

%vi1=0.1; vi2=-0.1; % viteze initiale [m/s]

vi1=0.1; vi2=0; % viteze initiale [m/s]

% -----------------------------------------

eta1=zeros(1,N); eta2=zeros(1,N); % prealocare pentru ciclu eficient

eta1(1)=etai1; eta2(1)=etai2; % valorile de la pozitia "1" in vectorii eta1 si eta2

% Calculul pozitiilor la momentul t=ti+dt: aproximari bazate pe o miscare uniforma in primul interval dt:

eta1(2)=etai1+vi1*dt; eta2(2)=etai2+vi2*dt; % valorile de la pozitia "2" in vectorii eta1 si eta2

for j=2:N-1 % j=variabila contor 

    %Relatiile de recurenta cuplate, de ordinul II (vezi C6 la sfarsit)

    eta1(j+1)=2*eta1(j)-eta1(j-1)-dt^2/m1*(ka*eta1(j)+kb*(eta1(j)-eta2(j)));

    eta2(j+1)=2*eta2(j)-eta2(j-1)-dt^2/m2*(kc*eta2(j)+kb*(eta2(j)-eta1(j)));

end

plot(t,100*eta1,'b',t,100*eta2,'--r') % eta1 si eta2 in cm

xlabel('t / s'); ylabel('\eta_{1,2} / cm')

grid

legend('\eta_1','\eta_2','location','EastOutside')

title('Legile de miscare ale oscilatorilor cuplati')