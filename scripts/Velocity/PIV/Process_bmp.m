warning off

close all

% step size for correlation averaging
Nstep= 30;
files=dir('*.bmp');
%NumImg=length(files);

% process first available .avi file
files=dir('*.bmp');

% Don't forget to run the calibration file first!!!
% (OR UNCOMMENT THE FUNCTION BELOW)
% Calibration from shifts in pixel to shifts in mm
% Read calibration image
%  oldpath=cd;
%  path_calib='F:\Masterthesis\03_Data\02_Data';
%  cd(path_calib);
%  calib_img=imread('080713_calibration_up.bmp');
%  [px_mm, mm_px]= calib(calib_img);
%  cd(oldpath);
    
% loop over consecutive averaging blocks
for j=21:floor(NumImg/Nstep)-1
    
    % loop to find minimum image (for background subtraction)
    for i=1:Nstep
        
        % determine current minimum image AND extract sensor pixel
        % locations
        img= imread(files(i+j*Nstep).name,'bmp');
        if i == 1
            minimg= uint8(img(:,:,1));
        % Draw rectangle upon upper and lower sensors, when 1 rectangle
        % drawn, double click into it, then draw next one.
        % for the positions [xmin y min width length]
        % for the centerline [x y]  
%         
%             figure, imshow(img);
%             h = imrect;
%             position_up = wait(h)
%             hold on
%             o=imrect;
%             position_down=wait(o)
%             hold on
%             r=impoint;
%             centerline=wait(r)
            
        else
            minimg= min(minimg,uint8(img(:,:,1)));
        end
    end
    
    img= uint8(imread(files(1+j*Nstep).name,'bmp'));
    img1= img(:,:,1)-minimg;
    
    % loop to process consecutive image pairs in current averaging block
    for i=2:Nstep
        
        disp (sprintf('j: %d, i: %d\n',j,i));
        
        img0= img1;
        img= uint8(imread(files(i+j*Nstep).name,'bmp'));
        img1= img(:,:,1) - minimg;
       
    %  Define window size, max search size, window offset and Window Shift
    %  [wy,wx] window size 
    %  [sy,sx] search range/size  
    %  [oy,ox] offset 
    %  [gy,gx] window shift  
%     Threshhold: adds the current correlation map if the normalized peak
%     threshold (min: 0, max: 1) is exceeded.
wx=32; wy=64;  sx =3; sy=10; ox=0; oy=0; gx=16; gy=32; threshhold=0.3;

        if i == 2
            % first correlation: initialize correlation map image; no
            % subpixel interpolation
            [xy_grid,uv_vecs,peaks,valid,cmaps] = PIV_base (img0,img1,-1,[wx,wy],[sx,sy],[ox,oy],[gx,gy],[],threshhold);
        else
            if i < Nstep
                % regular processing step: accumulate correlation map image; no subpixel interpolation    
                [xy_grid,uv_vecs,peaks,valid,cmaps] = PIV_base (img0,img1,-1,[wx,wy],[sx,sy],[ox,oy],[gx,gy],cmaps,threshhold);
            else
                % last processing step in block: compute subpixel
                % interpolated velocity maps
                [xy_grid,uv_vecs,peaks,valid,cmaps] = PIV_base (img0,img1,0,[wx,wy],[sx,sy],[ox,oy],[gx,gy],cmaps,threshhold);
            end
        end
        
        % show current averaged correlation maps at all interrogation points
        figure (1)
        imshow (cmaps,[]);
        % color coded velocity (i.e. displacement) vector plot
        figure (2)
        col_quiver (xy_grid(:,:,1),xy_grid(:,:,2),uv_vecs(:,:,1),uv_vecs(:,:,2),2)
        drawnow
    end
    
    % show final averaged correlation maps at all interrogation points
    figure (1)
    imshow (cmaps,[]);
    % color coded velocity (i.e. displacement) vector plot
    figure (2)
    col_quiver (xy_grid(:,:,1),xy_grid(:,:,2),uv_vecs(:,:,1),uv_vecs(:,:,2),2)
    % scatter plot to visualize velocity statistics
    figure (3)
    plot (uv_vecs(:,:,1),uv_vecs(:,:,2),'.b');
    drawnow;
    
    % Apply the mfilter
   
    % store correlation-averaged velocities in result arrays
    u_series(:,:,j+1)= uv_vecs(:,:,1);
    v_series(:,:,j+1)= uv_vecs(:,:,2);

    
end

save result u_series v_series
