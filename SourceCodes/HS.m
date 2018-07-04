function [u, v] = HS(im1, im2, lambda, iter)
% Horn-Schunck optical flow method
 
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Begin of "Write your code here" section %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create the X derivative filter
IxMask = [-1 1; -1 1]; 
% Create the Y derivative filter
IyMask = [-1 -1; 1 1]; 

%Create both the filters for the time derivative
ItMask_1 = [-1 -1; -1 -1]; 
ItMask_2 = [1 1; 1 1];

% Given Kernel
kernel = [1/12 1/6 1/12; 1/6 -1 1/6; 1/12 1/6 1/12];

% Convolute the corresponding filters with the images
Ix = (imfilter(im1,IxMask) + imfilter(im2,IxMask))/2; 
Iy = (imfilter(im1,IyMask) + imfilter(im2,IyMask))/2;
It = imfilter(im1,ItMask_1) + imfilter(im2,ItMask_2);

%initialising u and v to zeros
u = zeros(size(im1));
v = zeros(size(im2));

% create a matrix of lambdas values to easily compute the HS formula
lambda_matrix = lambda * ones(size(u)); 

% caculate respectively ubar and v bar according to u and v and the mean filter
for i = 1 : iter
    ubar  = imfilter(u ,kernel); 
    vbar  = imfilter(v ,kernel);
    
    % Optimisation Process of Horn And Shunck Method
    u = ubar - (Ix .* ( It + vbar.*Iy + Ix.*ubar )) ./ (lambda_matrix.^2 + Iy.^2 + Ix.^2);  
    v = vbar - (Iy .* ( It + vbar.*Iy + Ix.*ubar )) ./ (lambda_matrix.^2 + Iy.^2 + Ix.^2); 
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of "Write your code here" section %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

u(isnan(u))=0;
v(isnan(v))=0;

%Plotting the flow
plotOF_arrows(u,v);
%plotOF_colors(u, v, 0);
title('Horn And Shunck');
end
