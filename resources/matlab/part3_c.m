
% Part 3 - C

clear all
close all
clc

load LPFILTER.mat;
P=6;
N=1000;
xx=randn(1,N);
r1=xcorr(xx);

% Stem xcorr of white noise
figure('position', [0 0 500 180])
stem(-20:20,r1(N-20:N+20)), title(['Autocoor of white noise']);

% LP-filter signal
yy=filter(Num,1,xx); 
r2=xcorr(yy); 

% stem xcorr of LP-filtered white noise
figure('position', [0 0 500 180])
stem(-20:20,r2(N-20:N+20)), title(['Autocoor of LP filtered white noise']);

% lpc coefficients
[a,E]=lpc(yy,P);
a=real(a);

% Frequency response of LP-filter
figure('position', [0 0 500 180])
[H1,w]=freqz(Num,1,1000);
H2=freqz(a,1,1000);
plot(w,20*log10(abs(H1)),'b')
hold on
plot(w,20*log10(abs(H2)),'r'), grid

% Prediction gain
error = filter(a,1,yy);
PG = 10*log10(var(yy)/var(error))

% Stem xcorr of filtered signal (error)
r3 = xcorr(error);
figure('position', [0 0 500 180])
stem(-20:20,r3(N-20:N+20)), title(['Autocoor of error']);

% PG as function of order p
Maxorder=20;
PG=zeros(1,Maxorder);
sigpow=var(yy);
for p=1:Maxorder
    a=lpc(yy,p);
    a=real(a);
    error=filter(a,1,yy);
    PG(p)=10*log10(sigpow/var(error(p:N)));% not including he transient of the FIR filter of order p
end
figure('position', [0 0 500 180])
stem(1:Maxorder,PG),xlabel('Order of prediction'),ylabel('PG (dB)'),title('Prediction Gain in dB'),grid
