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

% Alex: These tables contain 'True positive', 'True negative', 'False
% positive' and 'False negative' from our classification results.
    %YOUNES: Yes. We are comparing our 'True positives' (TP) with a null
    %           hypothesis of TP rate = 50%
%T They do
% not represent EEG activity in anyway. Performing statistical tests on
% this data gives no insight really. Unless, we statistically wanna show
% that data from women are easier to classify than from men
    %YOUNES: they contain information on whether we see any brain
    %          acitivity, other than the expected noise.
%% remove outliers (subj 6 (M))

% Alex: It is good common practice to supress output and to comment each
% step if possible. Both for yourself and other readers.
    % YOUNES: fair! I usually do not use it when deviding the code to
    % sections. It allows me to track the print.
B_out = BothTable;               % Alex: Redundant step: confuses you later on
                                    % YOUNES: :) I like to put all '.mat'
                                    %           files in variables
% B_out(6,:) = []         % Alex: I disagree (also with Sada) I think outliers should not be removed

    % YOUNES: I see your point. Let's run the analysis without removing outliers.
    %          

M_out = MaleTable;
% M_out(6,:) = []

%% extract TP, TN, FP, FN
% multiply by 2, since range is 0-0.5

% Alex: This should not be multiplied with 2. The tables holding TP, TN, FP
% and FN is in percentage. summing along the columns adds to 1 for each
% subject. Try and write "sum(BothTable,2)" in the command window (sums
% along the 2nd dimension.

    % YOUNES: will run without '* 2' 

TP_b = BothTable(:,1); %* 2
TN_b = BothTable(:,2); %* 2
FP_b = BothTable(:,3); %* 2
FN_b = BothTable(:,4); %* 2

TP_m = MaleTable(:,1); %* 2
TN_m = MaleTable(:,2); %* 2
FP_m = MaleTable(:,3); %* 2
FN_m = MaleTable(:,4); %* 2

TP_f = FemaleTable(:,1); %* 2
TN_f = FemaleTable(:,2); %* 2
FP_f = FemaleTable(:,3); %* 2
FN_f = FemaleTable(:,4); %* 2

TP_b_out = B_out(:,1); %* 2   % Alex: this is where "B_out = BothTable" meaing this is equal to "TP_b = BothTable(:,1) * 2"
TP_m_out = M_out(:,1); %* 2   % Same redundancy
    % YOUNES: see comment from earlier
%% Mean of true positives (sample mean)

    % thanks for the tip!

TP_b_mean = sum(TP_b)/length(TP_b);
TP_m_mean = sum(TP_m)/length(TP_m);
TP_f_mean = sum(TP_f)/length(TP_f);
TP_b_out_mean = sum(TP_b_out)/length(TP_b_out);
TP_m_out_mean = sum(TP_m_out)/length(TP_m_out);

%% standard deviation

TP_b_std = std(TP_b);
%% Test null hypothesis
% Alex: I do not understand this step
    % defining the null hypothesis
H_0 = 0.25;

%% chi square
% Alex: I am not very familiar with chi squared tests, so cannot comment
% here
%x2 = ((TP_b_mean-H_0)^2/H_0) * 100

%% t-test

% t value
% Alex: If what we there seek to test is wether we have gained the TP rate
% by pure chance, then the steps sort-of make sense, but are still
% errorneous.
% Since we multiplied by 2 to get TP_b_mean ( which we shouldn't have done)
% then the expected True positive rate would definitely be 0.5 as out H_0.
% Otherwise it woul have been 0.25 by pure chance.
    % YOUNES: What do you mean by as out H_0?
    % YOUNES: 
x_bar1 = TP_b_mean;
x_bar2 = H_0;

signal = x_bar1 - x_bar2;

% variance

s1 = TP_b_std^2;     % Alex: standard deviation will also be altered my the maligneous multiplication of 2
s2 = std(H_0)^2;     % Alex: Taking standard deviation of a scalar is always 0,

n1 = 17;
n2 = 1;
% Alex: I quickly had to brush up some statistics, so might be wrong about
% some of the things. This seem to be a two-sample t-test. But since we
% compare one sample to "made-up" expectations, we would need to do a
% one-sample t-test

t_value = (x_bar1 - x_bar2) / (sqrt((s1 / 17) + (s2 / 1)));

% t test
% alternatively using ttest()
% Alex: This test examines if TP_b is a vector of data with unknown
% variance from a collection with mean zero. i.e. H_0 = 0. This test is
% okay if you subtract H_0 from each element in the vector.

    % YOUNES: let's do that

TP_b - H_0;

[h, p, ci, stats] = ttest(TP_b)