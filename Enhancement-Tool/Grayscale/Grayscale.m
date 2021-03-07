% Grayscale Converter

IMG = imread('../Images/Car.jpg');
imgSize = size(IMG);
x = imgSize(1,1);
y = imgSize(1,2);
z = imgSize(1,3);
r=zeros(x,y);
g=zeros(x,y);
b=zeros(x,y);
r=IMG(:,:,1);
g=IMG(:,:,2);
b=IMG(:,:,3);
y=r*0.299+g*0.587+b*0.114;
%imwrite(y,'../Images/CarGray.jpg');
%imwrite(y,'../Images/CarGray.gif');
subplot(121),imshow(IMG),title('Original')
subplot(122),imshow(y),title('Grayscale');


