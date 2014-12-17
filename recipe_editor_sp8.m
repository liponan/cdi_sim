% Po-Nan Li 2014/10/29
clear all;

recipe_name = 'SP8_ideal';
%% Physical constants

Iph = 1.18e19; % [phs/m^2/sec]
dt = 1000;

% detector 1
N1 = 1639;
lam = 0.227e-9;
z1 = 2.3;
du = 20e-6;
dx1 = lam * z1 / N1 / du;

% detector 2
N2 = 1639;
z2 = 2.3;
dx2 = lam * z2 / N2 / du;

%% Missing pixels

% detector 1
load SP8_Mask;
Mask1 = false(size(SP8_Mask));
% detector 2
Mask2 = false(size(SP8_Mask));


%% save

save(recipe_name, '*');
clear all;