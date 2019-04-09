function [TPout,FPout,TNout,FNout] = BCI_validate2(k,E1,E2,eLenVar,eLagVar)
%k = 5;          % k-fold cross validation
% Pre-allocation
TPout = zeros(length(eLenVar),length(eLagVar));
FPout = zeros(length(eLenVar),length(eLagVar));
TNout = zeros(length(eLenVar),length(eLagVar));
FNout = zeros(length(eLenVar),length(eLagVar));

for II = 1:length(eLenVar)     % Samples
    for JJ = 1:length(eLagVar)     % Samples
        for n = 1:k
            N1 = floor(size(E1,2)/k);      % Number of samples in section
            N2 = floor(size(E2,2)/k);      % Number of samples in section
            
            segStart1 = n*N1-(N1-1);
            segSlut1 = N1*n;
            segStart2 = n*N2-(N2-1);
            segSlut2 = N2*n;
            
            test1 = E1(:,segStart1:segSlut1);
            test2 = E2(:,segStart2:segSlut2);
            train1 = [E1(:,1:segStart1-1),E1(:,segSlut1+1:end)];
            train2 = [E2(:,1:segStart2-1),E2(:,segSlut2+1:end)];
            
            [TP(n),FP(n),TN(n),FN(n)] = BCI_validate(train1,train2,test1,test2,eLenVar(II),eLagVar(JJ));
        end

%% Accuracy
%acc(eLen,eLag) = (sum(TP)+sum(TN))/(sum(TP)+sum(TN)+sum(FP)+sum(FN));
TPout(II,JJ) = sum(TP);
TNout(II,JJ) = sum(TN);
FPout(II,JJ) = sum(FP);
FNout(II,JJ) = sum(FN);
% eLag
    end
%     eLen
end