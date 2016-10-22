function main()

prompt = {'What is the duration of the noise (in seconds)?', ...
'What is the lower bound of the narrowband filter (in Hz)?', ...
'What is the upper bound of the narrowband filter (in Hz)?'};
% answer = inputdlg(prompt);
transform = str2double(answer);

% set general variables
sf = 20001;  % sample frequency
d = transform(1);     % duration (time)
n = sf * d;  % number of samples
% =========================================================================
% set variables for filter
lf = transform(2);   % lowest frequency
hf = transform(3);   % highest frequency
lp = lf * d; % ls point in frequency domain    
hp = hf * d; % hf point in frequency domain
% design filter
% clc;
a = 'BANDPASS';
filter = zeros(1, n);           % initializaiton by 0
filter(1, lp : hp) = 1;         % filter design in real number
filter(1, n - hp : n - lp) = 1; % filter design in imaginary number
% =========================================================================
% make noise
% rand('state',sum(100 * clock));  % initialize random seed
noise = randn(1, n);             % Gausian noise
noise = noise / max(abs(noise)); % -1 to 1 normalization
% do filter
s = fft(noise);                  % FFT
s = s .* filter;                 % filtering
s = ifft(s);                     % inverse FFT
s = real(s);
% =========================================================================
% play noise
% clc;
disp([a, ' noise']);
% sound(s, sf);              % playing sound