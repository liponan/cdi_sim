function G = gaussian(h, w, tau)

hx1 = ceil(w-1)/2;
hy1 = ceil(h-1)/2;
hx2 = floor(w-1)/2;
hy2 = floor(h-1)/2;

[X, Y] = meshgrid(-hx1:hx2, -hy1:hy2);

R = sqrt(X.^2 + Y.^2);

G = exp(-(R./2./tau).^2);

end