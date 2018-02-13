% The mosquito-frog problem re-visited (again)
% This is the stochastic version, so please download:
% https://github.com/horchler/SDETools.git


% Setting up the inputs, and the time that the input is sampled at (important to specificy)
tspan = linspace(0,50,100);
u1 = 10*exp(-(tspan-5).^2/4);


% An input Matrix, first column = time
% Second column = u1, third column u3, etc etc.
inputs(:,1) = tspan;
inputs(:,2) = u1;

% Initial conditions, populations 1 and 2 = 0;
z_0(1) = 0;
z_0(2) = 0;

% Simulation time
simulationTime = [0:0.1:50];

% The intrinsic connectivity matri A which makes the equations set up in a bilinear model
A = [-0.5 -0.1;1 0];

% The input to region connectivity matrix C we only have 1 input so 1 column, and only connect to region 1 (i.e. the mosquito population)
C = [1;0];

% This here calculates the stochastic connectivity term
g = @(t,z) stochasticDCMterm(t,z,C,inputs);

% Now using all this information to simulate it all together
[y] = sde_euler(@(t,z) bilinearModel(t,z,A,C,inputs),g,simulationTime,z_0);

% Plotting routines and aesthetics. 
figure('color','white');
plot(simulationTime,y,'lineWidth',2)

legend({'Mosquito population','Frog population'});
xlabel('time (days)');ylabel('Population above mean')
title('Stochastic DCM');
set(gca,'fontSize',18);
