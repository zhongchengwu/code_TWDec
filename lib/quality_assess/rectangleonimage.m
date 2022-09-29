function ent=rectangleonimage(pic,sw,n, ch, c, scale, type)
% sw: the location of the up-left, down-right
% n: the width of the line
% ch: ch = 1 (gray image); ch = 3 (color image) 
% c: the color of the line: c=1(red); c=2(green); c=3(blue);c=others
% scale: the salce of zooming in for SR
% type =1 (put to down-left); type =2 (put to down-right); 
% Updated by Zhong-Cheng Wu (wuzhch97@163.com)
% Sep. 15, 2022
%==============================%

if nargin< 5
    scale = [];
end
x0=sw(1);x1=sw(2);y0=sw(3);y1=sw(4);
[p q ch]=size(pic);
%ch=1:gray image; ch=3: color image
if ch==1
    if c==1
        pic(x0:x1,y0:y0+n)=255;
        pic(x0:x1,y1-n:y1)=255;
        pic(x0:x0+n,y0:y1)=255;
        pic(x1-n:x1,y0:y1)=255;
    elseif c==2
        pic(x0:x1,y0:y0+n)=0;
        pic(x0:x1,y1-n:y1)=0;
        pic(x0:x0+n,y0:y1)=0;
        pic(x1-n:x1,y0:y1)=0;
    else
        pic(x0:x1,y0:y0+n)=255-pic(x0:x1,y0:y0+n); %inverse
        pic(x0:x1,y1-n:y1)=255- pic(x0:x1,y1-n:y1);
        pic(x0:x0+n,y0:y1)=255-pic(x0:x0+n,y0:y1);
        pic(x1-n:x1,y0:y1)=255-pic(x1-n:x1,y0:y1);
    end
end

if ch==3
    if c==1
        pic(x0:x1,y0:y0+n,1)=255; pic(x0:x1,y0:y0+n,2)=0; pic(x0:x1,y0:y0+n,3)=0;
        pic(x0:x1,y1-n:y1,1)=255;   pic(x0:x1,y1-n:y1,2)=0;   pic(x0:x1,y1-n:y1,3)=0;
        pic(x0:x0+n,y0:y1,1)=255; pic(x0:x0+n,y0:y1,2)=0; pic(x0:x0+n,y0:y1,3)=0;
        pic(x1-n:x1,y0:y1,1)=255;   pic(x1-n:x1,y0:y1,2)=0;   pic(x1-n:x1,y0:y1,3)=0;
        
    elseif c==2
        pic(x0:x1,y0:y0+n,1)=0;pic(x0:x1,y0:y0+n,2)=255;pic(x0:x1,y0:y0+n,3)=0;
        pic(x0:x1,y1-n:y1,1)=0;pic(x0:x1,y1-n:y1,2)=255;pic(x0:x1,y1-n:y1,3)=0;
        pic(x0:x0+n,y0:y1,1)=0;pic(x0:x0+n,y0:y1,2)=255;pic(x0:x0+n,y0:y1,3)=0;
        pic(x1-n:x1,y0:y1,1)=0;pic(x1-n:x1,y0:y1,2)=255;pic(x1-n:x1,y0:y1,3)=0;

    elseif c==3   
        pic(x0:x1,y0:y0+n,1)=0;pic(x0:x1,y0:y0+n,2)=0;pic(x0:x1,y0:y0+n,3)=255;
        pic(x0:x1,y1-n:y1,1)=0;pic(x0:x1,y1-n:y1,2)=0;pic(x0:x1,y1-n:y1,3)=255;
        pic(x0:x0+n,y0:y1,1)=0;pic(x0:x0+n,y0:y1,2)=0;pic(x0:x0+n,y0:y1,3)=255;
        pic(x1-n:x1,y0:y1,1)=0;pic(x1-n:x1,y0:y1,2)=0;pic(x1-n:x1,y0:y1,3)=255;

    else                          %inverse
        pic(x0:x1,y0:y0+n,1:3)=255-pic(x0:x1,y0:y0+n,1:3);
        pic(x0:x1,y1-n:y1,1:3)=255-pic(x0:x1,y1-n:y1,1:3);
        pic(x0:x0+n,y0:y1,1:3)=255-pic(x0:x0+n,y0:y1,1:3);
        pic(x1-n:x1,y0:y1,1:3)=255-pic(x1-n:x1,y0:y1,1:3);
    end
end

ent=pic; 
sampIm = pic(x0:x1, y0:y1, :);
SampIm = imresize(sampIm, scale,'nearest'); % nearest to zooming in the local part
switch type
    case 1   %  put zoom in image on the down-left
        [a, b, third] = size(SampIm);
        ent((p-a+1):p,1:b, :) = SampIm;
    case 2  %  put zoom in image on the down-left
        [a, b, third] = size(SampIm);
        ent((p-a+1):p,(q-b+1):q, :) = SampIm;
end




