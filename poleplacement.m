
function [K, poleH_1, poleT, H_1, T] = poleplacement()

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

%OPEN LOOP TF H_1
H_1 = tf([z11, z10],[p13, p12, p11, p10]);
poleH_1 = pole(H_1);

%Check what values of K make the open loop TF stable
rlocus(H_1);

%CLOSED LOOP TF DESIGN PARAMETER
K = 1.48;

%CLOSED LOOP TF T
T = tf([K*z11, K*z10], [p13, p12, (p11+K*z11), (p10+K*z10)]);
poleT = pole(T);
pzmap(T)

end