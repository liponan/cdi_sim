% Po-Nan Li 2014/10/29

recipe_name = 'SACLA201406';

clear all;
%% Physical constants

% detector 1
N1 = 2399;
lam = 0.31e-9;
z1 = 1.321;
du = 50e-6;
dx1 = lam * z1 / N1 / du;

% detector 2
N2 = 1100;
z1 = 2.7;
dx2 = lam * 2 / N2 / du;

%% Missing pixels

% detector 1

load SACLA_Mask1;
% left
Mask1(1239:1243, 1:1169) = true;
% right
Mask1(1165:1173, 1230:1236) = true;
Mask1(1165:1166, 1237:end) = true;
% top
Mask1(1:1173, 1170:1172) = true;
% bottom
Mask1(1244:end, 1232:1236) = true;

%% save

save('recipe_name', '*');
clear all;