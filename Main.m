clear all; close all; clc;
addpath('.')
cd ./recordings/MaleSubjs
K = 10;     % k-fold validation
eSz = 600;
lag = 500;
d = dir;
D = {d.name}; clear d;
N = length(D)-2;

% Preallocation
TP = zeros(N,1);FP = zeros(N,1);TN = zeros(N,1);FN = zeros(N,1);


for k = 1:N
    tic
    str = strcat('cd ./Subj',num2str(k));
    eval(str)
    
    [nts,~,smi,~] = TrialsMerge;
    [TP(k),FP(k),TN(k),FN(k),W] = KFoldValidate(nts', smi',K,lag,eSz);
    cd ..
    W2 = mean(W,3);
    figure
    for II = 1:16
        subplot(4,4,II)
        topoplot(W2(:,II),'channel_locations.loc');
    end
    toc
    
    
end

cd ..
MaleTable = [TP,FP,TN,FN];
cd ./FemaleSubjs/

d = dir;
D = {d.name}; clear d;
N = length(D)-2;

% Preallocation
TP = zeros(N,1);FP = zeros(N,1);TN = zeros(N,1);FN = zeros(N,1);


for k = 1:N
    tic
    str = strcat('cd ./Subj',num2str(k));
    eval(str)
    
    [nts,~,smi,~] = TrialsMerge;
    [TP(k),FP(k),TN(k),FN(k),W] = KFoldValidate(nts', smi',K,lag,eSz);
    cd ..
    W2 = mean(W,3);
    figure
    for II = 1:16
        subplot(4,4,II)
        topoplot(W2(:,II),'channel_locations.loc');
    end
    toc
    
end

FemaleTable = [TP,TN,FP,FN];

cd ../..
