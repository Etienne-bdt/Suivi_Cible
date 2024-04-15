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

x_est = zeros(4,T);
x_est(:,1) = x_kalm; 
err_quadra= zeros(1,T);
err_moy = zeros(1,T);
P_kalm_k = P_kalm;


for k=2:T
    [x_kalm_k, P_kalm_k] = filtre_de_kalman(F,Q,H,R,vecteur_y(:,k),x_est(:,k-1),P_kalm_k);
    x_est(:,k) = x_kalm_k;
    err_quadra(k) = (vecteur_x(:,k)-x_kalm_k)'*(vecteur_x(:,k)-x_kalm_k);
    err_moy(k) = 1/T * sum(sqrt(err_quadra));
end

figure;
hold on;
plot(1:T,vecteur_x(1,:),'b');
plot(1:T,x_est(1,:),'k');
plot(1:T,vecteur_y(1,:),'.r');
legend('Trajectoire en x','Estimations en x','Observations en x');
hold off;

figure;
hold on;
plot(1:T,vecteur_x(3,:),'b');
plot(1:T,x_est(3,:),'k');
plot(1:T,vecteur_y(2,:),'.r');
legend('Trajectoire en y','Estimations en y','Observations en y');
hold off;

figure;
hold on;
plot(vecteur_x(1,:),vecteur_x(3,:),'b');
plot(x_est(1,:),x_est(3,:),'k');
plot(vecteur_y(1,:),vecteur_y(2,:),'.r');
legend('Trajectoire','Estimations','Observations');
hold off;

