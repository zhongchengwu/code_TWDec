% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Sep. 20, 2021
% Updated by 
% Sep. 15, 2022

function showImageErr(Ori_Imag, Output, range_bar)
% This is a demo to show the error map of GT and Estimated Img
if ndims(Ori_Imag)==3
    channel = [31 20 10]; 
    frame = 1;
elseif ndims(Ori_Imag)==4
    channel = [1 2 3];
    frame = 13;
end
%
Multi_Err = abs(Ori_Imag(:, :, channel, frame) - Output(:, :, channel, frame));
ErrMap = mean(Multi_Err,3);
imshow(ErrMap,[])
%#######################
caxis(range_bar)
% colorbar;
colormap parula
axis off
%#######################
end
