clc; clear; close all;

R = 100;      
L = 0.1;      
Cap = 1e-6;   

% Matriz de estados
A = [0 1/Cap; -1/L -R/L];  
B = [0; 1/L];              
C = [1 0; 0 1]; 
D = [0; 0];                

ts = 0.015;                         % Tiempo de simulación
u = 1;                              % Voltaje de entrada
x0 = [0; 0];                        % Condiciones iniciales

[t, X] = ode45(@(t, x) modelRLC(t, x, A, B, u), [0 ts], x0);

y = C * X' + D * u;
Vc = y(1, :);

% Generamos la figura normal (saldrá con tu tema oscuro/negro)
figure; 
plot(t, Vc, 'LineWidth', 2, 'Color', [0 0.447 0.741]); 
grid on;

% --- Esta línea quita el x10^-3 para que los números salgan normales ---
ax = gca;
ax.XAxis.Exponent = 0; 
% -----------------------------------------------------------------------

title('Figura 4.3: Respuesta al escalón del circuito RLC (ode45)');
xlabel('Time [s]');
ylabel('Voltaje Capacitor [V]');
xlim([0 0.015]);
ylim([0 1.8]);

function dx = modelRLC(t, x, A, B, u)
    dx = A * x + B * u;             % Ecuación de Estado
end