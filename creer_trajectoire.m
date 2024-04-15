function vecteur_r = creer_trajectoire(F,Q,x_init,T)
    % Initialisation
    vecteur_r = zeros(4,T);
    vecteur_r(:,1) = x_init;
    % Boucle de calcul
    for k=2:T
        vecteur_r(:,k) = F*vecteur_r(:,k-1) + mvnrnd(zeros(4,1),Q)';
    end
end