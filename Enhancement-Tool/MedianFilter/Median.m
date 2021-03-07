% Median Filter
% Paramters: Sample Radius (For 5x5, radius is 2)
n = 5;

IMG = imread('../Images/George.jpg');
imgSize = size(IMG);
imgWidth = imgSize(1,1);
imgHeight = imgSize(1,2);
z = imgSize(1,3);
r=zeros(imgWidth,imgHeight);
g=zeros(imgWidth,imgHeight);
b=zeros(imgWidth,imgHeight);
r=IMG(:,:,1);
g=IMG(:,:,2);
b=IMG(:,:,3);
medMatrixR = zeros(n * 2 + 1,n * 2 + 1,'uint8');
medMatrixG = zeros(n * 2 + 1,n * 2 + 1,'uint8');
medMatrixB = zeros(n * 2 + 1,n * 2 + 1,'uint8');
rFinal = zeros(imgWidth,imgHeight,3,'uint8');
for i = 1:(imgWidth)
    for j = 1:(imgHeight)
        for in = i-n:(i+n)
            for jn = j-n:(j+n)
                if(jn >= 1 && jn <= imgHeight && in >= 1 && in <= imgWidth)
                     medMatrixR(in-i+n+1,jn-j+n+1) = uint8(r(in,jn));
                     medMatrixG(in-i+n+1,jn-j+n+1) = uint8(g(in,jn));
                     medMatrixB(in-i+n+1,jn-j+n+1) = uint8(b(in,jn));
                else
                     medMatrixR(in-i+n+1,jn-j+n+1) = 0;
                     medMatrixG(in-i+n+1,jn-j+n+1) = 0;
                     medMatrixB(in-i+n+1,jn-j+n+1) = 0;
                end
            end
        end
        rFinal(i,j,1) = uint8(median(median(medMatrixR,'omitnan'), 'omitnan'));
        rFinal(i,j,2) = uint8(median(median(medMatrixG,'omitnan'), 'omitnan'));
        rFinal(i,j,3) = uint8(median(median(medMatrixB,'omitnan'), 'omitnan'));
    end
end
%imwrite(rFinal,'../Images/GeorgeMedian10.jpg');
subplot(121),imshow(IMG),title('Original')
subplot(122),imshow(rFinal),title('Median');