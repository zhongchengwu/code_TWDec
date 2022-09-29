% this is for simulation data, randomly generate tensor dims 
function [Z] = factor_dims(Nway,r)
%
N = numel(Nway);
Z = zeros(N,4);  % 4th-order tensor
for i=1:N-1
    Z(i,:) = [r(1,i),Nway(i),r(2,i),r(1,i+1)];
end
    Z(N,:) = [r(1,N),Nway(N),r(2,N),r(1,1)];
end