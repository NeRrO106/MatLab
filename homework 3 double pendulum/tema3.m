% Problema oscilatiilor cu 3 grade de libertate
% Problema oscilatorului compus din 3 corpuri si 4 resorturi

clc; clear all; close all


% Definirea unor parametri 

m1=1; m2=1; m3=1; % masele celor trei corpuri [kg]

ka=1000; kb=1000; kc=1000; kd=1000; % constantele elastice ale resorturilor [N/m]


% Stabilirea intervalului de timp pentru studiul miscarii

ti=0;


% Calculam timpi caracteristici ai sistemului folosind formula perioadei oscilatorului elastic armonic:

Ta1=2*pi*sqrt(m1/ka); % perioada proprie a corpului 1 legat de resortul a

Tb1=2*pi*sqrt(m1/kb); % perioada proprie a corpului 1 legat de resortul b

Tb2=2*pi*sqrt(m2/kb); % perioada proprie a corpului 2 legat de resortul b

Tc2=2*pi*sqrt(m2/kc); % perioada proprie a corpului 2 legat de resortul c

Tc3=2*pi*sqrt(m3/kc); % perioada proprie a corpului 3 legat de resortul c

Td3=2*pi*sqrt(m3/kd); % perioada proprie a corpului 3 legat de resortul d

Tmax=max([Ta1 Tb1 Tb2 Tc2 Tc3 Td3]); % cea mai mare dintre perioadele proprii

N1=5;tf=N1*Tmax;

N2=200;dt=Tmax/N2;

t=ti:dt:tf; % vectorul momentelor de timp

N=length(t);


% Conditiile initiale (pozitii si viteze la momentul ti):

etai1=0.03; etai2=0.05; etai3=0.07; % deplasari initiale [m]

vi1=0.1; vi2=0.1; vi3=0; % viteze initiale [m/s]


eta1=zeros(1,N); eta2=zeros(1,N); eta3=zeros(1,N); % prealocare pentru ciclu eficient

eta1(1)=etai1; eta2(1)=etai2; eta3(1)=etai3; % valorile de la pozitia "1" in vectorii eta1 si eta2


% Calculul pozitiilor la momentul t=ti+dt: aproximari bazate pe o miscare uniforma in primul interval dt:

eta1(2)=etai1+vi1*dt; eta2(2)=etai2+vi2*dt; eta3(2)=etai3+vi3*dt; % valorile de la pozitia "2" in vectorii eta1, eta2, eta3


for j=2:N-1 % j=variabila contor 

    %Relatiile de recurenta cuplate, de ordinul II 

    eta1(j+1)=2*eta1(j)-eta1(j-1)-dt^2/m1*(ka*eta1(j)+kb*(eta1(j)-eta2(j)));

    eta2(j+1)=2*eta2(j)-eta2(j-1)-dt^2/m2*(kb*(eta2(j)-eta1(j))-kc*(eta3(j)-eta2(j)));

    eta3(j+1)=2*eta3(j)-eta3(j-1)-dt^2/m3*(kd*eta3(j)+kc*(eta3(j)-eta2(j)));

end


plot(t, 100*eta1, 'c', t, 100*eta2,'--g', t, 100*eta3,'*y') % eta1, eta2, eta3 in cm

xlabel('t / s'); ylabel('\eta_{1,2,3} / cm')

grid

legend('\eta_1','\eta_2', '\eta_3','location','EastOutside')

title('Legile de miscare ale oscilatorilor cuplati')