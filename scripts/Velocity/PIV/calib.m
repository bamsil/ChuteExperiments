% Calibration 

% function [px_mm, mm_px]= calib(calib_img);

% Path to calibration image
path_calib='./../../../distance/';
cd(path_calib);

meter_length = 0.4;
% Open the calibration image and draw a line 40cm (each rectangle is 10cm) 
% from one to another grid point (you can first enlarge the image, then
% draw the line. To return, double click on the line.)
calib_img=imread('distance_0001.bmp');
imshow(calib_img);
z=imline;
length= wait(z);

% 'lengt' has the following form: 
% [xstart xend ystart yend]

% Now calculate the pixel length of your line:
xdiff=length(2)-length(1);
ydiff=length(4)-length(3);


% Laura
% % Detect which difference is bigger (depends upon whether you chose to draw a horizontal or vertical line)
% if xdiff > ydiff
%     pix_length=xdiff;
%     px_mm=xdiff/100;
%     mm_pix=1/px_mm;
% end
% 
% if ydiff > xdiff
%     pix_length=ydiff;
%     px_mm=ydiff/100;
%     mm_pix=1/px_mm;
% end

% Gabriel

pix_length = norm([xdiff,ydiff]);
px_per_meter = pix_length / meter_length;
px_mm = px_per_meter * 1e-3;

close all
% end

 