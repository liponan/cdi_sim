function b = padarray2(a, sz)
if length(sz) > 1
    n1 = sz(1);
    n2 = sz(2);
else
    n1 = sz;
    n2 = sz;
end

    b = zeros(size(a,1)+n1*2, size(a,2)+n2*2);
    b((1+n1):(end-n1), (1+n2):(end-n2)) = a;


end