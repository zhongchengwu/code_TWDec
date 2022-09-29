function W = my_Unfold(W, dim, i)
n=1:length(dim); 
n(i)=[]; 
m=zeros(length(dim),1);
m(1)=i;
m(2:end)=n;
W = permute(W,m);
W = reshape(W, dim(i), []);
end