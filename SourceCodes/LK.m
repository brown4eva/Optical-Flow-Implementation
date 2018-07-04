function [u, v] = LK(im1, im2, windowSize)
% Lucas and Kanade Method

if size(size(im1),2)==3
    im1=rgb2gray(im1);
end
if size(size(im2),2)==3
    im2=rgb2gray(im2);
end

im1=double(im1);
im2=double(im2);

im1 = imgaussfilt(im1,2);
im2 = imgaussfilt(im2,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Begin of "Write your code here" section %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%initialising u and v to zeros
u = zeros(size(im1)); 
v = zeros(size(im2));

Ix_1 = [-1 1; -1 1];    % X Derivative Mask for First Image
Ix_2 = [-1 1; -1 1];    % X Derivative Mask for Second Image
Iy_1 = [-1 -1; 1 1];    % Y Derivative Mask for First Image
Iy_2 = [-1 -1; 1 1];    % Y Derivative Mask for Second Image
It_1 = [-1 -1; -1 -1];  % T Derivative Mask for First Image  
It_2 = [1 1; 1 1];      % T Derivative Mask for Second Image

% Computing Ix by convoluting it with both the images
Ix_New = conv2(im1, Ix_1, 'same') + conv2(im2, Ix_2, 'same');

% Computing Iy by convoluting it with both the images 
Iy_New = conv2(im1, Iy_1, 'same') + conv2(im2, Iy_2, 'same');

% Computing It by convoluting it with both the images
It_New = conv2(im1, It_1, 'same') + conv2(im2, It_2, 'same');

for i = windowSize+1:size(Ix_New,1)-windowSize
   for j = windowSize+1:size(Ix_New,2)-windowSize
       
      % Computing Final Ix by Lucas and Kanade Method
      Ix = Ix_New(i-windowSize:i+windowSize, j-windowSize:j+windowSize);
      
      % Computing Final Iy by Lucas and Kanade Method
      Iy = Iy_New(i-windowSize:i+windowSize, j-windowSize:j+windowSize);
      
      % Computing Final It by Lucas and Kanade Method
      It = It_New(i-windowSize:i+windowSize, j-windowSize:j+windowSize);
      
      Ix = Ix(:);       % Vectorising Ix
      Iy = Iy(:);       % Vectorising Iy
      b = It(:);        % Substituting vectorised It in b
      A = [Ix Iy];      % Concatinating Ix and Iy
      nu = pinv(A)*b;   % Calculating velocity
      u(i,j)=nu(1);     % Substituting value for U
      v(i,j)=nu(2);     % Substituting value for V
   end;
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of "Write your code here" section %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

u(isnan(u))=0;
v(isnan(v))=0;
plotOF_arrows(u, v); 
%plotOF_colors(u, v, 0);
title('Lucas and Kanade');
end
