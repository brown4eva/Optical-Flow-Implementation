function [ theta,xm,ym ] = affineMotion( a,b )
% This code was done by Meldrick Reimmer 
% Guided by Prof. Yannick Benezeth


if size(size(a),2)==3
    a=rgb2gray(a);
end
if size(size(b),2)==3
    b=rgb2gray(b);
end

a=double(a);            
b=double(b);            

a = imgaussfilt(a,2);    % Applying Gaussian Filter to First Image
b = imgaussfilt(b,2);    % Applying Gaussian Filter to Second Image

Ix_1 = [-1 1 ; -1 1];    % X Derivative Mask for First Image
Iy_1 = [-1 -1; 1 1];     % Y Derivative Mask for First Image
Ix_2 = [-1 1 ; -1 1];    % X Derivative Mask for Second Image
Iy_2 = [-1 -1; 1 1];     % Y Derivative Mask for Second Image
It_1 = [-1 -1; -1 -1];   % T Derivative Mask for First Image
It_2 = [1 1; 1 1];       % T Derivative Mask for Second Image

% Computing Final Ix by convoluting it with both the images 
Ix = ((conv2(a,Ix_1,'same')+conv2(b,Ix_2,'same'))./2);

% Computing Final Iy by convoluting it with both the images 
Iy = ((conv2(a,Iy_1,'same')+conv2(b,Iy_2,'same'))./2);

% Computing Final It by convoluting it with both the images 
It = (conv2(a,It_1,'same') + conv2(b,It_2,'same'));


 % Getting all values of It
[xm, ym] = meshgrid(1:size(It,2), 1:size(It,1));

% Computing M, Which is;
M = [Ix(:).*xm(:) Ix(:).*ym(:) Ix(:) Iy(:).*xm(:) Iy(:).*ym(:) Iy(:)];

P = -It(:);              % Vectorising It and substituting the value into P

theta = inv(M'*M)*M'*P;  % Computing all the 6 Parameters of theta

end