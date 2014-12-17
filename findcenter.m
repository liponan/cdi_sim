% function [rshift, cshift] = findcenter(img)
% 
close all;
%%%%% x shift %%%%%
xproj = sum(img1, 1);
% xproj(1, 1159:1231) = 0;

sigma = 0.1;
x = linspace(-0.5, 0.5, size(xproj, 2));
G = exp( -(x./sigma).^2./2);
xproj2 = xproj .* (1- G);

figure(201),
plot(x, xproj2);

xc = xcorr( xproj2, fliplr( xproj2 ) );

[cy, cx] = findpeaks( double(xc), 'SORTSTR', 'descend' );

x_xc = -(length(xproj2)-1):(length(xproj2)-1);
x_shift = x_xc( cx(1) );

figure(202),
plot( x_xc, xc, x_shift, cy(1), 'ro');
title(['x-shift = ' int2str(x_shift)]);

figure(203),
plot(x, xproj2, x, circshift(fliplr(xproj2), [0 x_shift]));
title(['x-shift = ' int2str(x_shift)]);



%%%%% y shift %%%%%
yproj = sum(img1, 2).';
% xproj(1, 1159:1231) = 0;


y = linspace(-0.5, 0.5, size(yproj, 2));
G = exp( -(y./sigma).^2./2);
yproj2 = yproj .* (1- G);

figure(301),
plot(y, yproj2);

xc = xcorr( yproj2, fliplr( yproj2 ) );

[ry, rx] = findpeaks( double(xc), 'SORTSTR', 'descend' );

y_xc = -(length(yproj2)-1):(length(yproj2)-1);
y_shift = y_xc( rx(1) );

figure(302),
plot( y_xc, xc, y_shift, ry(1), 'ro');
title(['y-shift = ' int2str(y_shift)]);

figure(303),
plot(y, yproj2, y, circshift(fliplr(yproj2), [0 y_shift]));
title(['y-shift = ' int2str(y_shift)]);