% Take the velocity vector data and plot them into the images for four
% discrete time steps before avalanche stops and four thereafter. so 8
% color quiver plots for each flow. We have a maximum of 1050 frames per flow, 
% so we divide it equally between 8 and get approx. 130 frames, or every
% 0.429 s a quiver plot.
close all
n=floor(1050/8);
t=0.00333*n;
frame=[1;2;3;4;5;6;7;8].*n;
t_step=[1;2;3;4;5;6;7;8].*t;

% Call the color quiver plot (LOAD the .mat files from case (dry, A,B,C)
% first into the WORKSPACE. Then chance durrent directory to where the
% joined images are.
cd('F:\Masterthesis\03_Data\02_Data\090713_Second series\00_Dry\02_High Speed Cameras\03_joined\matlab bmp');
files=dir('*.bmp');
% col_quiver(x,y,u,v,s,maxuv)
% Our x has cell structure with 949 (num_frames) cells of 89 x 36 dimension.
% y is the same. The entries of the cells are the distances in the x-y-grid of the image
% in METERS.
% COnvert the x,y grids from METER to pixel, so we can plot them into our
% images. Convert by using the calxy values from the calibration step
% (PIVlab).
x_pixgrid=x{1}/calxy;
y_pixgrid=y{1}/calxy;

% For the u,v data we take the filtered velocities (after validation). 
% u_filtered and v_filtered.

figure (1)
I=imread(files(frame(1)+1).name);
imshow(I)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(1)+1},v_filtered{frame(1)+1},3);
saveas(gcf, 'quiver_131.png');

figure(2)
J=imread(files(frame(2)+1).name);
imshow(J)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(2)+1},v_filtered{frame(2)+1},3);
saveas(gcf, 'quiver_262.png');

figure(3)
K=imread(files(frame(3)+1).name);
imshow(K)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(3)+1},v_filtered{frame(3)+1},3);
saveas(gcf, 'quiver_393.png');

figure(4)
L=imread(files(frame(4)+1).name);
imshow(L)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(4)+1},v_filtered{frame(4)+1},3);
saveas(gcf, 'quiver_524.png');

figure(5)
M=imread(files(frame(5)+1).name);
imshow(M)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(5)+1},v_filtered{frame(5)+1},3);
saveas(gcf, 'quiver_655.png');

figure(6)
N=imread(files(frame(6)+1).name);
imshow(N)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(6)+1},v_filtered{frame(6)+1},3);
saveas(gcf, 'quiver_786.png');

figure(7)
O=imread(files(frame(7)+1).name);
imshow(O)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(7)+1},v_filtered{frame(7)+1},3);
saveas(gcf, 'quiver_917.png');

figure(8)
P=imread(files(frame(8)+1).name);
imshow(P)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(8)+1},v_filtered{frame(8)+1},3);
saveas(gcf, 'quiver_1048.png');

figure(8)
P=imread(files(frame(8)+1).name);
imshow(P)
hold on
quiver (x_pixgrid,y_pixgrid,u_filtered{frame(8)+1},v_filtered{frame(8)+1},3);
saveas(gcf, 'quiver_1048.png');
