clc;
clear all;
close all;
load('colors');
% -------------------------------------------------------------------------
nb = 1.45;
% -------------------------------------------------------------------------
filename = 'data_16';

num_bands =  4;
data = importdata(['data/',filename,'_zoddyevenfreqs.dat']);

tabl = data.data;
kind = tabl(:,1);
kx = tabl(:,2);
for ii = 6:6+(num_bands-1)
    wval = tabl(:,ii);
    hold on; plot(kx,wval,'o-','color',darkblue,'linewidth',2)
end
clear data wval;

data = importdata(['data/',filename,'_zoddyoddfreqs.dat']);
tabl = data.data;
kind = tabl(:,1);
kx = tabl(:,2);
for ii = 6:6+(num_bands-1)
    wval = tabl(:,ii);
    hold on; plot(kx,wval,'*-','color',darkred,'linewidth',2)
end
clear data wval;

data = importdata(['data/',filename,'_zevenyevenfreqs.dat']);
tabl = data.data;
kind = tabl(:,1);
kx = tabl(:,2);
for ii = 6:6+(num_bands-1)
    wval = tabl(:,ii);
    hold on; plot(kx,wval,'d-','color',darkgreen,'linewidth',2)
end
clear data wval;

data = importdata(['data/',filename,'_zevenyoddfreqs.dat']);
tabl = data.data;
kind = tabl(:,1);
kx = tabl(:,2);
for ii = 6:6+(num_bands-1)
    wval = tabl(:,ii);
    hold on; plot(kx,wval,'^-','color',darkyellow,'linewidth',2)
end
clear data wval;

% -------------------------------------------------------------------------
set(gca,'xlim',[0.2 kx(length(kx))],'ylim',[0 0.5],'box','on');
hold on; get_1D_light_cone2(kx,0.5,nb,0.5,'b');
% -------------------------------------------------------------------------

