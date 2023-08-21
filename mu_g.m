function [x, P] = mu_g(x, P, yacc, Ra, g0)
    % According to DARE-based EKF1 on p. 197

    [a, b, c, d] = dQqdq(x);
    h_prim = [a'*g0, b'*g0, c'*g0, d'*g0];
    
    S_k = Ra + h_prim*P*h_prim';
    K_k = P*h_prim'*inv(S_k);
    epsilon_k = yacc - Qq(x)'*g0;
    
    x = x + K_k*epsilon_k;
    P = P - P*h_prim'*inv(S_k)*h_prim*P;
    
    [x, P] = mu_normalizeQ(x, P);
end