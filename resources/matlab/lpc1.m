%LPC Coding example; fs assumed 8kHz, order p=12
%supply your own speech sequence - here I use 'oak.wav'
clear all
close all
xx1=wavread('oak.wav');
fs=8000;
xx1=xx1-mean(xx1); % No DC
xx=filter([1 -0.95],1,xx1); % preemphasis - 6dB roll off of exitation equalized

L=length(xx);
M=input('distance between frames in msec: ');
N=input('Frame length in msec: ');
antal =floor(L/(M*fs/1000)-2);
ss(N*fs/1000,antal)=0;% Always a good thing to make room for a variable in memory first
ss(:,1)=xx(1:N*fs/1000);% fs=8 ( in kHz)
for k=2:antal
    ss(:,k)=xx((k-1)*M*fs/1000+1:((k-1)*M+N)*fs/1000);
end

framenr=input('frame number for analysis:  ');
for k=1:antal
zz(:,k)=ss(:,k).*hamming(N*fs/1000);
end
[a,pow]=lpc(zz,12); % change order here
% note that a complex a-matrix is produced! Very inconvenient
%a=real(a');
a=a'; %( conjugate to get column-vector a-coefficients)
for k=1:antal
errormatrix(:,k)=filter(a(:,k),1,zz(:,k));
end
zzp=zz-errormatrix;

figure(1)
subplot(3,1,1)
stem(zz(:,framenr)),title(['frame number; ',num2str(framenr)]);
subplot(3,1,2)
stem(errormatrix(:,framenr)),title('error signal')
subplot(3,1,3)
zzp(:,framenr)=zz(:,framenr)-errormatrix(:,framenr); % 
stem(zzp(:,framenr)),title('Predicted signal frame')
figure(2)
[H,w]=freqz(1,real(a(:,framenr)),1000);%Vocal tract Freq.Response-note the formants
plot(w/2/pi*8000,20*log10(abs(H))), xlabel('Hz'),title('Vocal Tract Freq. response + fft of frame')
hold on
ERR=fft(errormatrix(:,framenr));
ZZ=fft(zz(:,framenr));% as |X|/|error| = 
nn=0:N*fs/1000/2-1;
stem(nn*1000/N,20*log10(abs(ZZ(1:N*fs/1000/2))));
hold off
figure(3)
stem(nn*1000/N,20*log10(abs(ERR(1:N*fs/1000/2)))), title('error-fft');
% construction of the total predicted signal
pred1=zzp(1:(N+M)/2*fs/1000); % first frame is different from the others, œ of the overlap is taken along
pred(M*fs/1000,antal-1)=0;
for q=1:antal-1,
    pred(:,q)=zzp((N-M)/2*fs/1000+1:((N-M)/2+M)*fs/1000,q+1);
end
pred2=pred(:)';
collpred=[pred1 pred2];
figure(4)
subplot(2,1,1)
nn=1:length(xx);
stem(nn/fs,xx),xlabel('sec'),title('lunch.wav')
subplot(2,1,2)
nn=1:length(collpred);
stem(nn/fs,collpred),title('the predicted signal in total') %try to listen - the pitch spikes in the error are heard metalically
% pitch considerations - we'll examine some windows for pseudo-periodicity
load Num; %here yuo find the LP coeffs in variable Num
%lpcoeff=dlmread('coeffs.dat') %in workspace
zzzp=filter(Num,1,zzp(:,framenr));
% LP-filter - only pitch, not vocal tract
zzcor=xcorr(zzzp);
figure(5)
nn=(0:N*fs/1000-1);
stem(nn/fs*1000,zzcor(N*fs/1000:2*N*fs/1000-1)),xlabel('msec'),title(['autokorr. funktion  ',num2str(framenr)])