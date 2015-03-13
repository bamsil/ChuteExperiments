% Process .avi Videos of the High Speed Camera
% Current folder has to contain the .avi file
warning off

% step size for correlation averaging
Nstep= 30;

% process first available .avi file
files= dir ('*.avi');
obj= VideoReader(files(1).name);
nof=obj.NumberOfFrames;

% loop over consecuitve averaging blocks
for j=0:floor(nof/Nstep)-1
    
    % loop to  minimum image (for background subtraction)
    for i=1:Nstep
        
        % determine current minimum image
        img= read(obj,i+j*Nstep);
        if i == 1
            minimg= uint8(img(:,:,1));
        else
            minimg= min(minimg,uint8(img(:,:,1)));
        end
    end
    
    img= uint8(read(obj,1+j*Nstep));
    img1= img(:,:,1)-minimg;
    
    % loop to process consecutive image pairs in current averaging block
    for i=2:Nstep
        
        disp (sprintf('j: %d, i: %d\n',j,i));
        
        img0= img1;
        img= uint8(read(obj,i+j*Nstep));
        img1= img(:,:,1) - minimg;
        
    %  Define window size, max search size, window offset and Window Shift
    %  [wy,wx] window size 
    %  [sy,sx] search range 
    %  [oy,ox] offset 
    %  [gy,gx] window shift      
        wx=32;
        wy=32;
        sx=4;
        sy=4;
        ox=0;
        oy=8;
        gx=16;
        gy=16;
        threshhold=0.5;
        
        if i == 2
            % first correlation: initialize correlation map image; no
            % subpixel interpolation
            [xy_grid,uv_vecs,peaks,valid,cmaps] = PIV_base (img0,img1,-1,[wx,wy],[sx,sy],[ox,oy],[gx,gy],[],threshhold);
        else
            if i < Nstep
                % regular processing step: accumulate correlation map image; no subpixel interpolation    
                [xy_grid,uv_vecs,peaks,valid,cmaps] = PIV_base (img0,img1,-1,[wx,wy],[sx,sy],[ox,oy],[gx,gy],[],threshhold);
            else
                % last processing step in block: compute subpixel
                % interpolated velocity maps
                [xy_grid,uv_vecs,peaks,valid,cmaps] = PIV_base (img0,img1,0,[wx,wy],[sx,sy],[ox,oy],[gx,gy],[],threshhold);
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
    
    % store correlation-averaged velocities in result arrays
    u_series(:,:,j+1)= uv_vecs(:,:,1);
    v_series(:,:,j+1)= uv_vecs(:,:,2);
    
end

save result u_series v_series
