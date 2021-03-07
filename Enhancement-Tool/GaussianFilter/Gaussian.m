% Gaussian Filter - Performs Smoothing, Noise Addition & Reduction
% Gaussian filter Parameters:
    n1=10; sigma1=0.5; n2=10; sigma2=3; theta=0.1;
% Amplitude of Noise Parameters:
    sigma1=0.5; sigma2=3; theta=0;

[w,map] = imread('../Images/George.gif');               
x = ind2gray(w,map);
filter1 = Gaussian2D(n1,sigma1,n2,sigma2,theta);
y = imnoise(x,'salt & pepper', 0.2);
f1 = conv2(x,filter1,'same');
rf1 = conv2(y,filter1,'same');
figure(1);
subplot(2,2,1);imagesc(x);title('Original');
subplot(2,2,2);imagesc(y);title('Noise');
subplot(2,2,3);imagesc(f1);title('Smooth');
subplot(2,2,4);imagesc(rf1);title('Noise Canceling');
colormap(gray);