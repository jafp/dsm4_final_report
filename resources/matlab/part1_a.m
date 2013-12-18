
% Part1 

clc
clear all
close all

t = linspace(0, 2*pi, 10000);
yy = sin(t);


figure
hist(yy)

yy_q = quant(yy, 1, 8);
SQNR_yy = 10*log10(var(yy)/var(yy-yy_q))

figure
hist(yy_q)

yc = compand(yy, 255, 1,'mu/compressor');
% pdf of compressed signal (mu-law compression)
figure
hist(yc)