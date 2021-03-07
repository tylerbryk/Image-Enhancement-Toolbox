% Contrast Enhancement Tool
% Demonstrates several different contrast techniques

% Original Image
[xi,ind] = imread('../Images/George.gif');
[nh,nv] = size(xi);
x = ind2gray(xi,ind);
figure('Renderer', 'painters', 'Position', [5 5 900 600])
subplot(2,3,1);imshow(x);title('Original');

% Negative Image
xneg = 255 - x;
subplot(2,3,2);imshow(xneg);title('Negative');

% Stretched Mid-Range
x1 = double(x)/255;
y = (0.5*x1).*[x1<0.2]+(0.1+1.5*(x1-0.2)).*[0.2 <= x1 & x1 <= 0.7] +(1+0.5*(x1-1)).*[x1 > 0.7];
[xmid,indy] = cmunique(y);
subplot(2,3,3);imshow(xmid,indy);title('Mid-Range Stretched');

% Log Transform
c = 255/log10(1+255);
xlog = uint8(round(c*log10(1+double(x))));
subplot(2,3,4);imshow(xlog);title('Log Transform');

% Intensity Slice
y = x1.*[x1 < 0.2 | x1 > 0.4] + 0.6*[0.2 <= x1 & x1 <=0.4];
[xints,indy] = cmunique(y);
subplot(2,3,5);imshow(xints,indy);title('Intensity Sliced');

% Histogram Equalization
xeq = histeq(x);
subplot(2,3,6);imshow(xeq);title('Histogram Equalized');

% Histogram Plot
[N,grayscale] = imhist(x); 
figure(2),set(2,'position',[5 40 600 500])
subplot(211), stem(grayscale,N),title('Histogram: Original Image')
axis([0 256 0 max(N)])
[N,grayscale] = imhist(xeq);
figure(2),
subplot(212),stem(grayscale,N),title('Histogram: Equalized')
axis([0 256 0 max(N)])