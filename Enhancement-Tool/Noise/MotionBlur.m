% Motion Blur Tool
% Generate winsize by winsize linear motion blur mask at an angle of dirangle
% winsize: window size, must be an odd number
% dirangle: an angle between 0 and 360 degrees

function h = MotionBlur(dirangle,winsize)
if nargin < 2, winsize = 9;  end
h = zeros(winsize);
ext = (winsize-1)/2;
if (abs(abs(dirangle)-90) >= 45) & (abs(abs(dirangle)-270) >= 45),
   slope = tan(dirangle*pi/180); 
   rloc = round(slope*[-ext:ext]);
   for i = 1:winsize,
     h(ext-rloc(i)+1,i) = 1;
  end
else 
   slope = cot(dirangle*pi/180);
   cloc = round(slope*[-ext:ext]);
   for i = 1:winsize,
      h(i,ext-cloc(i)+1) = 1;
   end
end