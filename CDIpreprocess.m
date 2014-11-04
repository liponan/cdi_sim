function F1 = CDIpreprocess(F0, bin, cutoff, recipe)

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
        warning('Image size and bin size mismatch. Symmetry migh lost!');
        Mask1 = Mask1( round(rmd/2):(end-round(rmd/2)), round(rmd/2):(end-round(rmd/2)) );
    end
end

F0bin = bin3(F0, bin);
M0bin = bin3(Mask1, bin);

F0bin( M0bin > 0 ) = 0;

[kk, F0ringsum] = ringsum(F0bin);

F0ringsum = F0ringsum - cutoff*max(F0ringsum(:));

cross_inds = find( F0ringsum(1:(end-1)) .* F0ringsum(2:end) < 0);

crop_size = round( (length(F0bin) - 1 - cross_inds(2) )/2 );
F1 = F0bin( (1+crop_size):(end-crop_size), (1+crop_size):(end-crop_size) );


