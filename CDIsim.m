function [I1, img1, I2, img2, beta1, beta2] = CDIsim(img, recipe)

% load recipe
load(recipe);

%% analyze input image

dx0 = 1e-9;

w0 = size(img, 2);
h0 = size(img, 1);

% check oversampling ratio
if min(w0, h0) > N1
    error('oversampling ratio insufficient for the input sample size');
end

xx0 = 0:dx0:(dx0*(w0-1));
yy0 = 0:dx0:(dx0*(h0-1));

%% generate I1

xx1 = 0:dx1:(dx0*( max(w0, h0) - 1 ));

img1 = interp2(xx0, yy0.', img, xx1, xx1.');
img1( isnan(img1) ) = 0;

img1 = img1 ./ sum(img1(:)) .* sum(img(:)); % density normalization

img1_pad = N1 - length(xx1);
if mod(img1_pad, 2) == 0
    img1 = padarray(img1, [(img1_pad/2) (img1_pad/2)]);
else
    img1_pad = img1_pad + 1;
    img1 = padarray(img1, [(img1_pad/2) (img1_pad/2)]);
    img1 = img1(2:end, 2:end);
end
    
re = 2.81794e-15; % meter
beta1 = Iph*re^2/z1^2*du^2*dt;

I1 = abs( fftshift(fft2(img1)) ).^2;
I1 = poissrnd( beta1 * I1 ) ./ beta1;
I1( Mask1 ) = 0;

%% generate I2

xx2 = 0:dx2:(dx0*( max(w0, h0) - 1 ));

img2 = interp2(xx0, yy0.', img, xx2, xx2.');
img2( isnan(img2) ) = 0;

img1 = img1 ./ sum(img1(:)) .* sum(img(:)); % density normalization

img2_pad = N2 - length(xx2);
if img2_pad > 0
    if mod(img2_pad, 2) == 0
        img2 = padarray(img2, [(img2_pad/2) (img2_pad/2)]);
    else
        img2_pad = img1_pad + 1;
        img2 = padarray(img2, [(img2_pad/2) (img2_pad/2)]);
        img2 = img2(2:end, 2:end);
    end
end
    
re = 2.81794e-15; % meter
beta2 = Iph*re^2/z2^2*du^2*dt;

I2 = abs( fftshift(fft2(img2)) ).^2;
I2 = poissrnd( beta2 * I2 ) ./ beta2;
I2( Mask2 ) = 0;

