function [x, P] = mu_m(x, P, ymag, Rm, m0)
    % According to DARE-based EKF1 on p. 197    
    
    [a, b, c, d] = dQqdq(x);
    h_prim = [a'*m0, b'*m0, c'*m0, d'*m0];
    
    S_k = Rm + h_prim*P*h_prim';
    K_k = P*h_prim'*inv(S_k);
    epsilon_k = ymag - Qq(x)'*m0;
    
    x = x + K_k*epsilon_k;
    P = P - P*h_prim'*inv(S_k)*h_prim*P;
    
    [x, P] = mu_normalizeQ(x, P);
end