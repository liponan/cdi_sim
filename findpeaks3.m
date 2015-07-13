function [r, c, l, y] = findpeaks3(data)
[h w d] = size(data);
r = 0;
c = 0;
l = 0;
y = 0;
t = 1;
for u = 2:(h-1)
    for v = 2:(w-1)
        for k = 2:(d-1)
            if (data(u,v,k) > data(u+1,v,k)) && (data(u,v,k) > data(u,v+1,k)) && (data(u,v,k) > data(u-1,v,k)) && (data(u,v,k) > data(u,v-1,k))
                if ((data(u,v,k) > data(u,v,k-1)) && (data(u,v,k) > data(u,v,k+1)))
                    r(t) = u;
                    c(t) = v;
                    l(t) = k; 
                    y(t) = data(u,v,k);
                    t = t+1;
                end
            end
        end
    end
end

[y, si] = sort(y ,'descend'); % si = sorted index
r = r(si);
c = c(si);
l = l(si);

end