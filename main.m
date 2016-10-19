clc;clear all;close all;
% set general variables
sf = 44100;  % sample frequency
nf = sf / 2; % nyquist frequency
d = 2.0;     % duration (time)
n = sf * d;  % number of samples
nh = n / 2;  % half number of samples
% =========================================================================
% set variables for filter
lf = 1;   % lowest frequency
hf = 6000;   % highest frequency
lp = lf * d; % ls point in frequency domain    
hp = hf * d; % hf point in frequency domain
% design filter
clc;
a = ['BANDPASS'];
filter = zeros(1, n);           % initializaiton by 0
filter(1, lp : hp) = 1;         % filter design in real number
filter(1, n - hp : n - lp) = 1; % filter design in imaginary number
% =========================================================================
% make noise
rand('state',sum(100 * clock));  % initialize random seed
noise = randn(1, n);             % Gausian noise
noise = noise / max(abs(noise)); % -1 to 1 normalization
% do filter
s = fft(noise);                  % FFT
s = s .* filter;                 % filtering
s = ifft(s);                     % inverse FFT
s = real(s);
% =========================================================================
% play noise
disp('WHITE noise');
sound(noise, sf);                % playing sound