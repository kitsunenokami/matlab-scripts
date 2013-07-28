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

% ---------- IMPORTANT!!! ---------- %
% REMEMBER TO SAVE YOUR CFTOOL RESULTS TO WORKSPACE!!!
% ---------- IMPORTANT!!! ---------- %

% CURVE FITTING TOOL: Custom curve fitting to whatever rule you want
% Cleans old curve fitting data
disp('Cleaning old cftool data if it exists...');
clear fittedmodel
clear goodness
clear output
% Runs curve fitting tool
disp('Running curve fitting tool...');
cftool(Xdata,Ydata);
disp('Remember to save cftool results to workspace.');
disp('...Done!');
disp('Run post_cftool_regress_errorbar.m after saving cftool results to finish!');