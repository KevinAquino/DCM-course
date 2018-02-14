% Taking the simuatilon from Friston et al. 2014

clear all;
% Nodes = V1, V5, LOC, PPC, FEF, PFC
A = [-0.5 1.05 0 0 0 0;0.2 -0.5 -0.21 0 0 0; 0 0.27 -0.5 0.93 0 0;0 0 0.21 -0.5 -0.33 0; 0 0 0 0.83 -0.5 -0.63; 0 0 0 0 0.51 -0.5];
regions = {'V1','V5','LOC','PPC','FEF','PFC'};

% Dont include inputs as endogenous activity
C = zeros(6,1); 

% now solve the DE
simulationTime = [0:.5:400];

% calcualte the stoschastic term
inputs = [0 0];

% Adding them all together for the stochastic DCM so that the responses are not too high (this is a term that has to be estimated)
stochasticAmplitude = 0.01;
g = @(t,z) stochasticDCMterm(t,z,C,inputs,stochasticAmplitude);

% Initial conditions
z_0 = zeros(6,1);

% now solve the SDE
[z_output] = sde_euler(@(t,z) bilinearModel(t,z,A,C,inputs),g,simulationTime,z_0);

% now solve the hemodynamic equations for each region one at a time.
bold_simulation_time = simulationTime;

for region=1:length(regions);	
	% The first two colums of the input vector contain the time that the simulation was evaluated at and then the input respectively
	zinputs(:,1) = simulationTime;
	zinputs(:,2) = z_output(:,region);%/max(z_output(:,region));
	H_0 = [0;1;1;1]; % The hemodynamic initial condtitons for s,f,v,q respectively

	% Now solving the differential equations
	[bold_simulation_time H] = ode45(@(t,y) balloonmodel(t,y,zinputs),bold_simulation_time,H_0);

	% Take the hidden variables of the hemodynamic model to produce the BOLD response (its a simple equation)
	BOLD = observation_equation(H);

	% Now save the outputs together.
	bold_outputs(:,region) = BOLD;
end

figure('color','white');
counter = 1;
for region=1:length(regions);
	subplot(6,2,counter);
	counter = counter+1;
	plot(simulationTime,z_output(:,region));
	title(regions{region});
	xlabel('t (s)');ylabel('z(t)');
	set(gca,'fontSize',12);

	subplot(6,2,counter);
	counter = counter+1;
	plot(bold_simulation_time,bold_outputs(:,region));
	title(regions{region});
	xlabel('t (s)');ylabel('BOLD(t)');
	set(gca,'fontSize',12);
end