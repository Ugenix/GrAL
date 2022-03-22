%% Date: 
%  2022
%% Author contact: 
%  alexander.ugena@gmail.com
%% Description: 
%  Erresonadore baten dimentsioak kalkulatzen dira.
%% Dependencies:
%--------------------------------------------------------------------------

function [w, epsilon_eff, l, r] = resonator(n, h, epsilon_r_teo, fr, Z0, method, correction)

c = 299792458;
%w ----> microstripline-aren lodiera
%l ----> T resonadorearen luzeera
%r ----> Ring resonadorearen erradioa

%Hammerstad (SAF apunteak) errorea %1 ; beste metodo bat epsilon_eff
%lortzeko errorea %0,2 duena (Hammerstad & Jensen), baina hamendik lodiera
%lortzen da.
for w = 100e-6 : 10e-9 : 10e-3 %Lodiera  kalkulatuz
    if w/h < 1
        epsilon_eff_2 = 0.5*(epsilon_r_teo+1)+0.5*(epsilon_r_teo-1)*((1+12*(h/w))^(-0.5)+0.04*(1-(w/h))^2);
        Z0_ref = (60/(sqrt(epsilon_eff_2))*log(8*h/w+0.25*w/h));
        if Z0_ref < Z0
            break;
        end
        
    else
        epsilon_eff_2 = 0.5*(epsilon_r_teo+1)+0.5*(epsilon_r_teo-1)*((1+12*(h/w))^(-0.5));
        Z0_ref = (120*pi)/(sqrt(epsilon_eff_2)*((w/h)+1.393+(2/3)*log(w/h+1.444)));
        if Z0_ref < Z0
            break;
        end
    end
end

%Hammerstad & Jensen metodoa epsilon_eff kalkulatzeko
%errorea %0,2 epsilon_r < 128 eta 0,01 <= w/h <= 100 denean
u = w/h;
a = 1+1/49*log((u^4+(u/52)^2)/(u^4+0.432))+1/18.7*log(1+(u/18.1)^3);
b = 0.564*((epsilon_r_teo-0.9)/(epsilon_r_teo+3))^0.053;
epsilon_eff = (epsilon_r_teo+1)/2+(epsilon_r_teo-1)/2*(1+10/u)^(-a*b);

%T eta Ring resonadorearen luzeeren kalkuluak
if method == 'T' %T resonator
    l = n*c/(4*fr*sqrt(epsilon_eff));
    if correction %miren galdetu!!!
        k1 = 0.434907*((epsilon_e^0.81 + 0.26)/(epsilon_e^0.81 - 0.189))*(((w/h)^0.8544 + 0.236)/((w/h)^0.8544 + 0.87));
        k2 = 1+u^0.371/(2.358*perm+1);
        k3 = 1+0.5274*atan(0.084*u^(1.9413/k2))/perm_e^0.9236;
        k4 = 1+0.0377*(6-5*exp(0.036*(1-perm)))*atan(0.067*u^1.456);
        k5 = 1-0.218*exp(-7.5*u);
        dl = k1*k3*k5/k4*h;
        l = l-dl;
    end
    l = l*1e3;
    r = '~';
else %Ring resonator
    r = n*c/(2*pi*fr*sqrt(epsilon_eff));
    r = r*1e3;
    l = '~';
end

w = w*1e3;

end