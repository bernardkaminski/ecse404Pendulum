load('values_set');

% Recurring Denominator
p = M * (r^2) * R_A;

% State Space Matrices
A = [0        0                   1                 0;
     0        0                   0                 1;
     0    -(m*g)/M      -(K_m^2)*(K_g^2)/p          0;
     0   g*deltaM/(M*l) (K_m^2)*(K_g^2)/(p*l)       0];
B = [     0;
          0;
          K_m*K_g/(p/r);
          -K_m*K_g/(p*l/r)];
C = [1 0 0 0;
     0 1 0 0];
D = [0;
     0];
 
%State Space Form of Model
states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'u'};
outputs = {'x'; 'phi'};
sys_ss = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);
 
%Determine the rank of the state space model
rankA = rank(A);
 
%Determine the system poles
Poles = eig(A);
disp('Number of poles:');
siz = size(Poles);
disp(siz(1));
disp('Pole locations:');
disp(Poles);