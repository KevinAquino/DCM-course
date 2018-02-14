function dzdt = bilinearModel(t,z,A,C,inputs)

% Note: this is a function that evaluates the dzdt term at every instance of t 
% ode45 then uses this to calculate the right term (as we did with dy/dt ~ Dy/Dt ~ y_ti+1-y_ti / Dt etc..)

%u is a Matrix that contains all the 
timeVector = inputs(:,1);

% Determine the total number of inputs
totalInputs = size(inputs,2) - 1;

u = zeros(totalInputs,1);

% This step now interpolates the inputs onto the same sampling the simulation is at. 
% For example the inputs might be recorded at a sampling period every 10 ms, but the
% simulation might instead might have "dt" = 0.01 ms. This ensure it works by using 
% linear interpolation.

if(sum(inputs,1~=0))
	for inputIndex = 1:totalInputs,	
		u_input = inputs(:,inputIndex+1);
		u(inputIndex) = interp1(timeVector,u_input,t);
	end
end

% Here z is a column vector (same format for the DCM papers)
% A and C have the same format we have used in the workshops so far
dzdt = A*z + C*u;



end