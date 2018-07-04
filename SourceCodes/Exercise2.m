%% Meldrick Reimmer MsCV 1 (5/02/2018)
% Optical Flow Class
% Supervisor : Prof. Yannick Benezeth

close all;
clear all;
clc;

%% Parametric motion estimation and application to image stabilization.
%% Question 1 to 3

%Getting the images
MotionHamburg1 = imread('sequences/MotionHamburg/Motiondt_0011.jpg');
MotionHamburg2 = imread('sequences/MotionHamburg/Motiondt_0012.jpg');

[ theta,xm,ym ] = affineMotion(MotionHamburg1 ,MotionHamburg2 );
%Displaying the values of theta
disp('The values of Theta :');
disp(theta);

%Getting the values of u and v
u = theta(1)*xm + theta(2)*ym + theta(3); % From u = ax + by + c
v = theta(4)*xm + theta(5)*ym + theta(6); % From v = dx + ey + f

u(isnan(u))=0;
v(isnan(v))=0;

% Plotting u and v
plotOF_arrows(u,v);
%plotOF_colors(u, v, 0);
title('Direction of Displacement');

%% Question 3b
% Creating the stabilize Image with 2 images 
[ NewImage ] = StabilizedImg( u,v,MotionHamburg1,MotionHamburg2 )

figure; 
subplot(221);imshow(MotionHamburg1); title('Image 1');
subplot(222);imshow(MotionHamburg2); title('Image 2');
subplot(223);imshow(NewImage,[]); title('Stabilized image');

%% Creating stabilize image with the set of image

seq = 2; %Motion Taxi (seq = 1) & Motion Hamburg (seq = 2)

if (seq == 1)
    path = './sequences/MotionTaxi/';
    fileName = 'MotionTaxi';
elseif (seq == 2)
    path = './sequences/MotionHamburg/';
    fileName = 'Motiondt_00';
end

idx = 1;
images = [];
for i = 11:41
    A = double(imread(strcat(path, fileName, int2str(i), '.jpg')));
    images(:,:,idx) = A;
    idx = idx + 1;
end

nImage = size(images, 3);

prevU = zeros(size(images(:,:,1)));
prevV = zeros(size(images(:,:,1)));

for i = 1:nImage-1
    im1 = images(:,:,i);
    im2 = images(:,:,i+1);
    
    theta = affineMotion(im1, im2);
    
    [xm, ym] = meshgrid(1:size(im1, 2), 1:size(im1, 1));
    u = theta(1)*xm + theta(2) * ym + theta(3);
    v = theta(4)*xm + theta(5) * ym + theta(6) ;

    compensated = compensate_motion(im2, u+ prevU, v+ prevV);
    figure(1), imshow(compensated,[]), title(strcat('compensation', int2str(i)));
    pause(0.1)
    % for next iteration
    prevU = u + prevU;
    prevV = v + prevV;
end

% Getting the stabilized image
camera_motion = stabilize(im2, u+ prevU, v+ prevV)
figure()
imshow(camera_motion,[]);
title ('stabilized image');
