function img = image_stretch(img,th)
%%%
    img = double(img);
%     if numel(th) == 2,
%              img = (img-th(1))/(th(2)-th(1));
%     else
        [~,~,Nk] = size(img);
        for index = 1:Nk
            temp  =   (img(:,:,index)-th(index,1))/(th(index,2)-th(index,1));
            location_0 = temp<0;
            location_1 = temp>1;
            temp(location_0)=0;
            temp(location_1)=1;
            img(:,:,index) =temp;
        end
end