function [Y, y0, y1] = align2(A, B, n)

errs = zeros(2*n+1, 2*n+1);

B = padarray2(B, [n n]);
A = padarray2(A, [n n]);

for u = -n:n
    for v = -n:n
        errs(u+n+1,v+n+1) = sum(sum( abs( A - circshift(B, [u v]) ).^2 ));
    end
end

[u0, v0, y0] = findpeaks2(-errs);

for u = -n:n
    for v = -n:n
        errs(u+n+1,v+n+1) = sum(sum( abs( A - circshift(rot90(B, 2), [u v]) ).^2 ));
    end
end

[u1, v1, y1] = findpeaks2(-errs);

if y0(1) > y1(1)
    Y = circshift(B, [u0(1)-n-1 v0(1)-n-1]);
else
    Y = circshift(rot90(B, 2), [u1(1)-n-1 v1(1)-n-1]);
end
Y = Y((1+n):(end-n), (1+n):(end-n));

end