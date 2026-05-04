
% ==========================================
% PRÁCTICA 4 - CONTROL MODERNO
% ==========================================
pkg load control
pkg load signal
clear all; clc; close all;

% A partir de aquí va el resto de tu código...

R=100;
L=0.1;
Cap =1e-6;
A= [0 1/Cap; -1/L -R/L];
B= [0;1/L];
C=[1 0];
D=0;
D3=[0; 0];
C2=[0 1];
C3=[1 0;0 1];

[num,den] = ss2tf(A,B,C,D);
tf1=tf(num,den);



[num2,den2] = ss2tf(A,B,C2,D);
tf2=tf(num2,den2);
subplot(2,1,1);


step(tf1);
ylabel("Vc");
subplot(2,1,2);
step(tf2);
ylabel("I(t)");

%%
figure
sys = ss(A,B,C,D);
subplot(2,1,1);
step(sys);
ylabel("Vc");
subplot(2,1,2);
impulse(sys);
ylabel("I(t)");


%%
[num, den]= ss2tf(A,B,C,D);
tf1= tf(num, den);
[num2, den2]= ss2tf(A,B,C2,D);
tf2= tf(num2, den2);

figure
subplot(2,1,1);
step(tf1);
ylabel("Vc");
subplot(2,1,2);
step(tf2);
ylabel("I(t)");


%%
[num, den]= ss2tf(A,B,C,D);
tf1= tf(num, den);
[num2, den2]= ss2tf(A,B,C2,D);
tf2= tf(num2, den2);

figure
subplot(2,1,1);
step(tf1);
ylabel("Vc");
subplot(2,1,2);
step(tf2);
ylabel("I(t)");

%%
ts = 0.015;
u = 1;
x0 = [0; 0];
[t, X] = ode45(@(t, x) modelRLC(t, x, A, B, u), [0 ts], x0);

Vc = X(:, 1);
I = X(:, 2);

figure;

C = [1 0;0 1];
D = 0;
Y = (C * X')';


subplot(2,1,1);
plot(t, Y(:,1), 'LineWidth', 2);
grid on;
title('Respuesta del sistema usando ode45');
ylabel('Vc [V]');
xlim([0 0.015]);



subplot(2,1,2);
plot(t, Y(:,2), 'LineWidth', 2);
grid on;
xlabel('Time [s]');
ylabel('I(t) [A]');
xlim([0 0.015]);



function dx = modelRLC(t, x, A, B, u)
    dx = A * x + B * u;             % Ecuación de Estado
end
