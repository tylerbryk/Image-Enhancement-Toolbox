% Function "Gaussian2D.m":
% This function returns a 2D Gaussian filter with size N1 x N2.
% Theta is the angle that the filter is rotated by counter clockwise.
% Sigma1 and Sigma2 are the standard deviations of the Gaussian functions.

function h = Gaussian2D(n1,std1,n2,std2,theta)
r=[cos(theta) -sin(theta); sin(theta)  cos(theta)];
for i = 1 : n2 
    for j = 1 : n1
        u = r * [j-(n1+1)/2 i-(n2+1)/2]';
        h(i,j) = gauss(u(1),std1)*gauss(u(2),std2);
    end
end
h = h / sqrt(sum(sum(h.*h)));

% Function "gauss.m":
function y = gauss(x,std)
y = exp(-x^2/(2*std^2)) / (std*sqrt(2*pi));