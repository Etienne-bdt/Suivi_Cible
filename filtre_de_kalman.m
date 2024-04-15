function [x_kalm_k, P_kalm_k] = filtre_de_kalman(F,Q,H,R,y_k,x_kalm_prec,P_kalm_prec)
    % Prediction
    x_kalm_k = F*x_kalm_prec;
    P_kalm_k = F*P_kalm_prec*F' + Q;

    % Mise à jour
    K = P_kalm_k*H'/(H*P_kalm_k*H' + R);
    x_kalm_k = x_kalm_k + K*(y_k - H*x_kalm_k);
    P_kalm_k = (eye(4) - K*H)*P_kalm_k;
end