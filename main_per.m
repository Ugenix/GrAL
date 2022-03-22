%% Date: 
%  2022
%% Author contact: 
%  alexander.ugena@gmail.com
%% Description: 
%  Permitibitatea kalkulatzeko programa nagusia
%% Dependencies: 
%  calc_epsilon_r 
%  sensor
%% ------------------------------------------------------------------------
%Sensorea irakurri:
% Arlon25N_600MHz
%  
% %S parametroak eta maiztasuna irakurri:
% S_0 = sparameters(sensor.CST_data);
% S21_0 = rfparam(S_0,2,1);
% S21_dB_0 = mag2db(abs(S21_0));
% f0 = S_0.Frequencies;

%Sensorea irakurri:
Arlon25N_600MHz_exp
 
%S parametroak eta maiztasuna irakurri:
S_1 = sparameters(sensor.CST_data);
S21_1 = rfparam(S_1,2,1);
S21_dB_1 = mag2db(abs(S21_1));
f1 = S_1.Frequencies;

%S parametroak irudikatu:
plot(f0,S21_dB_0,f1,S21_dB_1);
legend('CST','Experimental','Interpreter','Latex');
title('Arlon 25N','Interpreter','Latex');
xlabel('f (MHz)','Interpreter','Latex');
ylabel('$S_{21}$ (dB)','Interpreter','Latex');

%Permitibitate erlatiboa kalkulatu:
epsilon_r = calc_epsilon_r(sensor);


%TODO tan(delta)-ren kalkulua falta da
