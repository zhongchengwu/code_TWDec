function [out] = quality_access(imagery1, imagery2)
%==========================================================================
% Evaluates the quality assessment indices for two tensors.
%
% Syntax:
%   [mpsnr, mssim] = quality_access(imagery1, imagery2)
%
% Input:
%   imagery1 - the reference tensor
%   imagery2 - the target tensor

% NOTE: the tensor is a I1*I2*...*IN array and DYNAMIC RANGE [0, 255]. 
% Output:
%   mpsnr - Peak Signal-to-Noise Ratio
%   mssim - Structure SIMilarity
%==========================================================================
Nway = size(imagery1);
if length(Nway)>3
    imagery1 = reshape(imagery1,Nway(1),Nway(2),[]);
    imagery2 = reshape(imagery2,Nway(1),Nway(2),[]);
end
psnr = zeros(prod(Nway(3:end)),1);
ssim = psnr;
for ii = 1:prod(Nway(3:end))
    psnr(ii) = psnr_index(imagery1(:, :, ii), imagery2(:, :, ii));
    ssim(ii) = ssim_index(imagery1(:, :, ii), imagery2(:, :, ii));
end
out = [mean(psnr), mean(ssim)];

