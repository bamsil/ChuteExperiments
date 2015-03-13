% Velocity profile plots for methods section
close all
% Longitudinal Section
i=150

figure (1)
plot(y_vel_profile{i,1,1}.data(:,1),y_vel_profile{i,1,1}.data(:,2),'LineWidth',2)
hold on
line('XData', [0 1.8], 'YData', [0.03 0.03], 'LineStyle', '-', ...
    'LineWidth',2, 'Color','r');
xlabel('Longitudinal Section (m)');
ylabel('Velocity (m/s)');
hL=legend('Velocity','Threshhold')
set(hL, 'fontsize',16)
axis([0 1.8 0 2.5])
set(gca,'fontsize',16)
xlhand = get(gca,'xlabel')
xrhand = get (gca, 'ylabel')
set(xlhand,'string','Longitudinal section (m)','fontsize',16) 
set(xrhand,'string','Velocity (m/s)','fontsize',16)


% str_1= sprintf('Longitudinal_%d.png', i); 
% saveas(gcf, str_1);

% Cross-section
figure (2)
plot(x_vel_profile{i,1,1}.data(:,1),x_vel_profile{i,1,1}.data(:,2),'LineWidth',2)
hold on
line('XData', [0 0.67], 'YData', [0.1 0.1], 'LineStyle', '-', ...
    'LineWidth',2, 'Color','r');
xlabel('Cross-section (m)');
ylabel('Velocity (m/s)');
xlhand = get(gca,'xlabel')
xrhand = get (gca, 'ylabel')
set(xlhand,'string','Cross-section (m)','fontsize',16) 
set(xrhand,'string','Velocity (m/s)','fontsize',16)

hL=legend('Velocity','Threshhold')
set(hL, 'fontsize',16)

hold on
line('XData', [0.34 0.34], 'YData', [0 2.5], 'LineStyle', '-.', ...
    'LineWidth',0.5, 'Color','k');
axis([0 0.67 0 2.5])
set(gca,'fontsize',16)

cd('F:\Masterthesis\06_Report\Figures')
% str_2= sprintf('Cross_%d.png', i); 
% saveas(gcf, str_2);