%% =================================================================
% This script runs the TW decomposition-based TC (TW-TC) code
%
% Please make sure your data is in range [0, 1].
%
% Reference: Zhong-Cheng Wu, Ting-Zhu Huang*, Liang-Jian Deng*, Hong-Xia Dou, Deyu Meng
%            "Tensor Wheel Decomposition and Its Tensor Completion Application"
%             NeurIPS, 2022.
%
% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Sep. 20, 2021
% Updated by 
% Sep. 15, 2022

%% =================================================================
clc;
clear;
close all;
addpath(genpath([pwd,'/lib']));
addpath(genpath([pwd,'/data']));
%%
load('CAVE_Toy.mat')
X(X<0) = 0;
if max(X(:))>1
    X = X/max(X(:));
end
%% 
sample_ratio = 0.10;
fprintf('### Performing SR: %4.2f ###\n', sample_ratio);
Y_tensor = X;
clear X
Ndim = ndims(Y_tensor);
Nway = size(Y_tensor);
rand('seed',2);
Omega = find(rand(prod(Nway),1)<sample_ratio);
Y_init = initialization_M(Nway, Omega, Y_tensor(Omega));
%%
Algorithms = {'Observed','TW-TC'};
EN_TW_TC = 1;
A_num = length(Algorithms);
Re_tensor = cell(A_num,1);
NumIndexes = 2;  
MatrixResults = zeros(A_num, NumIndexes);
MatrixTimes = zeros(A_num, 1);
alg = 0;
fprintf('###################### Please wait......######################\n')
%% Miss_Data
alg = alg+1;
F = zeros(Nway);
F(Omega) = Y_tensor(Omega);
Re_tensor{alg} = F;
[MatrixResults(alg,:)] = quality_access(Y_tensor*255, Re_tensor{alg}*255);
%% Perform Our TW-TC Algorithm
alg = alg+1;
if EN_TW_TC
    fprintf('\n');
    disp(['performing ',Algorithms{alg}, ' ... ']);
    % Initialization of the parameters
    % Please refer to our paper to set the parameters
    opts = [];
    opts.tol   = 1e-5;
    opts.maxit = 1000;
    opts.rho   = 0.001;
    opts.Xtrue = Y_tensor;
    opts.R = [3, 15, 3; % R_i
              3, 3, 3]; % L_i
    t_s = tic;
    [Re_tensor{alg}, G, C, Out] = inc_TW_TC(Y_init, Omega, opts);
     MatrixTimes(alg,:) = toc(t_s);
    [MatrixResults(alg,:)] = quality_access(Y_tensor*255, Re_tensor{alg}*255);
end
%
fprintf('###################### Complete execution! ! !######################\n')
%% Show result
location  = [10 50 45 85];
range_bar = [0, 0.2];
%
Image_truncate(Y_tensor, Re_tensor, location)    % Display the RGB images
%
Image_residual(Y_tensor, Re_tensor, range_bar)   % Display the error maps 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%