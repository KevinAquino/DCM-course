function dzdt = bilinearModel(t,z,A)

dzdt = zeros(2,1);

dzdt = A*z;
% dzdt(1) = -z(2);
% dzdt(2) = -z(1);

end