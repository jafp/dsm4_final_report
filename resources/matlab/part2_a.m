close all;
clear all;
clc

%Med 

x = rand(1,100)-0.5;

%trækker mean value fra.
xx = x-mean(x);

[y a] = xcorr(x);
yy = y;

N = 100;

for R = 1:N
    yy = yy + xcorr(rand(1,100)-0.5); 
end    

yy = yy / N;

   
figure('position',[0 0 600 600])

subplot(3,1,1)
stem(xx)
grid on
subplot(3,1,2)
stem(a , y)
grid on
subplot(3,1,3)
stem(a , yy)
grid on
title('swsw')
%Med randn 

x = randn(1,100)-0.5;

%trækker mean value fra.
xx = x-mean(x);

[y a] = xcorr(x);
yy = y;

N = 100;

for R = 1:N
    yy = yy + xcorr(rand(1,100)-0.5); 
end    

yy = yy / N;

   
figure('position',[0 0 600 600])
subplot(3,1,1)
stem(xx)
grid on
subplot(3,1,2)
stem(a , y)
grid on
subplot(3,1,3)
stem(a , yy)
grid on

%2. order Markov model med 3 states uden hukommelse

P = [0.5 0.5  ;
      0.5 0.5  ];
N = 100;

[x,p,H]=markov2st(P,N);



%trækker mean value fra.
xx = x-mean(x);

[y a] = xcorr(xx);
yy = y;


for R = 1:N
    
    [z,p,H] = markov2st(P,N);
    zz = z-mean(z);
    yy = yy + xcorr(zz); 
end    

%yy = yy / N;

   
figure('position',[0 0 600 600])
subplot(3,1,1)
stem(x)
grid on
subplot(3,1,2)
stem(a , y)
grid on
subplot(3,1,3)
stem(a,  yy)
grid on


%-----------------------------------------------------------------------------
%2. order Markov model med 3 states med hukommelse

P = [0.9 0.1  ;
      0.1 0.9  ];
N = 100;

[x,p,H]=markov2st(P,N);



%trækker mean value fra.
xx = x-mean(x);

[y a] = xcorr(xx);
yy = y;


for R = 1:N
    
    [z,p,H] = markov2st(P,N);
    zz = z-mean(z)
    yy = yy + xcorr(zz); 
end    

yy = yy / N;

   
figure('position',[0 0 600 600])
subplot(3,1,1)
stem(x)
grid on
subplot(3,1,2)
stem(a , y)
grid on
subplot(3,1,3)
stem(a , yy)
grid on

