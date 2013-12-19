
clear all
close all
clc

t = linspace(0, 2*pi, 1000);
x = sin(t);
y = quant(x,0,4);

figure('position', [0 0 500 180]);
plot(t, x, 'b'), hold on, axis([0 2*pi -1 1])
plot(t, y, 'r')

q = y - x;
figure('position', [0 0 500 180]);
plot(t, q)