%% Date: 
%  2022
%% Author contact: 
%  alexander.ugena@gmail.com
%% Description: 
%  Erresonadorearen diseinurako programa nagusia
%% Dependencies: 
%  resonator
%% ------------------------------------------------------------------------

%Ring resonator MAIN programa
%Lehenengo datuak sartu behar ditugu
prompt = 'Dielektrikoaren lodiera mm-tan(h):';
h_mm = input(prompt);

prompt = 'Substratuaren lodiera mm-tan(t):';
t_mm = input(prompt);

prompt = 'Dielektrikoaren permitibitatea:';
epsilon_r_teo = input(prompt);

prompt = 'Dielektrikoaren erresonantzia maiztasuna GHz-tan (Fr):';
fr_GHz = input(prompt);

prompt = 'Dielektrikoaren inpedeantzia (Z0):';
Z0 = input(prompt);

prompt = 'Erabiliko den metodoa (T edo R):';
method = input(prompt, 's');

prompt = 'Dielektrikoaren erresonantzia maiztasunaren modua (n):';
n = input(prompt);

h = h_mm*1e-3;
fr = fr_GHz*1e9;
correction = true; %galdetu mireni

%Resonadorearen dimentsioak kalkulatuz
[w, epsilon_eff, l, r] = resonator(n, h, epsilon_r_teo, fr, Z0, method, correction);
switch method
    case 'T'
        resonadorea = ['Gure resonadorea ',method,' motakoa izango da eta bere dimentsioak hurrengoak dira: w=',num2str(w),'mm eta l=',num2str(l),'mm.'];
    case 'R'
        resonadorea = ['Gure resonadorea ',method,' motakoa izango da eta bere dimentsioak hurrengoak dira: w=',num2str(w),'mm eta r=',num2str(r),'mm.'];
end
disp(resonadorea) %Behin hau izanda sentsorearen .m sortu!!!
