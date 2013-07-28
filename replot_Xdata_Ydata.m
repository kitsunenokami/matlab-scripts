% Coded by David Lee
% This script is designed to replot data in the variables Xdata and Ydata.
% In the popup box, type in the axes labels, then click the "OK" button.

% -------------------------- %  % ---------------------- %
% --- CODED BY DAVID LEE --- %  % --- SEPTEMBER 2012 --- %
% -------------------------- %  % ---------------------- %

% ------------------------------------------------------ %
% --- This script is free to use and redistribute as --- %
% ---- long as the user uses this script within the ---- %
% --- terms and conditions set by TheMathworks, Inc. --- %
% ------------------------------------------------------ %

% ------------------------------------------------------ %
% ---- Original coder has no responsibility for any ---- %
% ----- infringements or lawsuits the user may get ----- %
% --- from using this script. USE AT YOUR OWN RISK!! --- %
% ------------------------------------------------------ %

% AXES LABELS: Prompt for labels with a popup dialogue window
disp('Setting figure axes labels...');
options.Resize = 'off';
options.WindowStyle = 'normal';
options.Interpreter = 'tex';
AxesLabels = inputdlg({'x-axis label:','y-axis label:'},'Axes Labels',1,...
    {'X','Y'},options);

% DATA PLOTTING: This is where your data gets plotted automatically (this
% should make you happy)
disp('Setting figure details...');
% Create figure
figure1 = figure('PaperType','usletter','PaperSize',[21.573595 27.91877],...
    'Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1,'LineWidth',1,'FontSize',24);
box(axes1,'on');
hold(axes1,'all');
% Create plot
disp('Plotting figure...');
plot(Xdata,Ydata,'LineStyle','-','LineWidth',3,'Marker','.',...
    'MarkerSize',10,'DisplayName','Ydata vs. Xdata','Color',[0 0 0]);
% Create xlabel
xlabel(AxesLabels(1),'FontSize',30);
% Create ylabel
ylabel(AxesLabels(2),'FontSize',30);

% GARBAGE COLLECTION: Clear memory (RAM) of unnecessary variables (this
% should make your computer happy)
disp('Cleaning up...');
clear columnA
clear columnB
clear options
clear figure1
clear axes1
clear AxesLabels

% DONE: Tells you the script is done (yay!)
disp('Remember to rename/save workspace variables you would like to keep.');
disp('...Done!');