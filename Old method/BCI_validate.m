function [TP,FP,TN,FN] = BCI_validate(trainData1,trainData2,testData1,testData2,eLen,eLag)
% trainData:        Training data rows = EEG channels
% testData:         Testing data rows = EEG channels
% eLen:             Epoch length [samples]
% eLag:             Step size for different epochs [samples]

W = CSP_Weight(trainData1,trainData2);
%% Train data 1 epoching
cli = 1;     % current lag index
cl = eLag*cli-(eLag-1);     % current lag sample
while cl+eLen-1<=size(trainData1,2)
    epoch = trainData1(:,cl:cl+eLen-1);  %Extracting epoch for testing
    s = W' * epoch;
    y1(cli,:) = log10(var(s')/(sum(var(s'))));
    cli = cli+1;
    cl = eLag*cli-(eLag-1);
end
%% Train data 2 epoching
cli = 1;                    % current lag index
cl = eLag*cli-(eLag-1);     % current lag sample
while cl+eLen-1<=size(trainData2,2)
    epoch = trainData2(:,cl:cl+eLen-1);  %Extracting epoch for testing
    s = W' * epoch;
    y2(cli,:) = log10(var(s')/(sum(var(s'))));
    cli = cli+1;
    cl = eLag*cli-(eLag-1);
end


%% Test data 1 epoching
cli = 1;     % current lag index
cl = eLag*cli-(eLag-1);     % current lag sample
while cl+eLen-1<=size(testData1,2)
    epoch = testData1(:,cl:cl+eLen-1);  %Extracting epoch for testing
    s = W' * epoch;
    y3(cli,:) = log10(var(s')/(sum(var(s'))));
    cli = cli+1;
    cl = eLag*cli-(eLag-1);
end
%% Test data 2 epoching
cli = 1;     % current lag index
cl = eLag*cli-(eLag-1);     % current lag sample
while cl+eLen-1<=size(testData2,2)
    epoch = testData2(:,cl:cl+eLen-1);  %Extracting epoch for testing
    s = W' * epoch;
    y4(cli,:) = log10(var(s')/(sum(var(s'))));
    cli = cli+1;
    cl = eLag*cli-(eLag-1);
end

%% Training svm
len1 = size(y1,1);
len2 = size(y2,1);
class = [zeros(len1,1);ones(len2,1)];
SVM = fitcsvm([y1;y2],class);

%% Check prediction model
TP = sum(predict(SVM,y3)==0);
FP = sum(predict(SVM,y3)==1);
TN = sum(predict(SVM,y4)==1);
FN = sum(predict(SVM,y4)==0);
end

%% Testing result