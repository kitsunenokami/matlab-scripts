del_a = DL_Peaks(1,2);
del_b = DL_Peaks(1,1);
del_c = DL_FWHM;

DL_Gauss = del_a*exp(-((DL_Xdata-del_b).^2.*(4*log(2)))./(del_c.^2));

figure(DL_Vars.figure); hold on; hold all;
plot(DL_Xdata,DL_Gauss,'LineStyle','-','LineWidth',3,...
            'Marker','none','MarkerSize',10,'Color',[1 0 0]);