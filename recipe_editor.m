% Po-Nan Li 2014/10/29
clear all;

recipe_name = 'SACLA201406';
%% Physical constants

Iph = 6.225e36; % [phs/m^2/sec]
dt = 10e-15;

% detector 1
N1 = 2399;
lam = 0.31e-9;
z1 = 1.321;
du = 50e-6;
dx1 = lam * z1 / N1 / du;

% detector 2
N2 = 1100;
z2 = 2.7;
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

% detector 2
load SACLA_Mask2;
Mask2(:) = true;
Mask2(521:651, 521:642) = false;
Mask2(547:551, : ) = true;
Mask2(558:end, 557:end) = true;


%% save

save(recipe_name, '*');
clear all;