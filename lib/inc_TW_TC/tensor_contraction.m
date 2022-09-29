%==========================================================================
% Compute the tensor contraction of two tensors
% Input:
%   X - the first tensor
%   Y - the second tensor
%   n - The modes of X used to conduct contraction 
%   m - The modes of Y used to conduct contraction 
%  Output:
%   Out - the contraction result
%==========================================================================
function Out = tensor_contraction(X,Y,n,m)
Lx = size(X);      Ly = size(Y);   
Nx = ndims(X);     Ny = ndims(Y);
indexx = 1:Nx;     indexy = 1:Ny;
indexx(n) = [];    indexy(m) = [];

tempX = permute(X,[indexx,n]);  tempXX=reshape(tempX,prod(Lx(indexx)),prod(Lx(n)));
tempY = permute(Y,[m,indexy]);  tempYY=reshape(tempY,prod(Ly(m)),prod(Ly(indexy)));
tempOut = tempXX*tempYY;
Out     = reshape(tempOut,[Lx(indexx),Ly(indexy)]);
end
%
%