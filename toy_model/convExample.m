dt = 0.1;
time = 0.1:dt:100;
ga = exp(-(time-5).^2);

figure;plot(ga)
h2 = randn(10000,1);
figure;plot(h2)
convEg = conv(ga,h2,'same');
figure;plot(convEg)