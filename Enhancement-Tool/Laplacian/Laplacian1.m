% Laplacian Filter
% Paramters: Sample Radius (For 3x3, radius is 1)

mask3 = [-1 -1 -1;
         -1 8 -1;
         -1 -1 -1];

mask = [0 1 1 2 2 2 1 1 0;
         1 2 4 5 5 5 4 2 1;
         1 4 5 3 0 3 5 4 1;
         2 5 2 -12 -24 -12 3 5 2;
         2 5 0 -24 -40 -24 0 5 2;
         2 5 2 -12 -24 -12 3 5 2;
         1 4 5 3 0 3 5 4 1;
         1 2 4 5 5 5 4 2 1;
         0 1 1 2 2 2 1 1 0];
maskSize = size(mask);
n = (maskSize(1,1) / 2) - 1;
sens = 25;

IMG = imread('../Images/GeorgeGray.jpg');
imgSize = size(IMG);
imgWidth = imgSize(1,1);
imgHeight = imgSize(1,2);
rFinal = zeros(imgWidth,imgHeight, 'uint8')
double sum;
double maxSum;
double minSum
double finalValue;
double mult;
maxSum = 0;
minSum = 0;


for i = 1: imgWidth
    for j = 1: imgHeight
        sum = 0;
        for maskX = -n:(n)
            for maskY = -n: (n)
                if ((i + maskX) >= 1 && (i + maskX) <= imgWidth && (j + maskY) >= 1 && (j + maskY) <= imgHeight) 
                    sum = sum + double(IMG(int16(i + maskX),int16(j + maskY))) * mask(int16(maskX + n + 1), int16(maskY + n + 1));
                    %disp(sum);
                end
            end
        end
        if(maxSum < sum)
            maxSum = sum;
        end
        if(minSum > sum)
            minSum = sum;
        end
    end
end
mult = (maxSum - minSum)/255;
disp(mult);
disp(maxSum);
disp(minSum);

for i = 1: imgWidth
    for j = 1: imgHeight
        sum = 0;
        for maskX = -n:(n)
            for maskY = -n: (n)
                if ((i + maskX) >= 1 && (i + maskX) <= imgWidth && (j + maskY) >= 1 && (j + maskY) <= imgHeight) 
                    sum = sum + double(IMG(int16(i + maskX),int16(j + maskY))) * mask(int16(maskX + n + 1), int16(maskY + n + 1));
                end
            end
        end
        finalValue = (sum - minSum)/mult;
        %display(finalValue); 
        
        if(finalValue > (127 + sens) || finalValue < (127 - sens))
            rFinal(i,j) = uint8(finalValue);
        else
            rFinal(i,j) = 127;
        end
    end
end
imwrite(rFinal,'../Images/GeorgeGray75.jpg');
subplot(121),imshow(IMG),title('Original');
subplot(122),imshow(rFinal),title('Laplacian Edge');

