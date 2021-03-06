function [poleT] = pidController( Kp, Kd, Ki)

%Load assumed set of values
load('const_val.mat');

%OPEN LOOP TF H_1 Constants
B = ((K_m^2)*(K_g^2))/(M*(r^2)*R_A);
C = (K_m*K_g)/(M*r*R_A);

%OPEN LOOP TF H_1 Coefficients
z11 = C;
z10 = -C*B*(l - 1);
p13 = l;
p12 = B*l;
p11 = (-g*deltaM)/M;
p10 = (((g*B)/M)*(m*l - deltaM));




	%Explicit calculation of closed-loop TF
T = tf([z11, z10, 0], [p13, (p12+z11*Kd), (p11+z11*Kp+z10*Kd), (p10+z11*Ki+z10*Kp), z10*Ki]);
	

%Return poles of the closed loop system
poleT = pole(T);

%Display impulse response of the PID
t = 0:.01:10;
impulse(T, t);
myTitle = sprintf('Impulse Response, PID Controller: Kp = %d, Kd = %d, Ki = %d', Kp, Kd, Ki);
title(myTitle);