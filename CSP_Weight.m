%% A&Y
% 17/01/19
% CSP filter

function W = CSP_Weight(E1,E2)
    % find Sigma 1 and Sigma 2
    S1 = (E1*E1')/(trace(E1*E1'));
    S2 = (E2*E2')/(trace(E2*E2'));
    SigSum = S1 + S2;

    % Eigenvalue decomposition

    [U,D,~] = svd(SigSum);
    P = sqrt(inv(D)) * U';
    
%     % Create V, with random matrix
%     
%     v = randn(size(E1,1));
%     V = orth(v);
%     
%     % Apply V to achieve W
%     
%     W = P'*V;
    
    W = P';         

end