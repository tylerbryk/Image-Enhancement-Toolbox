% Blur Tool
% Blur Tool Parameters:
radius = 5;

img = imread('../Images/GeorgeGray.jpg');
j = fspecial('disk',radius);
k = imfilter(img,j);

subplot(1,2,1);imshow(img);title('Original');
subplot(1,2,2);imshow(k);title('Blurred Image');