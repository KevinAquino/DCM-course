% Convolution analyses

dt = 0.01;
time = dt:dt:100;

% This here just shifts the kernel so that it is centered at zero (needed for convolutions its important)
time2 = time-time(end)/2;
ga = exp(-(time2-5).^2);


figure('color','white');

subplot(131)
h2 = randn(10000,1);
plot(time,h2)
xlabel('time');
set(gca,'fontSize',18);

subplot(132)
plot(time2,ga)
xlabel('time');
set(gca,'fontSize',18);


subplot(133)
convEg = conv(h2,ga,'same');
plot(time,convEg)
xlabel('time');
set(gca,'fontSize',18);

% Fourier analyses 

figure('color','white');

subplot(132)
N = 100;
f = 1/N*(0:(N-1)/2)/FS;
FT = abs(fft(ga)).^2;
FT2 = FT;
plot(f,FT(1:N/2));xlabel('frequency (Hz)');ylabel('Power');


subplot(131)
FS = 1/dt;
N = length(time);
f = 1/N*(0:(N-1)/2)/FS;
FT = abs(fft(h2)).^2;
FT1 = FT;
plot(f,FT(1:N/2));xlabel('frequency (Hz)');ylabel('Power');


subplot(133)
N = 10000;
f = 1/N*(0:(N-1)/2)/FS;
FT = abs(fft(convEg)).^2;
plot(f,FT(1:N/2));xlabel('frequency (Hz)');ylabel('Power');
hold on
RES = FT1(:).*FT2(:);
plot(f,RES(1:N/2),'r');