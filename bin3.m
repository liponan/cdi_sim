function B = bin3(A, n)

if mod(size(A, 1), n) ~= 0
    warning(['The length in the #1 dimension is not the mutiple of ' int2str(n)]);
end
if mod(size(A, 2), n) ~= 0
    warning(['The length in the #2 dimension is not the mutiple of ' int2str(n)]);
end
if length(size(A)) < 3
    A2 = zeros(ceil(size(A,1)/n)*n, ceil(size(A,2)/n)*n);
    B = zeros(ceil(size(A,1)/n), ceil(size(A,2)/n));
    A2(1:size(A,1), 1:size(A,2)) = A;

    ln1 = size(B,1) - 1;
    ln2 = size(B,2) - 1;

    for u = 1:n
        for v = 1:n
            B = B + A2(u+n*(0:ln1), v+n*(0:ln2)) ;
        end
    end
else
    if mod(size(A, 3), n) ~= 0
    warning(['The length in the #3 dimension is not the mutiple of ' int2str(n)]);
    end
    
    A2 = zeros(ceil(size(A,1)/n)*n, ceil(size(A,2)/n)*n, ceil(size(A,3)/n)*n);
    B = zeros(ceil(size(A,1)/n), ceil(size(A,2)/n), ceil(size(A,3)/n));
    A2(1:size(A,1), 1:size(A,2), 1:size(A,3)) = A;

    ln1 = size(B,1) - 1;
    ln2 = size(B,2) - 1;
    ln3 = size(B,3) - 1;

    for w = 1:n
        for u = 1:n
            for v = 1:n
                B = B + A2(u+n*(0:ln1), v+n*(0:ln2), w+n*(0:ln3)) ;
            end
        end
    end
    
    
end

end
