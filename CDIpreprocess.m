function [F2, dx] = CDIpreprocess(F0, bin, cutoff, recipe)

load(recipe);

%% pre-crop (for binning)

w0 = size(F0, 2);
if size(Mask1, 2) ~= w0
    error('Image and Mask1 sizes mismatch!');
end

rmd = mod(w0, bin);

if rmd ~= 0
    disp(['auto crop: ' int2str(w0) 'x' int2str(w0) ' => ' int2str(w0-rmd) 'x' int2str(w0-rmd)]);
    if mod(rmd, 2) == 0
        F0 = F0( (1+rmd/2):(end-rmd/2), (1+rmd/2):(end-rmd/2) );
        Mask1 = Mask1( (1+rmd/2):(end-rmd/2), (1+rmd/2):(end-rmd/2) );
    else
        if rmd == 1
            rmd = (bin-1);
            F0 = F0( (1+rmd):(end-rmd), (1+rmd):(end-rmd) );
            Mask1 = Mask1( round(rmd+1):(end-round(rmd)), round(rmd+1):(end-round(rmd)) );
        else
            warning('Image size and bin size mismatch. Symmetry migh lost!')
            F0 = F0( round(1+rmd/2):(end-round(rmd/2)), round(1+rmd/2):(end-round(rmd/2)) );
            Mask1 = Mask1( round(rmd/2):(end-round(rmd/2)), round(rmd/2):(end-round(rmd/2)) );
        end
    end
end

%% binning

F0bin = bin3(F0, bin);
M0bin = bin3(Mask1, bin);

F0bin( M0bin > 0 ) = 0;

if cutoff < 1
    [kk, F0ringsum] = ringsum(F0bin);

    F0ringsum = F0ringsum - cutoff*max(F0ringsum(:));

    cross_inds = find( F0ringsum(1:(end-1)) .* F0ringsum(2:end) < 0);

    if length(cross_inds) > 1
        crop_size = round( (length(F0bin) - 1 - cross_inds(2) )/2 );
        disp(['auto cut-off: ' int2str(length(F0bin)) 'x' int2str(length(F0bin)) ' => ' int2str(length(F0bin)-2*crop_size) 'x' int2str(length(F0bin)-2*crop_size)]);
    else
        warning('Unable to cut-off.');
        crop_size = 0;
    end
else
    crop_size = cutoff;
end
F1 = F0bin( (1+crop_size):(end-crop_size), (1+crop_size):(end-crop_size) );

%% symmetrize 

F1r = rot90(F1, 2);

mk1 = F1 > 0;
mk2 = F1r > 0;

F2 = 0.5 * (F1 + F1r);
F2( ~mk1 & mk2 ) = F1r( ~mk1 & mk2 );
F2( mk1 & ~mk2 ) = F1( mk1 & ~mk2 );

dx = lam * z1 / length(F2) / du / bin;

