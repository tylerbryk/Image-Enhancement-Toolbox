% Bit Reduction
% Parameters: Bit Reduction Factor

img = imread('../Images/GeorgeGray.jpg');
img4 = img ./ 4;
img8 = img ./ 8;
img12 = img ./ 12;
subplot(221),imshow(img),title('Original')
subplot(222),imshow(img4),title('4-Bit Reduced')
subplot(223),imshow(img8),title('8-Bit Reduced')
subplot(224),imshow(img12),title('12-Bit Reduced')