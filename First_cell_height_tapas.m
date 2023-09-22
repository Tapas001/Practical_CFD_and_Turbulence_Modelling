
clc;
clear;
% Tapas Kumar Pradhan (pradha31@uwindsor.ca)
% Reference - https://www.fluidmechanics101.com/pages/tools.html
%% 1st cell height Calculator
prompt0 = 'Enter the density of the fluid (in kg/m^3):';
p = input(prompt0);
prompt1 = 'Enter the dynamic viscosity of the fluid (in kg/(m.s)):';
u = input(prompt1);
prompt2 = 'Enter the free stream velocity of the fluid (in m/s):';
v = input(prompt2);
prompt3 = 'Enter the reference length or diameter (in m):';
l = input(prompt3);
Re = p*v*l/u;
var Cf;
Cf = (2*log10(Re)-0.65)^(-2.3);
T = 0.5*Cf*p*v^2;
Uf = (T/p)^0.5;
prompt5 = 'Enter the desired value for Y+ (Y+ =30-300 for k-epsilon model with wall functions, Y+ <=1 for k-omega):';
Yp = input(prompt5);
format long;
ds = Yp*u/(Uf*p); % half of the 1st cell height
Yh = 2*ds;
disp('Reynolds Number of the flow is:'); disp(Re);
disp('First cell height is:'); disp(Yh);
%% Growth rate calculator
% A good growth rate should be between 1.05 to 1.3, the best one is 1.16
syms g
%defines a symbolic variable g
% y_99 is the total thickness layer = thickness of viscous region
if (Re < 5.0e5)
    y_99 = (4.91*l)/((Re)^0.5);
else
    y_99 = (0.38*l)/((Re)^0.2);
end
L = y_99;
prompt4= 'Enter the number of Layers:';
n=input(prompt4);
eq=Yh*((1-g^n)/(1-g))==L;
%Since L = ds + ds*GR + ds*GR^2 + ds*GR^3 +....+ GR^n-1 => L =
%ds*(1+GR+GR^2+GR^3+....GR^n-1). We use the formula for the sum of the
%finite series to get the above equation
g=double(solve(eq,g));
%Gets values for the growth rate in decimal form
g = g(real(g)>0&imag(g)==0)
%selects only positive real number(s) from the many roots of the equation
%% solving for number of layers calculator
% If n > 10, Yplus =~ 30
% If n > 25, Yplus =~ 1
syms n
%defines a symbolic variable n
% y_99 is the total thickness layer = thickness of viscous region
if (Re < 5.0e5)
    y_99 = (4.91*l)/((Re)^0.5);
else
    y_99 = (0.38*l)/((Re)^0.2);
end
L = y_99;
prompt4 = 'Enter the growth rate:';
g =input(prompt4); % A good growth rate is in between 1.05 to 1.3
eq=Yh*((1-g^n)/(1-g))==L;
%Since Ytotal = ds + ds*GR + ds*GR^2 + ds*GR^3 +....+ GR^n-1 => L =
%Yh*(1+GR+GR^2+GR^3+....GR^n-1). We use the formula for the sum of the
%finite series to get the above equation
n=double(solve(eq,n));
%Gets values for the growth rate in decimal form
n = n(real(n)>0&imag(n)==0)
%selects only positive real number(s) from the many roots of the equation
