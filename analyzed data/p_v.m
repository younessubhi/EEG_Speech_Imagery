%% P-value analysis

% H_0: my = no difference
% H_0: my = 0.5 (TP)
% H_a: binary = 1.0
% Arbitary significance threshold of 5 percent .. alpha = 0.05
% sample mean xi

%%
close all; clear all; clc;
%% load data

load('BothTable.mat')
load('MaleTable.mat')
load('FemaleTable.mat')

%% extract TP, TN, FP, FN
% multiply by 2, since range is 0-0.5

TP_b = BothTable(:,1) * 2
TN_b = BothTable(:,2) * 2
FP_b = BothTable(:,3) * 2
FN_b = BothTable(:,4) * 2

TP_m = MaleTable(:,1) * 2
TN_m = MaleTable(:,2) * 2
FP_m = MaleTable(:,3) * 2
FN_m = MaleTable(:,4) * 2

TP_f = FemaleTable(:,1) * 2
TN_f = FemaleTable(:,2) * 2
FP_f = FemaleTable(:,3) * 2
FN_f = FemaleTable(:,4) * 2

%% Mean of true positives (sample mean)

TP_b_mean = sum(TP_b)/length(TP_b)
TP_m_mean = sum(TP_m)/length(TP_m)
TP_f_mean = sum(TP_f)/length(TP_f)

%% Test null hypothesis

H_0 = 0.5

% chi square

x2 = ((TP_f_mean-H_0)^2/H_0)
