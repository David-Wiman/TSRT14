function [x, P] = tu_qw(x, P, omega, T, Rw)
    % According to DARE-based EKF1 on p. 197

    Qk = T^2/4*Sq(x)*Rw*Sq(x)';
            
    if nargin == 5
        F = (eye(length(x)) + 0.5*Somega(omega)*T);
        x = F*x;
        
        f_prim = F;
        P = Qk + f_prim*P*f_prim';
    elseif nargin < 5 % If there is no angle rate measurement
        P = Qk + P;
    end
    
    [x, P] = mu_normalizeQ(x, P);
end