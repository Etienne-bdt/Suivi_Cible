%clear all;
close all;

Te=1;
T=100;
sigma_Q=1;
sigma_px=30;
sigma_py=30;


F = [1 Te 0 0; 0 1 0 0; 0 0 1 Te; 0 0 0 1];
H = [1 0 0 0; 0 0 1 0];
Q = sigma_Q^2*[Te^3/3 Te^2/2 0 0; Te^2/2 Te 0 0; 0 0 Te^3/3 Te^2/2; 0 0 Te^2/2 Te];
R = [sigma_px^2 0; 0 sigma_py^2];

x_init = [3; 40; -4; 20];
x_kalm = x_init;
P_kalm = eye(4);

vecteur_x= creer_trajectoire(F,Q,x_init,T);

vecteur_y = creer_observations(H,R,vecteur_x,T);

hold on;
plot(vecteur_x(1,:),vecteur_x(3,:),'b');
plot(vecteur_y(1,:),vecteur_y(2,:),'r');
legend('Trajectoire','Observations');
hold off;

