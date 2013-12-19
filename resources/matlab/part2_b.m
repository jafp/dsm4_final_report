
clear all;
close all;
clc;
format long

%2. order Markov model med 2 states



p00 =0.92;
p10 =0.08;
p01 =0.12;
p11 =0.88;


ma = [p00 p10 ;
      p01 p11]
N = 100;
[x,p,H]=markov2st(ma,N);


%trækker DC fra.
xx = x-mean(x);

[y a] = xcorr(xx);

figure('position',[0 0 600 600])
subplot(2,1,1)
stem(xx)
grid on
subplot(2,1,2)
stem(a , y)
grid on

Hx0 = p00*log2(1/p00)+p10*log2(1/p10)
Hx1 = p01*log2(1/p01)+p11*log2(1/p11)

syms p0 p1

[p0,p1] = solve(p00*p0+p01*p1 == p0, p10*p0+p11*p1 == p1, p0+p1 == 1)

format long
Hx = Hx0*p0 + Hx1*p1 



