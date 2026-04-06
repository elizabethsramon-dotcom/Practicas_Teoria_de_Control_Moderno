%% Datos
datos = readtable("data_motor.csv");
t = datos.time_t_;
u = datos.ex_signal_u_;
y = datos.system_response_y_;

%% Parametros 
Y_100 = 1.0; 
Y_0 = 0.0; 
U_max = max(u); 
U_0 = 0.0;      

K = (Y_100 - Y_0) / (U_max - U_0); 


% Puntos extraídos la grafica
t_step = 0.2;
t_0   = 0.36;   
t_100 = 1.26;  
t_63  = 1.01; 
t_28  = 0.6;  
%TANGENTE
y1_tan = 0;
t1_tan = 0.36;
y2_tan = 0.4;
t2_tan = 0.75;
m = (y2_tan - y1_tan) / (t2_tan - t1_tan); 
b = y1_tan - m * t1_tan;                        
y_tangente = m * t + b;  

%%ZIEGLER & NICHOLS
theta_zn = t_0 - t_step; 
tau_zn = t_100 - t_0; 
G_zn = tf(K, [tau_zn 1], 'InputDelay', theta_zn);
y_zn = lsim(G_zn, u, t);

%% MILLER
theta_m = t_0 - t_step;
tau_m = t_63 - t_0; 

G_m = tf(K, [tau_m 1], 'InputDelay', theta_m);
y_m = lsim(G_m, u, t);

%% ANALITICO
tau_an = 1.5 * (t_63 - t_28);
theta_an = t_0 - t_step; 

G_an = tf(K, [tau_an 1], 'InputDelay', theta_an);
y_an = lsim(G_an, u, t);

%% FIT 
y_media = mean(y);
FIT_zn = 100 * (1 - norm(y - y_zn) / norm(y - y_media));
FIT_m  = 100 * (1 - norm(y - y_m) / norm(y - y_media));
FIT_an = 100 * (1 - norm(y - y_an) / norm(y - y_media));

fprintf('\n=== RESULTADOS DE FIT (%%) ===\n');
fprintf('Ziegler & Nichols : %.2f %%\n', FIT_zn);
fprintf('Miller            : %.2f %%\n', FIT_m);
fprintf('Analitico         : %.2f %%\n', FIT_an);
fprintf('---------------------------------\n');

%% GRAFICA
figure(1)
plot(t, y, 'b', 'LineWidth', 1.5, 'DisplayName', 'Proceso (y)'); hold on;
plot(t, u, 'g', 'LineWidth', 1.5, 'DisplayName', 'Escalon (u)'); 
plot(t, y_zn, 'Color', [0.8 0.4 0], 'LineWidth', 1.5, 'DisplayName', 'Ziegler & Nichols');
plot(t, y_m, 'Color', [0.9 0.8 0], 'LineWidth', 1.5, 'DisplayName', 'Miller');
plot(t, y_an, 'm', 'LineWidth', 1.5, 'DisplayName', 'Analitico');
plot(t, y_tangente, 'r:', 'LineWidth', 2, 'DisplayName', 'Tangente'); 
yline(0, 'r--', 'DisplayName', 'Linea base'); 
yline(Y_100, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Linea 100%'); 

grid on;
ylim([-0.1 max(U_max, Y_100) + 0.2]); 
title('Identificacion Grafica de Sistemas');
xlabel('Tiempo (s)'); ylabel('Amplitud');
legend('Location', 'southeast');
hold off;
