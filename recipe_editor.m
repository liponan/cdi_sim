% Po-Nan Li 2014/10/29
clear all;

recipe_name = 'SACLA201412';
%% Physical constants

Iph = 6.225e36; % [phs/m^2/sec]
dt = 10e-15;

% detector 1
N1 = 2399;
lam = 0.31e-9;
z1 = 1.52;
du = 50e-6;
dx1 = lam * z1 / N1 / du;

% detector 2
N2 = 1100;
z2 = 3.05;
dx2 = lam * z2 / N2 / du;

%% Missing pixels

% detector 1
load SACLA201412_Mask1;
% left
Mask1(1229:1236, 1:1154) = true;
% right
% Mask1(1165:1173, 1230:1236) = true;
Mask1(1155:1156, 1247:end) = true;
% top
Mask1(1:1153, 1156:1159) = true;
% bottom
Mask1(1236:end, 1239:1246) = true;

% Q2
Mask1(727, 1:1155) = true;
% Q4
Mask1(1970:end, 1759) = true;


% detector 2
load SACLA_Mask2;
Mask2(:) = true;
% Mask2(521:651, 521:642) = false;
% Mask2(547:551, : ) = true;
% Mask2(558:end, 557:end) = true;

Mask2 = circshift(Mask2, [-30 -30]);


%% save

save(recipe_name, '*');
clear all;