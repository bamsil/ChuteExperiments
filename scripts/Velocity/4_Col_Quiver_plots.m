% New Quiver plots for methods
close all

frame=[150;400;650;800];
for i=1:4
t=frame.*0.0033;
t_step(i)=eval(sprintf('%.2f',t(i)))
end

cd('F:\Masterthesis\03_Data\02_Data\090713_Second series\03_30g\02_High Speed Cameras\03_joined\matlab bmp');
files=dir('*.bmp');

x_pixgrid=x{1}/calxy;
y_pixgrid=y{1}/calxy;

figure (1)
I=imread(files(frame(1)).name);
imshow(I)
hold on
col_quiver (x_pixgrid,y_pixgrid,u_filtered{frame(1)},v_filtered{frame(1)},1,'y');

figure (2)
I=imread(files(frame(2)).name);
imshow(I)
hold on
col_quiver (x_pixgrid,y_pixgrid,u_filtered{frame(2)},v_filtered{frame(2)},1,'y');

figure (3)
I=imread(files(frame(3)).name);
imshow(I)
hold on
col_quiver (x_pixgrid,y_pixgrid,u_filtered{frame(3)},v_filtered{frame(3)},1,'y');

figure (4)
I=imread(files(frame(4)).name);
imshow(I)
hold on
col_quiver (x_pixgrid,y_pixgrid,u_filtered{frame(4)},v_filtered{frame(4)},1,'y');

cd('F:\Masterthesis\06_Report\Figures')