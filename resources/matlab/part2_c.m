

clear all
close all
clc

n = linspace(0, 1000, 199);

P = [0.9 0.1;
     0.1 0.9]

N = 100 ;
[t, p, H] = markov2st(P,N);

y = t-mean(t);
[yy,a] = xcorr(y);

x = fft(yy);

figure(1)
subplot(2,1,1)
stem(y)
subplot(2,1,2)
plot(n,x)

%---------------------------------------------------------------

n = linspace(0, 1000, 199)
P = [0.5 0.5;
     0.5 0.5];


N = 100 ;
[t, p, H] = markov2st(P,N);

y = t-mean(t);
[yy,a] = xcorr(y);

x = fft(yy);

figure(2)
subplot(2,1,1)
stem(y)
subplot(2,1,2)
plot(n,x)

