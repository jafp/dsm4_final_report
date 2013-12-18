
% Part 3


clc
clear all
close all

N = 200;
order = 7;
tt = [0.95, 0.05; 0.45, 0.55];

yy = markov2st(tt, N);
%yy = yy - mean(yy);

figure(1);
stem(yy);



%figure('position', [0 0 600 200]);
%stem(yy);
%axis([0 100 -1 1])


r1 = xcorr(yy);
figure;
stem(-20:20,r1(N-20:N+20)), title(['Autocoor of 2-state Markov model']);

R = [r1(N) r1(N+1); r1(N+1) r1(N)];
r = -[r1(N+1); r1(N+2)];
a = inv(R)*r

[a1,E] = lpc(yy, order)

error = filter(real(a1),1,yy);
figure(2);
stem(error);

sig_pow = var(yy);
max_order = 20;
pg = zeros(1, max_order);

for p=1:max_order
    aa = lpc(yy, p);
    aa = real(aa);
    error = filter(aa, 1, yy);
    pg(p) = 10*log10(sig_pow/var(error(p:N)));
end

figure
stem(1:max_order, pg), title('Prediction Gain');


%[lpc_a, lpc_E] = lpc(yy, order)
%est_yy = filter([0 -my_a(1:end)'], 1, yy);
%est1_yy = filter([0 -lpc_a(2:end)], 1, yy);
%err_yy = yy - est_yy;
%err1_yy = yy - est1_yy;

%pg = 10*log10(var(yy)/var(err_yy))
%pg1 = 10*log10(var(yy)/var(err1_yy))

%figure('position', [0 0 600 200]);

%stem(est_yy);
%axis([0 100 -1 1])
%title('...')

%error = filter([0 -lpc_a(2:end)],1,yy);
%PG = 10*log10(var(yy)/var(error))
%PG_2 = 10*log10(lpc_E)

%p2 = var(error)
%p3 = lpc_E
%error_my = filter([0 -my_a(:)'],1,yy);
%PG_my = 10*log10(var(yy)/var(error_my))

%figure('position', [0 0 600 200])
%stem(err_yy)
%axis([0 100 -1 1])

%
% -----
%

%n = 10;
%pgg = []

%for i=2:n
%    a = lpc(yy, i);
%    est_yy = filter([0 -a(2:end)],1,yy);
%    e = yy - est_yy;
%    pgg(i) = 10*log10(var(yy)/var(e));
%end

%figure;
%plot(0:n, [0 pgg])




