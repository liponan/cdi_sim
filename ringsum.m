function [f, k] = ringsum(F)
if size(F,1) ~= size(F,2)
    error('must be a odd-numbered square');
end
if mod(size(F,1), 2) == 0
    error('must be odd');
end

hx = (size(F, 1) - 1) / 2;

f = 0:hx;
k = zeros(size(f));
x = -hx:hx;
[X, Y] = meshgrid(x, x);
R = sqrt( X.^2 + Y.^2 );

for t = 1:length(f)
    k(t) = sum(F(R>=f(t) & R<(f(t)+1) ) );
end

%     k(end) = sum(F(R>=f(t) ) );

end