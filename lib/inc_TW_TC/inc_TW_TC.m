function [X, G, Core, Out] = inc_TW_TC(F, Omega, opts)
if isfield(opts, 'tol');         tol   = opts.tol;              end
if isfield(opts, 'maxit');       maxit = opts.maxit;            end
if isfield(opts, 'rho');         rho   = opts.rho;              end
if isfield(opts, 'R');           max_R = opts.R;                end
%
num_padarray = 2;
R = max(max_R-num_padarray, 2);
Ndim = ndims(F); 
Nway = size(F);
X = F;
%
Factors_dims = factor_dims(Nway, R);
Max_Factors_dims = factor_dims(Nway, max_R);
rng('default')
%
G = cell(Ndim,1);
for i=1:Ndim
    G{i}=rand(Factors_dims(i,:));
end
Core = rand(R(2,:));
C_old = Core;
Out.RSE = [];
r_change = 0.0005;
%
for k = 1:maxit
    X_old = X;
    % Update G_k, k=1,2,...,N.
    for num = 1:Ndim
        GCrest = tenremat(circ_tnprod_rest(G,Core,num), Ndim);  % Q is the right part of the relation equation
        TempA  = tenmat_sb(X,num)*GCrest'+rho*my_Unfold(G{num},size(G{num}),2);
        TempB  = (GCrest*GCrest')+rho*eye(size(GCrest,1),size(GCrest,1));
        G{num} = my_Fold(TempA*pinv(TempB),size(G{num}),2);
    end
    % Update the core tensor C.
    Girest = tnreshapemat(order_tnprod_rest(G), Ndim);
    if k<=200 || numel(Core)>numel(C_old) || mod(k,20)==0
        TempC = reshape(X,[1,prod(Nway)])*Girest'+rho*reshape(Core,[1,numel(Core)]);
        TempD = (Girest*Girest')+rho*eye(size(Girest,1),size(Girest,1));
        TempE = TempC*pinv(TempD);
        Core = reshape(TempE,size(Core));
    end
    % Update X 
    X = (reshape(TempE*Girest,Nway)+rho*X_old)/(1+rho);
    X(Omega) = F(Omega);
    %% check the convergence
    rse = norm(X(:)-X_old(:)) / norm(X_old(:));
    Out.RSE = [Out.RSE, rse];
    
    if k == 1 || mod(k, 20) == 0
        fprintf('inc_TW-TC: iter = %d   RSE=%.10f   \n', k, rse);
    end

    if rse < tol 
        break;
    end
    
    C_old = Core;
    rank_inc = double(Factors_dims<Max_Factors_dims);
    if rse<r_change && sum(rank_inc(:))~=0
        [G, Core] = rank_inc_adaptive(G, Core, rank_inc, Ndim);
        Factors_dims  = Factors_dims+rank_inc;
        r_change = r_change*0.1;
    end
end
end


function [G, Core] = rank_inc_adaptive(G, Core, rank_inc, N)
    % increase the estimated rank until max_R
    for j = 1:N
    G{j} = padarray(G{j}, rank_inc(j,:), rand(1), 'post');
    end
    Core = padarray(Core, rank_inc(:,3), rand(1), 'post');
end
