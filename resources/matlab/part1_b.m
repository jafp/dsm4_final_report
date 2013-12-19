
% Final Project in Digital Signal Processing and Mathematics 4
% By Andre D. B. Christensen and Jacob A. F. Pedersen

clc
clear all
close all

[yy, Fs, nbits] = wavread('oak.wav');
%sound(yy, Fs);

% Remove any DC by subtracting the mean of the signal, from
% the signal itself
yy = yy - mean(yy);

% Normalize
yy = yy / max(abs(yy));

yy_q = quant(yy, 1, 12);
SQNR_yy = 10*log10(var(yy)/var(yy-yy_q))

% pdf of normalized signal
figure('position', [0 0 600 200])
hist(yy)
title('Normalized signal');

yc = compand(yy, 255, 1,'mu/compressor');
% pdf of compressed signal (mu-law compression)
figure('position', [0 0 600 200])
hist(yc)
title('Companded signal');

% Quantize
yc_q = quant(yc, 1, 12);

yc_qe = compand(yc_q, 255, 1, 'mu/expander');
% pdf of expanded signal (mu-law expanding)
figure('position', [0 0 600 200])
hist(yc_qe);
title('Expanded signal (fra companded signal)');

%sound(yy, Fs);
%pause(length(yy) / Fs);
%sound(yc_qe, Fs);

%SQNR = 10*log10(var(yy)/var(yy-yq))
SQNR_companded = 10*log10(var(yc)/var(yc-yc_q))

ent_yy = entropy(yy)
ent_yc = entropy(yc)
ent_yc_q = entropy(yc_qe)

