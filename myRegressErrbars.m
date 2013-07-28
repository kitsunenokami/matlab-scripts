% Automatically plots the best fit linear regression and errorbars.


% -------------------------- %  % ---------------------- %
% --- CODED BY DAVID LEE --- %  % --- SEPTEMBER 2012 --- %
% -------------------------- %  % ---------------------- %

% ------------------------------------------------------ %
% --- This script is free to use and redistribute as --- %
% ---- long as the user uses this script within the ---- %
% ------- terms set forth by The MathWorks, Inc. ------- %
% ------------------------------------------------------ %

% ------------------------------------------------------ %
% ---- Original coder has no responsibility for any ---- %
% ----- infringements or lawsuits the user may get ----- %
% --- from using this script. USE AT YOUR OWN RISK!! --- %
% ------------------------------------------------------ %


% POLYNOMIAL FITTING: Plots a nice regression line for you (it will make it
% easy for you to predict values)
% Fits data to a polynomial where number in polyfit is polynomial's order
disp('Fitting x and y data...');
datafit=polyfit(Xdata,Ydata,1);
datavals=polyval(datafit,Xdata);
% Plots the polynomial fit
disp('Plotting best fit line...');
figure(1); hold on; hold all;
plot(Xdata,datavals,'r-','LineWidth',3);

% ERROR BARS: Plots the error bars by using the regression data (this will
% make it easier to see the values you can be confident with)
% Preparing error bars
disp('Preparing error bars...');
Xmatrix=[ones(length(Xdata),1) Xdata];
[Slope,~,~,~,Stats]=regress(Ydata,Xmatrix,0.05);
sqrtStats=sqrt(Stats(1,4));
error=sqrtStats*ones(length(Xmatrix),1);
% Plot error bars
disp('Plotting error bars...');
figure(1); hold on;
errorbar(Xdata,Ydata,error,'LineStyle','none');
% Disp polynomial fit expression
a = num2str(Slope(2));
b = num2str(Slope(1));
expression = strcat({'    f(x) = '},a,{'*x + '},b);
standarderr = strcat({'    rmse = '},{num2str(sqrtStats)});
disp(' ');
disp('Linear model:');
disp(expression{1});
disp(standarderr{1});
disp(' ');

% GARBAGE COLLECTION: Clear memory (RAM) of unnecessary variables (this
% should make your computer happy)
disp('Cleaning up...');
clear datafit
clear datavals
clear Xmatrix
clear Slope
clear SlopeInt
clear Regression
clear RegressionInt
clear Stats
clear sqrtStats
clear error
clear a
clear b

% DONE: Tells you the script is done (yay!)
disp('Remember to save any workspace variables you would like to keep!');
disp('...Done!');