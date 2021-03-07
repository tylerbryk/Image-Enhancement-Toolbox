% Edge Detector
% Edge Detector Parameters:
%    X-axis Filter
     Nx1=10; Sigmax1=1; Nx2=10; Sigmax2=1; Theta1=pi/2;
%    Y-axis Filter
     Ny1=10; Sigmay1=1; Ny2=10; Sigmay2=1; Theta2=0;
%    Threshold Parameter
     thresh = 0.1;
     
% Get the initial image
[x,map]=imread('../Images/George.gif');               
w=ind2gray(x,map);
figure('Renderer', 'painters', 'Position', [5 5 900 600])
colormap(gray);
subplot(2,3,1);
imagesc(w);
title('Grayscale Image');

% X-axis direction edge detection
subplot(2,3,2);
filterx = EdgeDetector2D(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix = conv2(w,filterx,'same');
imagesc(Ix);
title('X-Axis Edge Detector');

% Y-axis direction edge detection
subplot(2,3,3)
filtery = EdgeDetector2D(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy = conv2(w,filtery,'same'); 
imagesc(Iy);
title('Y-Axis Edge Detector');

% Normal of the gradient (Combining the X and Y directional derivatives)
subplot(2,3,4);
NVI = sqrt(Ix.*Ix+Iy.*Iy);
imagesc(NVI);
title('Normal of Gradient');

% Thresholding
I_max = max(max(NVI));
I_min = min(min(NVI));
level = thresh*(I_max-I_min)+I_min;
subplot(2,3,5);
Ibw = max(NVI,level.*ones(size(NVI)));
imagesc(Ibw);
title('Thresholding');

% Thinning (Using interpolation to find the pixels where the norms of gradient are local maximum.)
subplot(2,3,6);
[n,m] = size(Ibw);
for i = 2:n-1,
for j = 2:m-1,
	if Ibw(i,j) > level,
	X = [-1,0,+1;-1,0,+1;-1,0,+1];
	Y = [-1,-1,-1;0,0,0;+1,+1,+1];
	Z = [Ibw(i-1,j-1),Ibw(i-1,j),Ibw(i-1,j+1);
	   Ibw(i,j-1),Ibw(i,j),Ibw(i,j+1);
	   Ibw(i+1,j-1),Ibw(i+1,j),Ibw(i+1,j+1)];
	XI = [Ix(i,j)/NVI(i,j), -Ix(i,j)/NVI(i,j)];
	YI = [Iy(i,j)/NVI(i,j), -Iy(i,j)/NVI(i,j)];
	ZI = interp2(X,Y,Z,XI,YI);
		if Ibw(i,j) >= ZI(1) & Ibw(i,j) >= ZI(2)
		I_temp(i,j) = I_max;
		else
		I_temp(i,j) = I_min;
		end
	else
	I_temp(i,j) = I_min;
	end
end
end
imagesc(I_temp);
title('Thinning');
colormap(gray);