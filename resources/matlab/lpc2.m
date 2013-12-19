% adding memory to a memoryless time series of the process randn(1,N)
close all
clear all
load LPFILTER.mat % a saved LP filter, fpass=fs/16, fstop=fs/3, Rstop=-80 dB
N=1000;
xx=randn(1,N);
r1=xcorr(xx);
figure(1)
subplot(2,1,1)
stem(-20:20,r1(N-20:N+20)), title(['Autocoor of randn(1,',num2str(N),')']);
yy=filter(Num,1,xx); %lowpass, fpass =1/4, fstop =1/5  ( in units of fs), Rs=-50 dB
r2=xcorr(yy); %autocorr of low-pass filterd randn-sequence
subplot(2,1,2)
stem(-20:20,r2(N-20:N+20)), title(['Autocoor of LP filtered randn(1,',num2str(N),')']);
figure(2)
subplot(3,1,1)
stem(xx(200:300)), title('excerpts of the time series randn')
subplot(3,1,2)
stem(yy(200:300)),title('excerpts of the lowpass filtered time series randn')
%We will try to make a prediction of yy
P=5; % chosen order
[a,E]=lpc(yy,P);
a=real(a);
error=filter(a,1,yy);
subplot(3,1,3)
maxim=max(abs(yy));
stem(error(200:300)),title(['Prediction error, order= ',num2str(P)]),axis([0,120,-maxim,maxim])
r3=xcorr(error);
figure(3)
subplot(2,1,1)
stem(-20:20,r3(N-20:N+20)),title('Autocorr of error')
subplot(2,1,2)
stem(-20:20,r2(N-20:N+20)),title(['Autocoor of LP filtered randn(1,',num2str(N),')']);
Maxorder=20;% preparing for a graph PG as function of order p
PG=zeros(1,Maxorder);
sigpow=var(yy);
for p=1:Maxorder
    a=lpc(yy,p);
    a=real(a);
    error=filter(a,1,yy);
    PG(p)=10*log10(sigpow/var(error(p:N)));% not including he transient of the FIR filter of order p
end
figure(4)
stem(1:Maxorder,PG),xlabel('Order of prediction'),ylabel('PG (dB)'),title('Prediction Gain in dB'),grid
[H1,w]=freqz(Num,1,1000);
figure(5)
H2=freqz(a,1,1000);
plot(w,20*log10(abs(H1)),'b'),xlabel('norm. rad.'),ylabel('dB'),title('LP filter and Prediction filter together')
hold on
plot(w,20*log10(abs(H2)),'r'), grid
%gtext('prediction filter')
%gtext('LP filter')
%gtext('Approx. PG')
hold off
YY=fft(yy,4*N); 
ER=fft(error,4*N);
figure(6)
w=pi/(4*N)*(0:4*N-1);
plot(w,20*log10(abs(YY))),xlabel('Norm. rad.'),ylabel('dB')
hold on
plot(w,20*log10(abs(ER)),'r')
%gtext('signal fft')
%gtext('error fft')
