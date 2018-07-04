%% Meldrick Reimmer MsCV 1 (5/02/2018)
% Optical Flow Class
% Supervisor : Prof. Yannick Benezeth

close all;
clear all;
clc;

%% The Basics.
%% Question 1
% Completing Horn and Schunck Algorithm.
%Reading images
im1 = imread('sequences/garden/garden_1.png');
im2 = imread('sequences/garden/garden_2.png');

%Given iterations
iter = 5;
lambda = 0.1;
[u,v] = HS(im1, im2 , lambda , iter);
%Plotting the flow
plotOF_arrows(u,v);
%plotOF_colors(u, v, 0);
title('Horn And Shunck on Garden');

%% Question 2
windowSize = 6;
[u1,v1] = LK(im1, im2 , windowSize);
u(isnan(u))=0;
v(isnan(v))=0;
plotOF_arrows(u, v); 
%plotOF_colors(u, v, 0);
title('Lucas and Kanade on Garden');

%% Question 3
%% Testing the Methods on diffeent Sequences.
%% Hamburg 
Hamb1 = imread('sequences/Hamburg/Hamburg_1.jpg');
Hamb2 = imread('sequences/Hamburg/Hamburg_.jpg');
% Horn-Schunck Method on Hamburg Sequences
iter = 5;
lambda = 0.5;
[u,v] = HS(Hamb1, Hamb2 , lambda , iter);
% Lucas and Kanade Method on Hamburg Sequences
windowSize = 6;
[u1,v1] = LK(Hamb1, Hamb2 , windowSize);

%% Pepsi
pep1 = imread('sequences/pepsi/pepsi0.pgm');
pep2 = imread('sequences/pepsi/pepsi1.pgm');
% Horn-Schunck Method on Pepsi  Sequences
iter = 5;
lambda = 0.9;
[u,v] = HS(pep1, pep2 , lambda , iter);
% Lucas and Kanade Method on Pepsi Sequences
windowSize = 8;
[u1,v1] = LK(pep1, pep2 , windowSize);

%% Taxi
taxi1 = imread('sequences/MotionTaxi/MotionTaxi11.jpg');
taxi2 = imread('sequences/MotionTaxi/MotionTaxi36.jpg');
% Horn-Schunck Method on Taxi Sequences
iter = 5;
lambda = 0.3;
[u,v] = HS(taxi1, taxi2 , lambda , iter);
% Lucas and Kanade Method on Taxi  Sequences
windowSize = 6;
[u1,v1] = LK(taxi1, taxi2 , windowSize);

%% Yosemite
yose1 = imread('sequences/Yosemite/yos_clouds_00.pgm');
yose2 = imread('sequences/Yosemite/yos_clouds_01.pgm');
% Horn-Schunck Method on Yosemite Sequences
iter = 5;
lambda = 1;
[u,v] = HS(yose1, yose2 , lambda , iter);
% Lucas and Kanade Method on Yosemite Sequences
windowSize = 9;
[u1,v1] = LK(yose1, yose2 , windowSize);

%% Question 4
% Given Window Size
WindowSize = 2; 
% Number of levels of Pyramid
numLevels = 2;                      
[u,v] = hierarchicalLK(im1, im2, numLevels, WindowSize);


