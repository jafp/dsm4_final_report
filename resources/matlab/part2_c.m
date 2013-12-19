

clear all
close all
clc

N = 1024;
n = linspace(0, N, N);


P1 = [0.9 0.1;
     0.1 0.9]

P2 = [0.5 0.5;
     0.5 0.5]; 

 

[t1, p, H] = markov2st(P1,N);
x1 = t1 - mean(t1);

[t2, p, H] = markov2st(P2,N);
x2 = t2 - mean(t2);




sum3=zeros(1,N);
sum4=zeros(1,N);

for R = 0:N-1

[t3, p, H] = markov2st(P1,N);
x3 = t3 - mean(t3);
[x3 a3] = xcorr(x3);

xx3 = fft(x3(N+1:N*2-1),N); 
sum3 = sum3 + xx3;

[t4, p, H] = markov2st(P2,N);
x4  = t4 - mean(t4);
[x4 a4] = xcorr(x4);
xx4 = fft(x4(N+1:N*2-1),N);
sum4 = sum4 + xx4;
end


mean3 = sum3/N;
mean4 = sum4/N;


figure('position',[0 0 600 600])
subplot(2,1,2)
plot(n(1:500), mean4(1:500))
grid on;
subplot(2,1,1)
stem(x1(1:1000))
grid on;

figure('position',[0 0 600 600])
subplot(2,1,1)
stem(x2(1:1000))
grid on;
subplot(2,1,2)
plot(n(1:500), mean3(1:500))
grid on;

