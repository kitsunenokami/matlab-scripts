% Coded by David Lee
% This script adds a text file with x- and y- data to the plot.
% Just select the file from the popup browser and the script does the rest.
% The individual addition allows for any needed tweaking in between files.

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

% LOAD DATA: Open file browser to import data file (single file please!)
disp('Importing file...');
Struct = uiimport('-file');
% Splits data by column assuming x values are in column 1 and y values are
% in column 2
disp('Extracting x and y data...');
Xdata = Struct.data(:,1);
Ydata = Struct.data(:,2);

% AXES LABELS: Prompt for labels with a popup dialogue window
disp('Setting figure axes labels... already set');

% DATA PLOTTING: This is where your data gets plotted automatically (this
% should make you happy)
disp('Setting figure details... also already set');
% Allow adding to current figure
figure(1); hold on; hold all;
% Create plot
disp('Plotting figure...');
plot(Xdata,Ydata,'LineStyle','-','LineWidth',3,'Marker','.',...
    'MarkerSize',10,'DisplayName','Ydata vs. Xdata','Color',[0 0 0]);

% GARBAGE COLLECTION: Clear memory (RAM) of unnecessary variables (this
% should make your computer happy)
disp('Cleaning up...');
clear expression
clear Struct
clear options
clear figure1
clear axes1
clear AxesLabels

% DONE: Tells you the script is done
disp('Remember to rename/save workspace variables you would like to keep.');
disp('...Done!');