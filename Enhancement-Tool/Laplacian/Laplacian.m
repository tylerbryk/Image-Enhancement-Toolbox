% Laplacian Filter
% Paramters: Sample Radius (For 3x3, radius is 1)
n = 1;

cmTotalElements = (n*2 + 1)*(n*2 + 1);
IMG = imread('../Images/GeorgeGray.jpg');
imgSize = size(IMG);
imgWidth = imgSize(1,1);
imgHeight = imgSize(1,2);
mask = zeros(n * 2 + 1,n * 2 + 1, 'int8');
rFinalThresh = zeros(imgWidth,imgHeight, 'uint8');
rFinalEdgeThreshold = zeros(imgWidth,imgHeight, 'uint8');
rFinalEdge = zeros(imgWidth,imgHeight, 'uint8');
int32 T;
double meanBright;
double meanDark;
T = 127;
meanBright = 0;
meanDark = 0;
countBright = 0;
countDark = 0;

mask7 = [0 1 1 2 2 2 1 1 0;
         1 2 4 5 5 5 4 2 1;
         1 4 5 3 0 3 5 4 1;
         2 5 2 -12 -24 -12 3 5 2;
         2 5 0 -24 -40 -24 0 5 2;
         2 5 2 -12 -24 -12 3 5 2;
         1 4 5 3 0 3 5 4 1;
         1 2 4 5 5 5 4 2 1;
         0 1 1 2 2 2 1 1 0]

for i = 1: imgWidth
    for j = 1: imgHeight
        if (IMG(i,j) > T) 
            countBright = countBright + 1;
            meanBright = (meanBright * double(countBright - 1) + double(IMG(i,j))) / double(countBright);
        else 
            countDark = countDark + 1;
            meanDark = (meanDark * double(countDark - 1) + double(IMG(i,j))) / double(countDark);
        end
    end
end
T = int16((meanBright + meanDark) / 2);
disp(T);

for i = 1:(n*2 + 1)
    for j = 1:(n*2 + 1)
        mask(i,j) = -1;
    end
end
mask(n+1,n+1) = cmTotalElements - 1;

for i = 1: imgWidth
    for j = 1: imgHeight
        sum = 0;
        for maskX = (-1 * n):(n)
            for maskY = (-1*n): (n)
                if ((i + maskX) >= 1 && (i + maskX) <= imgWidth && (j + maskY) >= 1 && (j + maskY) <= imgHeight) 
                    sum = sum + int16(IMG(i + maskX,j + maskY)) * int16(mask(maskX + n + 1,maskY + n + 1)) ;
                    %disp(sum);
                end
            end
        end
        
        if(sum >= 0)
            rFinalEdge(i,j) = 0;
            if (abs(sum) > T)
               rFinalThresh(i,j) = 255;
            else
               rFinalThresh(i,j) = 0;
            end
        end
        if(sum < 0)
            if (abs(sum) > 50)
                rFinalEdge(i,j) = uint8(sum * (-1));
            end
            if (abs(sum) > T)
               rFinalEdgeThreshold(i,j) = 255;
            else
               rFinalEdgeThreshold(i,j) = 0;
            end
        end
        
    end
end


%imwrite(rFinal,'../Images/CarMedian10.jpg');
subplot(221),imshow(IMG),title('Original')
subplot(223),imshow(rFinalEdge),title('Laplacian Edge');
subplot(224),imshow(rFinalEdgeThreshold),title(strcat('Laplacian Edge with Auto Threshold of :', num2str(T)));
subplot(222),imshow(rFinalThresh),title(strcat('Auto Threshold of :', num2str(T)));

