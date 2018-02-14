function dHdt = balloonmodel(t,y,zinputs)

% Constants in for the forward Balloon model.
kappa = 0.65; % Rate of signal decay
gamma = 0.41; % Rate of flow-dependent elimination
alpha = 0.32; % Grubb's exponent
tau = 0.98;   % Hemodynamic transit time
rho = 0.34;   % Resting oxygen extraction fraction.


% Reassining for the 
s = y(1);
f = y(2);
v = y(3);
q = y(4);


timeVector = zinputs(:,1);
% This step now interpolates the inputs onto the same sampling the simulation is at. 
% For example the inputs might be recorded at a sampling period every 10 ms, but the
% simulation might instead might have "dt" = 0.01 ms. This ensure it works by using 
% linear interpolation.

z_input = zinputs(:,2);
z = interp1(timeVector,z_input,t);




% calculate the CMRO2
E = 1 - (1-rho)^(1/f);

% use this to calculate the rate of change of all the variabes s,f,v,q at time t
dHdt(1,1) = z - kappa*s - gamma*(f-1);
dHdt(2,1) = s;
dHdt(3,1) = 1/tau*(f-v^(1/alpha));
dHdt(4,1) = 1/tau*(f/rho*E - (v^(1/alpha)*q/v));


end