function Image_residual(image_ref, image_data, range_bar)
%%####
figure, 
subplot(1,3,1);showImageErr(image_ref, image_data{1}, range_bar); title('Incomplete')
%
subplot(1,3,2);showImageErr(image_ref, image_data{2}, range_bar); title('TW-TC')
%
subplot(1,3,3);showImageErr(image_ref, image_ref, range_bar); title('Ground-Truth')
%################################################################
end