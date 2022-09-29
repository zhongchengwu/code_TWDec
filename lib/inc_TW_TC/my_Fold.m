function W = my_Fold(W, dim, i)
n=1:length(dim); n(i)=[]; m=zeros(length(dim),1);
m(1)=i;  m(2:end)=n;
W = reshape(W, dim(m));
W = ipermute(W,m);
end