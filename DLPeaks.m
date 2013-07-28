%  ============================== HELP INFO ===============================
%  
%  Inputs required by user are as followed:
%  1) Select the file to load from the popup browser.*
%       Note: If 'Import data' wizard starts, user must select their data.
%             This script cannot import MatLab data files.
%  2) Input the correct columns for the X data and the Y data.*
%  3) Select between the Gaussian function or the Lorentzian function.
%  4) Input the axes labels.
%       Note: LaTeX format is allowed.
%  
%  *Inputs 1 & 2 are unavailable if user overrides to load from workspace.
%  *Known bug: Will not load .mat data files properly.
%   Workaround: Manually load data and modify script, lines 32-47.
%  
%  IMPORTANT! Selecting or inputting bad data will result in errors and
%  require starting over!
%  
%  CAUTION! Modyfing script variables can cause errors and eat up your RAM.
%  The only section you can modify is at the beginning and is labeled:
%  'ONLY CODE USER CAN MODIFY'
%  
%  NOTE! This script is a beta release and has not been fully optimized.
%  This script was built on Mac OS X 10.8 and might not properly work or
%  disply in other operating systems.
%  
%  ========================================================================


%  === ONLY CODE USER CAN MODIFY! - START - ONLY CODE USER CAN MODIFY! ===

%  MANUALLY LOAD DATA
Del_load_var = 'off'; % Turned off to use script's import feature. off/on
    % ^NOTE: If load_from_ws is turned on, you must manually pre-load your
    %      data into the workspace and set your variable's name below to
    %      transfer data into the proper variables for the script:
if strcmp(Del_load_var,'on') == 1
    try
        DL_Xdata = yourvar; % <= substitute right-hand side with X variable
        DL_Ydata = yourvar; % <= substitute left-hand side with Y variable
        % ^NOTE: If you have a 2 column variable, you can use yourvar(:,1)
        %      for the X variable and yourvar(:,2) for the Y variable.
        % ^NOTE: You don't need to set variables if load_from_ws is 'off'.
    catch Del_Error
        errordlg('Invalid variable selected','ERROR!');
    end
end

%  OTHER GOODIES
Del_LineWidth = 3; % <= Line width for plotting Gaussian/Lorentzian fx. 3
Del_Noise = 0.05; % <= Sets noise level from 0-1 times max intensity. 0.10
    % ^CAUTION: Don't go lower than 0.05 or you might pick noise as peaks.
    % ^CAUTION: Don't go above 1 or else no peaks can be picked.
Del_LimitPeaks = 'off'; % Turn on to specify peaks to use. on/off
    % ^NOTE: To use the peak limiter, you'll need to run once on off to
    %      find out how many peaks available.
    % ^NOTE: Use variables below to set the peak range based on # of peaks.
    Del_PeakMin = 1; % <= Minimum peak # for peak range.
    Del_PeakMax = 6; % <= Maximum peak # for peak range.
        % ^NOTE: Peak range can have same min/max # to plot one peak.
Del_Xdirection = 'reverse'; % <= Direction of X axis. normal/reverse
Del_disp_peaks = 'on'; % <= See which peaks were picked on plot. on/off
Del_disp_fit = 'on'; % <= See the function's fitted lines on plot. on/off
Del_disp_to_commandwindow = 'on'; % <= Outputs onto command window. on/off
pause off; % <= Turn on to see the plot build, piece by piece. on/off

%  === ONLY CODE USER CAN MODIFY! - END - ONLY CODE USER CAN MODIFY! ===


%  =============================== DLPeaks.m ==============================
%  ------------------------------------------------------------------------
%  ----------------------- Created 27 November 2012 -----------------------
%  ---------------------- By David Lee (@lisdavid89) ----------------------
%  ------------------------------------------------------------------------
%  ========================= !!! TERMS OF USE !!! =========================
%  
%  This script is free to use, and can be modified or used in any way as
%  long as it stays within the usage terms set forth by The MathWorks, Inc.
%  The author, David Lee, takes no responsibility for modified scripts that
%  harms/damages your computer. Use modified scripts at your own risk.
%  The author, David Lee, takes no responsibility for modified scripts that
%  violates the usage terms set by The MathWorks, Inc.
%  The author, David Lee, is in no way affiliated to The MathWorks, Inc.
%  and their partners.
%  MATLAB, Simulink and MathWorks® are registered trademarks of The
%  MathWorks, Inc. Other product or brand names may be trademarks or
%  registered trademarks of their respective holders.
%  
%  ========================================================================


%  === DO NOT MODIFY === START OF SCRIPT === DO NOT MODIFY ===
%  Starting up
disp('Starting up...');
try
    Del_Test = DL_Vars.Available == 1;
catch Del_Error
    DL_Vars.Available = 0;
end
if DL_Vars.Available == 1;
    Del_RunSection(1:6) = 0;
    %  Run with new data or re-run with old data
    Del_RunButton = questdlg('Do you want to run script as new?',...
        'Run new data or re-run old data:','Yes');
    Del_RunAns(1) = strcmp(Del_RunButton,'Yes');
    Del_RunAns(2) = strcmp(Del_RunButton,'No');
    Del_RunAns(3) = strcmp(Del_RunButton,'Cancel');
    if Del_RunAns(1) == 1
        Del_RunSection(1:5) = 1; % Run all user input sections.
    end
    if Del_RunAns(2) == 1
        disp('Re-running a section...');
        Del_RunOpt = {'Import file','Select columns','Select function',...
            'Set axes label','Replot','Cancel'};
        Del_RunMenu = menu('Select section to re-run:',Del_RunOpt);
        Del_RunSection(Del_RunMenu) = 1;
        if Del_RunSection(6) == 1
            Del_RunAns(3) = 1;
        end
    end
    if Del_RunAns(3) == 1
        disp('Cancelling script...');
        Del_RunSection(1:4) = 0;
    end
else
    Del_RunSection(1:4) = 1; % Run all user input sections.
end


%  === RUN IF SET BY USER FROM ABOVE - START ===
if strcmp(Del_load_var,'on') == 1
    Del_RunSection(1:2) = 0;
end
%  === RUN IF SET BY USER FROM ABOVE - END ===


%  === SECTION 1 START ===
if Del_RunSection(1) == 1
    Del_RunSection(2) = 1;
    %  Import file
    disp('Importing file...');
    [Del_FileName,Del_PathName,~] = uigetfile('*');
    DL_Vars.FullPathName = strcat(Del_PathName,Del_FileName);
    [~,~,Del_FileExt] = fileparts(DL_Vars.FullPathName);
    if sum(strcmp(Del_FileExt,{'.xls','.xlsx'})) >= 1
        DL_ImportedData.data = xlsread(DL_Vars.FullPathName); % Excel
    else
        DL_ImportedData = uiimport(DL_Vars.FullPathName); % Other types.
    end;
    try
        Del_TestImport = DL_ImportedData.data ~= 0;
    catch Del_Error % Fixes error for files with only data & no headers.
        DL_ImportedData.data = load(DL_Vars.FullPathName);
    end
    if strcmp(Del_FileExt,'.mat') == 1;
        Del_RunSection(1:4) = 0;
        disp('MatLab .mat files not supported');
    end
end
%  === SECTION 1 END ===


%  === SECTION 2 START ===
if Del_RunSection(2) == 1
    %  Select columns to use
    disp('Selecting columns to use...');
    Del_NumCols = size(DL_ImportedData.data,2);
    Del_ColOpt(1:Del_NumCols) = {''};
    Del_i = 1;
    for Del_i = 1:Del_NumCols
        Del_ColOpt{Del_i} = strcat('Column_',num2str(Del_i));
    end
    Del_DataCols(1) = menu('Select column to use for X data:',...
        Del_ColOpt);
    Del_DataCols(2) = menu('Select column to use for Y data:',...
        Del_ColOpt);
    DL_Xdata = DL_ImportedData.data(:,Del_DataCols(1));
    DL_Ydata = DL_ImportedData.data(:,Del_DataCols(2));
end
%  === SECTION 2 END ===


%  === SECTION 3 START ===
if Del_RunSection(3) == 1
    %  Select function to use
    disp('Selecting function to use...');
    DL_Vars.FuncSel(1:4) = 0;
    Del_FuncOpt = {'Gaussian','Lorentzian','Both','Average of both'};
    DL_Vars.FuncSel(menu('Select function to use on peaks:',...
        Del_FuncOpt)) = 1;
end
%  === SECTION 3 END ===


%  === SECTION 4 START ===
if Del_RunSection(4) == 1
    %  Set axes labels
    disp('Setting axes labels...');
    Del_LabelOpt.Resize = 'off';
    Del_LabelOpt.WindowStyle = 'normal';
    Del_LabelOpt.Interpreter = 'tex';
    DL_Vars.AxesLabels = inputdlg({'X-axis label:','Y-axis label:'},...
        'Axes Labels',1,{'Wavenumbers (cm^{-1})','Absorbance'},...
        Del_LabelOpt);
end
%  === SECTION 4 END ===


%  === SECTION 5 START ===
%  --- AUTOMATED SECTION - NO USER INPUT ---
if max(Del_RunSection) == 1
    %  Plots data
    disp('Plotting data...');
    Del_MinYdata = min(DL_Ydata);
    if Del_MinYdata < 0
        Del_MinYdata = 0;
    end
    Del_Xlimits = [min(DL_Xdata) max(DL_Xdata)];
    if strcmp(Del_disp_peaks,'off') == 1
        Del_Ylimits = [Del_MinYdata 1.02*max(DL_Ydata)];
    else
        Del_Ylimits = [Del_MinYdata 1.10*max(DL_Ydata)];
    end
    DL_Vars.figure = figure('PaperType','usletter','PaperSize',...
        [21.573595 27.91877],'Color',[1 1 1],'Position',[1 1 960 600]);
    DL_Vars.axes = axes('Parent',DL_Vars.figure,'LineWidth',1,...
        'FontSize',24,'XLimMode','manual','XLim',Del_Xlimits,'YLimMode',...
        'manual','YLim',Del_Ylimits,'XDir',Del_Xdirection);
    box(DL_Vars.axes,'on');
    hold(DL_Vars.axes,'all');
    plot(DL_Xdata,DL_Ydata,'LineStyle','-','LineWidth',3,'Marker',...
        'none','MarkerSize',10,'DisplayName','Ydata vs. Xdata','Color',...
        [0 0 0]);
    xlabel(DL_Vars.AxesLabels(1),'FontSize',30);
    ylabel(DL_Vars.AxesLabels(2),'FontSize',30);
    %  Pick peaks above the noise level & plots them
    disp('Picking and plotting peaks...');
    Del_NoiseLvl = Del_Noise*(max(DL_Ydata)-Del_MinYdata)+Del_MinYdata;
    Del_Ydata = DL_Ydata-Del_MinYdata;
    [Del_Peaks,Del_FWHMBounds] = mspeaks(DL_Xdata,Del_Ydata,...
        'HeightFilter',Del_NoiseLvl);
    DL_Peaks(1:size(Del_Peaks,1),1) = Del_Peaks(:,1);
    DL_Peaks(1:size(Del_Peaks,1),2) = Del_Peaks(:,2)+Del_MinYdata;
    if strcmp(Del_LimitPeaks,'on') == 1 && size(DL_Peaks,1) > Del_PeakMax
        DL_Peaks = DL_Peaks(Del_PeakMin:Del_PeakMax,:);
        Del_Peaks = Del_Peaks(Del_PeakMin:Del_PeakMax,:);
        Del_DotXlocs = DL_Peaks(:,1);
        Del_DotYpks = DL_Peaks(:,2)+(0.08*max(DL_Ydata));
    else
        Del_LimitPeaks = 'off';
        Del_DotXlocs = DL_Peaks(:,1);
        Del_DotYpks = DL_Peaks(:,2)+(0.08*max(DL_Ydata));
    end
    figure(DL_Vars.figure); hold on; hold all;
    if strcmp(Del_disp_peaks,'on') == 1
        pause(1);
        plot(Del_DotXlocs,Del_DotYpks,'LineStyle','none','LineWidth',3,...
            'Marker','v','MarkerSize',10,'Color',[1 0 0]);
    end
    %  Run selected function
    if DL_Vars.FuncSel(1) == 1
        Del_FuncType = ' Gaussian';
    end
    if DL_Vars.FuncSel(2) == 1
        Del_FuncType = ' Lorentzian';
    end
    if DL_Vars.FuncSel(3) == 1
        Del_FuncType = ' both';
        DL_Vars.FuncSel(1:3) = 1;
    end
    if DL_Vars.FuncSel(4) == 1
        Del_FuncType = ' average of both';
    end
    disp(strcat('Running',Del_FuncType,' function...'));
    if strcmp(Del_LimitPeaks,'on') == 1
        DL_FWHM = Del_FWHMBounds(:,2)-Del_FWHMBounds(:,1);
        DL_FWHM = DL_FWHM(Del_PeakMin:Del_PeakMax,1);
    else
        DL_FWHM = Del_FWHMBounds(:,2)-Del_FWHMBounds(:,1);
    end
    if strcmp(Del_disp_fit,'on') == 1
        if DL_Vars.FuncSel(1) == 1
            pause(1);
            Del_i = 1;
            for Del_i = 1:size(DL_Peaks,1)
                Del_a = Del_Peaks(Del_i,2);
                Del_b = Del_Peaks(Del_i,1);
                Del_c = DL_FWHM(Del_i,1);
                Del_Gauss = ...
                    (Del_a*exp(-((DL_Xdata-Del_b).^2.*(4*log(2)))./(...
                    Del_c.^2)))+Del_MinYdata;
                plot(DL_Xdata,Del_Gauss,'LineStyle','-','LineWidth',...
                    Del_LineWidth,'Marker','none','MarkerSize',10,...
                    'Color',[0 0.5 0]);
            end
        end
        if DL_Vars.FuncSel(2) == 1
            pause(1);
            Del_i = 1;
            for Del_i = 1:size(DL_Peaks,1)
                Del_a = Del_Peaks(Del_i,2);
                Del_b = Del_Peaks(Del_i,1);
                Del_c = DL_FWHM(Del_i,1);
                Del_Loren = ...
                    (0.5*Del_c*Del_a*((0.5*Del_c)./((DL_Xdata-Del_b).^2+...
                    (0.5*Del_c).^2)))+Del_MinYdata;
                plot(DL_Xdata,Del_Loren,'LineStyle','-','LineWidth',...
                    Del_LineWidth,'Marker','none','MarkerSize',10,...
                    'Color',[0 0 1]);
            end
        end
        if DL_Vars.FuncSel(4) == 1
            pause(1);
            Del_i = 1;
            for Del_i = 1:size(DL_Peaks,1)
                Del_a = Del_Peaks(Del_i,2);
                Del_b = Del_Peaks(Del_i,1);
                Del_c = DL_FWHM(Del_i,1);
                Del_Gauss = ...
                    (Del_a*exp(-((DL_Xdata-Del_b).^2.*(4*log(2)))./(...
                    Del_c.^2)))+Del_MinYdata;
                Del_Loren = ...
                    (0.5*Del_c*Del_a*((0.5*Del_c)./((DL_Xdata-Del_b).^2+...
                    (0.5*Del_c).^2)))+Del_MinYdata;
                Del_Mean = mean([Del_Gauss Del_Loren],2);
                plot(DL_Xdata,Del_Mean,'LineStyle','-','LineWidth',...
                    Del_LineWidth,'Marker','none','MarkerSize',10,...
                    'Color',[0.75 0 0.75]);
            end
        end
    end
end
%  --- AUTOMATED SECTION - NO USER INPUT ---
%  === SECTION 5 END ===


%  Finishing up
disp('Finishing up...');
disp('*Caution! Do not delete DL_ImportedData, DL_Vars, DL_Xdata, and');
disp('DL_Ydata if you plan to re-run script!');
DL_Vars.Available = 1;
if strcmp(Del_disp_to_commandwindow,'on')
    disp(' ');
    disp('Outputting peaks data...');
    pause(1);
    disp('      X-VALUES  Y-INTENSITIES     FWHM');
    disp('      --------  -------------    ------');
    format short g;
    disp([DL_Peaks DL_FWHM]);
    format short;
end
clearvars Del_*;
clearvars load_from_ws disp_peaks disp_fit;
pause off;
disp('...Done!');
%  === DO NOT MODIFY === END OF SCRIPT === DO NOT MODIFY ===