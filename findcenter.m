function [y_shift, x_shift] = findcenter(img)

sigma = 0.1;

%%%%% x shift %%%%%

xproj = sum(img, 1);
x = linspace(-0.5, 0.5, size(xproj, 2));
G = exp( -(x./sigma).^2./2);
xproj2 = xproj .* (1- G);

xc = xcorr( xproj2, fliplr( xproj2 ) );
[cy, cx] = findpeaks( double(xc), 'SORTSTR', 'descend' );

x_xc = -(length(xproj2)-1):(length(xproj2)-1);
x_shift = x_xc( cx(1) );

%%%%% y shift %%%%%

yproj = sum(img, 2).';
y = linspace(-0.5, 0.5, size(yproj, 2));
G = exp( -(y./sigma).^2./2);
yproj2 = yproj .* (1- G);

xc = xcorr( yproj2, fliplr( yproj2 ) );
[ry, rx] = findpeaks( double(xc), 'SORTSTR', 'descend' );

y_xc = -(length(yproj2)-1):(length(yproj2)-1);
y_shift = y_xc( rx(1) );
