function get_1D_light_cone2(kval,yextra,nb,mp,colo)

% kval = kvec/(2*pi/a);
% yextra = Ln(2);
x = kval;
y = kval/nb;
% hold on; plot(x,y,'k-','linewidth',2);
ex = [0 yextra];
% X = [x(1) ex(1) x(length(x))];
% Y = [y(1) ex(2) y(length(y))];
X = [x(1) x(1)  x(length(x)) x(length(x))];
Y = [y(1) ex(2) ex(2)        y(length(y))];
h2 = fill(X,Y,colo); 
set(h2, 'EdgeColor','none', 'FaceAlpha', 1);


if(mp == 1)
x2 = 1-x;
% hold on; plot(x2,y2,'k-','linewidth',2);
ex = [1 yextra];
X2 = [x2(1) x2(1)  x2(length(x)) x2(length(x))];
Y2 = [y(1) ex(2) ex(2)        y(length(y))];
h3 = fill(X2,Y2,colo); 
set(h3, 'EdgeColor','none', 'FaceAlpha', 1);
end