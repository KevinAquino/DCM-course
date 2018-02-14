function dW = stochasticDCMterm(t,z,C,inputs,stochasticAmplitude)

% Note: this is a function that evaluates the factor infront of the dW term at every instance of t 
% useful for the stochastic bilinear model, note this is very different to what the deterministic version does instead

% This is a vector adding in Stochastic terms within the inputs
w_u = ones(size(C,2));

% This is a vector adding in Stochastic terms within each node, i.e. each node has endogenous inputs
w_z = ones(size(z));

% Random term.
dW = stochasticAmplitude*C*w_u + stochasticAmplitude*w_z;

end