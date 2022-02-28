clc;
close all;
clear all;

load('F3_HTFIN.mat');

n = 1690;
scans = 1:1:length(A);
brass1 = A(:,1);
brass2 = A(:,2);
brass3 = A(:,3);
brass4 = A(:,4);
brass5 = A(:,5);
copper1 = A(:,6);
copper2 = A(:,7);
copper3 = A(:,8);
copper4 = A(:,9);
copper5 = A(:,10);
steel1 = A(:,11);
steel2 = A(:,12);
steel3 = A(:,13);
steel4 = A(:,14);
steel5 = A(:,15);
aluminum1 = A(:,16);
aluminum2 = A(:,17);
aluminum3 = A(:,18);
aluminum4 = A(:,19);
aluminum5 = A(:,20);

e = 0.5;
error1 = zeros(1,n);
for i = 1:length(error1)
   if mod(i,200) == 0
       error1(i) = e;
   else
       error1(i) = NaN;
   end
end

error2 = zeros(1,length(A)-n+1);
for i = 1:length(error2)
   if mod(i,200) == 0
       error2(i) = e;
   else
       error2(i) = NaN;
   end
end

r = '#A2142F';
g = '#77AC30';
b = '#0072BD';
m = '#7E2F8E';

% Free Convection - Figure 1
figure(1);
sgtitle('Free Convection');

subplot(2,2,1)
hold on
title('Brass');
xlabel('Scan Number');ylabel('Temperature (°C)');
errorbar(brass1(1:n),error1);
errorbar(brass2(1:n),error1);
errorbar(brass3(1:n),error1);
errorbar(brass4(1:n),error1);
errorbar(brass5(1:n),error1);
legend('T1','T2','T3','T4','T5');
hold off

subplot(2,2,2)
hold on
title('Copper');
xlabel('Scan Number');ylabel('Temperature (°C)');
errorbar(copper1(1:n),error1);
errorbar(copper2(1:n),error1);
errorbar(copper3(1:n),error1);
errorbar(copper4(1:n),error1);
errorbar(copper5(1:n),error1);
legend('T1','T2','T3','T4','T5');
hold off

subplot(2,2,3)
hold on
title('Steel');
xlabel('Scan Number');ylabel('Temperature (°C)');
errorbar(scans(n:end),steel1(n:end),error2);
errorbar(scans(n:end),steel2(n:end),error2);
errorbar(scans(n:end),steel3(n:end),error2);
errorbar(scans(n:end),steel4(n:end),error2);
errorbar(scans(n:end),steel5(n:end),error2);
legend('T1','T2','T3','T4','T5');
hold off

subplot(2,2,4)
hold on
title('Aluminum');
xlabel('Scan Number');ylabel('Temperature (°C)');
errorbar(scans(n:end),aluminum1(n:end),error2);
errorbar(scans(n:end),aluminum2(n:end),error2);
errorbar(scans(n:end),aluminum3(n:end),error2);
errorbar(scans(n:end),aluminum4(n:end),error2);
errorbar(scans(n:end),aluminum5(n:end),error2);
legend('T1','T2','T3','T4','T5');
hold off

% Forced Convection - Figure 2
figure(2);
sgtitle('Forced Convection');

subplot(2,2,1)
hold on
title('Brass');
xlabel('Scan Number');ylabel('Temperature (°C)');
errorbar(scans(n:end),brass1(n:end),error2);
errorbar(scans(n:end),brass2(n:end),error2);
errorbar(scans(n:end),brass3(n:end),error2);
errorbar(scans(n:end),brass4(n:end),error2);
errorbar(scans(n:end),brass5(n:end),error2);
legend('T1','T2','T3','T4','T5');
hold off

subplot(2,2,2)
hold on
title('Copper');
xlabel('Scan Number');ylabel('Temperature (°C)');
errorbar(scans(n:end),copper1(n:end),error2);
errorbar(scans(n:end),copper2(n:end),error2);
errorbar(scans(n:end),copper3(n:end),error2);
errorbar(scans(n:end),copper4(n:end),error2);
errorbar(scans(n:end),copper5(n:end),error2);
legend('T1','T2','T3','T4','T5');
hold off

subplot(2,2,3);
hold on
title('Steel');
xlabel('Scan Number');ylabel('Temperature (°C)');
errorbar(steel1(1:n),error1);
errorbar(steel2(1:n),error1);
errorbar(steel3(1:n),error1);
errorbar(steel4(1:n),error1);
errorbar(steel5(1:n),error1);
legend('T1','T2','T3','T4','T5');
hold off

subplot(2,2,4);
hold on
title('Aluminum');
xlabel('Scan Number');ylabel('Temperature (°C)');
errorbar(aluminum1(1:n),error1);
errorbar(aluminum2(1:n),error1);
errorbar(aluminum3(1:n),error1);
errorbar(aluminum4(1:n),error1);
errorbar(aluminum5(1:n),error1);
legend('T1','T2','T3','T4','T5');
hold off

% brass_free = A(1100,1:5)
% copper_free = A(1100,6:10)
% steel_free = A(2660,11:15)
% aluminum_free = A(2660,16:20)
% 
% brass_forced = A(2660,1:5)
% copper_forced = A(2660,6:10)
% steel_forced = A(1100,11:15)
% aluminum_forced = A(1100,16:20)

