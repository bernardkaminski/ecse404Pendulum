
%Load in values
function [] = stability(select)
load('const_val.mat');

B = ((K_m^2)*(K_g^2))/(M*(r^2)*R_A);
C = (K_m*K_g)/(M*r*R_A);

%Transfer function 1 coefficients
z11 = C;
z10 = -C*B*(l - 1);
p13 = l;
p12 = B*l;
p11 = (-g*deltaM)/M;
p10 = (((g*B)/M)*(m*l - deltaM));

%Transfer function 2 coefficients
z22 = C;
z21 = 0;
z20 = ((-g*deltaM)/(M*l)) + ((m*g)/(M*l));
p24 = 1;
p23 = B;
p22 = ((-g*deltaM)/(M*l));
p21 = ((-B*g)/M)*(m + deltaM);
p20 = 0;

%TF H_1 = angle / voltage
H_1 = tf([z11, z10],[p13, p12, p11, p10]);
%TF H_2 = position / voltage
H_2 = tf([z22, z21, z20],[p24, p23, p22, p21, p20]);

sgrid
if (select == 1)
    pzmap(H_1)
else
    pzmap(H_2)
end

grid on

end
