%{
    @file swingUpControllerODE.m
    @author Benjamin Brown (bbrown1867@gmail.com)
    @date December 11th, 2014
    @brief ODE Function handler for non-linear model equations.
%}
function [xdot]= swingUpControllerODE(t,x)
% @param x: state vector x = [x, theta, x_prime, theta_prime]'
% @param t: symbolic time variable
% @retval ODE Function handler for non-linear model equations

xdot = zeros(size(x));

%Load assumed set of values
load('const_val.mat');

%Input voltage applied to the cart
w_n = sqrt((3*g)/(2*l)); %Natural frequency of rod
%SIMPLE SWING UP: 
%A = 15; %DC supply voltage
%V = A*sin(w_n*t);
%BETTER SWING UP:
A = 10;  %DC supply voltage
V_1 = A*sin(2*w_n*t);
V_2 = -A*sin(w_n*t);
V = V_1 + V_2*heaviside(t-.5);

%Constants
c_1 = m+M;
c_2 = m*g;
c_3 = M*l;
c_4 = (K_m * K_g)/(r * R_A);
c_5 = ((K_m^2) * (K_g^2))/((r^2) * R_A);

%x_prime 
xdot(1) = x(3);
%theta_prime
xdot(2) = x(4);
%x_double_prime
num3 = c_4*V - c_5*x(3) - c_2*sin(x(2))*cos(x(2)) + c_3*((x(4))^2)*sin(x(2));
denom3 = c_1 - m*((cos(x(2)))^2);
xdot(3) = num3/denom3;
%theta_double_prime
xdot(4) = ((g*sin(x(2)))/l) - ((num3/denom3)*((cos(x(2)))/l));

end

