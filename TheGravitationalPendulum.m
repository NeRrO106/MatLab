function file_3_pendul_matematic

%Pendulul matematic

%Un pendul matematic de lungime L=1 m este initial deviat sub unghiul theta0. Pendulul este lasat liber. 

%Sa se reprezinte grafic dependenta de timp a unghiului de deviatie fata de pozitia de echilibru

%in urmatoarele situatii:

%1. theta0d=4 grade. Se va reprezenta grafic solutia numerica si solutia analitica in aproximatia unghiurilor mici.

%2. theta0d=30 grade, 60 grade, 90 grade

%-------------------------------------------------------------------------------------------------------------------

clc;clear all;close all

%---------------------------------------------------------------------------------------------------------------------

g=9.80665; %acceleratia gravitationala standard; m/s^2

L=1; %lungimea pendulului; m

%----------------------------------------------------------------------------------------------------------------------

omega0=sqrt(g/L); % pulsatia micilor oscilatii ale pendulului; rad/s

T0=2*pi/omega0; %perioada micilor oscilatii ale pendulului; s

%T0 furnizeaza o estimare a perioadei de oscilatie in cazul oscilatiei cu amplitudine mare

%---------------------------------------------------------------------------------------------------------------------

%Studiem miscarea de la tmin pana la tmax:

tmin=0;N1=3;tmax=N1*T0;

N2=200;Deltat=T0/N2; %Pentru integrarea numerica, T0 este impartit in N2 intervale Deltat 

t=tmin:Deltat:tmax;N=length(t);%N=numarul de puncte ale discretizarii 

%---------------------------------------------------------------------------------------------------------------------

%1. theta0d=4 grade

theta0d=4; %grade

subplot(211)

%Solutie numerica

theta0=theta0d*pi/180; %rad

theta = pendul(theta0,N,omega0,Deltat);thetad=theta*180/pi;plot(t,thetad,'r')

%Solutia analitica in aproximatia unghiurilor mici 

hold on;plot(t,theta0d*cos(omega0*t),'--g')

xlim([tmin tmax])

xlabel('{\it{t}} / s')

ylabel('{\it\theta} / \circ')

legend('solutia numerica','aproximatia micilor oscilatii','Location','EastOutside')

title('Oscilatiile unui pendul matematic de lungime {\it{L}}=1 m lasat liber la unghiul de deviatie {\it\theta}_0=4\circ')

%----------------------------------------------------------------------------------------------------------------------------

%2. theta0d=30 grade, 60 grade, 90 grade

subplot(212)

theta0d_vector=[30 60 90]; %grade

theta0_vector=theta0d_vector*pi/180; %rad

culoare=['b' 'g' 'r'];

hold on

for i=1:3

    theta = pendul(theta0_vector(i),N,omega0,Deltat);

    plot(t,theta,'color',culoare(i))

end

xlim([tmin tmax])

xlabel('{\it{t}} / s')

ylabel('{\it\theta} / \circ')

legend('\theta_0=30\circ','\theta_0=60\circ','\theta_0=90\circ','Location','EastOutside')

title('Oscilatiile unui pendul matematic de lungime {\it L}=1 m lasat liber la unghiul de deviatie {\it\theta}_0')

end





function theta = pendul(theta0,N,omega0,Deltat)

    theta(1)=theta0; %conditia initiala pentru theta

    theta(2)=theta(1); %rezulta din conditia vinitial=0

    for i=2:N-1

      theta(i+1)=2*theta(i)-theta(i-1)-(omega0*Deltat)^2*sin(theta(i));

    end

end