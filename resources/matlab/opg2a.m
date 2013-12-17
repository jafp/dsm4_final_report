close all;
clear all;
clc


x = rand(1,1000)-0.5;

%trækker mean value fra.
xx = x-mean(x);

y = xcorr(x);






figure(1)
subplot(3,1,1)
stem(x)
subplot(3,1,2)
stem(xx)
subplot(3,1,3)
stem(y)