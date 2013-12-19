% pitch exited encoder
clear all
close all
[xx1,fs,Nbits]=wavread('oak.wav');
xx1=xx1-mean(xx1); % No DC
xx=filter([1 -0.95],1,xx1); % preemphasis - 6dB roll off of exitation equalized


L=length(xx);

frametime=input('distance between frames in msec: ');%This is the real framelength

framelength=input('Frame length in msec: ');
M=round(frametime*fs/1000);% samples in a transmitted frame
N=round(framelength*fs/1000);% samples in an analysis frame, N>M for overlap
antal =floor(L/M-1);% number of frames in the transmission

inframe(N,antal)=0;% Always a good thing to make room for a variable in memory first

inframe(:,1)=[zeros((N-M)/2,1); xx(1:(N+M)/2)].*hamming(N);% fs=8 ( in kHz), the first analysis frame

for k=2:antal

    inframe(:,k)=xx((k-1)*M+1:(k-1)*M+N).*hamming(N);% and the remaining frames, ordered as columns in matrix inframe

end % and this concludes the windowed overlapping frames, arranged in a matrix
nstart=floor(3*10^-3*fs);% correspond to 3 msec

P=10;   %prediction order
[a G]=lpc(inframe,P);%Here I get the a coefficients for each frame, ordered in a matrix - and a vector of error powers
a=real(a);% -as usual
for k=1:antal
   error(:,k)=filter(a(k,:),1,inframe(:,k));%error computation for each frame
end 
corrmat=inframe-error;% the prediction for each frame
corr=zeros(2*N-1,antal);
for m=1:antal
   corr(:,m)=xcorr(corrmat(:,m),'coeff');%normalized correlation on predicted signal frames
end
% get rid of the left side correlation
% + 24: start sample for pitch search 3 msec from 0
[cmax,k]=max(corr(N+nstart:2*N-1,:));% and here the max value is found an the k value of the max
for i=1:antal
   l=0;
   while (N+nstart+k(i)+l+2<2*N-1)&(cmax(i)-1/3*(corr(N+nstart+k(i)+l-4,i)+corr(N+nstart+k(i)+l-3,i)+corr(N+nstart+k(i)+l-2,i))<0)
      l=l+1;
      [cmax(i),k(i)]=max(corr(N+nstart+l:2*N-1,i));
   end % check if the max is a local one, too
   k(i)=k(i)+l+nstart-1;
end  % correct pitch period this way to avoid max in 3msec sloping down
voiced=cmax>0.25&k<15*10^-3*fs&k>3*10^-3*fs+3; %a vector of zeros and ons: voiced frame: 1, unvoiced: 0