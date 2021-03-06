function [K] = LQR(pos, theta)
load('const_val.mat');

%% Credit to
% http://ctms.engin.umich.edu/CTMS/index.php?example=InvertedPendulum&section=ControlStateSpace

p = M * (r^2) * R_A;

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
 
states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'u'};
outputs = {'x'; 'phi'};
sys_ss = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);

Poles = eig(A);

Co = ctrb(sys_ss);
Ctlbility = rank(Co);
Oo = obsv(sys_ss);
Obsvbility = rank(Oo);


Q = [pos 0 0 0; 
     0 theta 0 0; 
     0 0 0 0; 
     0 0 0 0];
R = 1;


K = lqr(A,B,Q,R);

Ac = [(A-B*K)];
Bc = [B];
Cc = [C];
Dc = [D];

states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'r'};
outputs = {'x'; 'phi'};
sys_cl = ss(Ac,Bc,Cc,Dc,'statename',states,'inputname',inputs,'outputname',outputs);

t = 0:0.01:20;
r =0.2*ones(size(t));
[y,t,x]=lsim(sys_cl,r,t);
[AX,H1,H2] = plotyy(t,y(:,1),t,y(:,2),'plot');
set(get(AX(1),'Ylabel'),'String','cart position (m)')
set(get(AX(2),'Ylabel'),'String','pendulum angle (radians)')
title('Step Response with LQR Control')




end

