%% Date: 
%  2022
%% Author contact: 
%  alexander.ugena@gmail.com
%% Description: 
%  Dielektriko baten permitibitate erlatiboa kalkulatzen da
%% Dependencies:
%--------------------------------------------------------------------------
%Ring resonatoaren bidez permitibitatea lortu
function epsilon_r = calc_epsilon_r(sensor)

c=299792458;
method = sensor.method;
w = sensor.w;
h = sensor.h;
fr = sensor.fr;
n = sensor.n;

%1. dielektrikoaren perm_eff lortu
 if method == 'T'
     l = sensor.l;
     epsilon_eff = (n*c/(4*l*fr))^2;
 elseif method == 'R'
     r = sensor.r;
     epsilon_eff = (n*c/(2*pi*r*fr))^2;
 else
     error('Erabilitako metodoa ez da baliagarria');
 end
 
 %2. dielektrikoaren perm_r lortu Hammerstad & Jensen metodoa erabiliz
 syms epsilon_r_aux
 u = w/h;
 a = 1+1/49*log((u^4+(u/52)^2)/(u^4+0.432))+1/18.7*log(1+(u/18.1)^3);
 b = 0.564*((epsilon_r_aux-0.9)/(epsilon_r_aux+3))^0.053;
 eq = (epsilon_r_aux+1)/2+((epsilon_r_aux-1)/2)*(1+10/u)^(-a*b)-epsilon_eff;
 epsilon_r = solve(eq, epsilon_r_aux);
end 