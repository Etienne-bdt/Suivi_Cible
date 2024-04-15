function vecteur_y = creer_observations(H,R,vecteur_r,T)
    vecteur_y = H*vecteur_r + mvnrnd(zeros(2,1),R,T)';
end