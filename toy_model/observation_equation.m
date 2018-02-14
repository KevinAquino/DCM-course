function BOLD = observation_equation(H)

% Parameters
rho = 0.34;
V0 = 0.02;

% Magnetic field parameters (calcualted from simulations of blood cylinders)
k1 = 7*rho;
k2 = 2;
k3 = 2*rho - 0.2;

% The hidden variables of blood flow and dHb concentration
v = H(:,3);
q = H(:,4);

BOLD = V0*(k1*(1-q) + k2*(1-q./v) + k3*(1-v));

end