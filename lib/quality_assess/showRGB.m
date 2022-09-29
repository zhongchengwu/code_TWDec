% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Sep. 20, 2021
% Updated by 
% Sep. 15, 2022

function showRGB(Ori_Imag, Output, location)
%
if ndims(Ori_Imag)==3
    channel = [31 20 10]; 
    frame = 1;
elseif ndims(Ori_Imag)==4
    channel = [1 2 3];
    frame = 13;
end
%
th_MSrgb = image_quantile(Ori_Imag(:,:,channel,frame), [0.01 0.99]);
I_fuse = image_stretch(Output(:,:,channel,frame),th_MSrgb);
ent = rectangleonimage(I_fuse, location, 0.5, 3, 1, 2, 1);
imshow(ent,[])
%
end