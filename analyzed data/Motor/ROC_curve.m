%% ROC curve

load('BothTable.mat')
load('FemaleTable.mat')
load('MaleTable.mat')

TP_b = BothTable(:,1) % true positive values
FP_b = BothTable(:,3) % false positive values

%TP_m = MaleTable(:,1)
%FP_m = MaleTable(:,3)

%TP_f = FemaleTable(:,1)
%FP_f = FemaleTable(:,3)

FPTP = [FP_b; TP_b]

mdl = fitglm(FP_b, TP_b, 'Distribution', 'binomial', 'Link', 'logit');
scores = mdl.Fitted.Probability; % probability estimates

[X, Y, T, AUC] = perfcurve(FPTP, scores, 'Classified');
