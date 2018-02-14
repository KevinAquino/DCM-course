% The Fourier transform (numerical example)
dt = 0.1;
time = 0.1:dt:100;
freq = 0.16;
h = sin(time*2*pi*freq) + randn(size(time))*0.1;

% Frequency
f = 1/dt*(1:length(time)/2)/length(time);
% Power spectrum
P = abs(fft(h)/length(time));

figure;
plot(time,h)
figure;
plot(f,P(1:length(time)/2))