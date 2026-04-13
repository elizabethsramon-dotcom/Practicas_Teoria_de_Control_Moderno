
%% Tarea 1 respuesta al impulso y escalon
num=[3];
den=[1 2 3];
ts=0.1;
Gs=tf(num,den); %tiempo continuo
Gz=tf(num,den,ts); %tiempo discreto
delay=2;
Gs=tf(num,den,'InputDelay',delay);

step(Gs);
figure
impulse(Gs);


%% tarea 2 respuesta senales escalones
n = 900; % muestras (usamos 900 para dividir en 3 partes exactas de 300)
p1 = zeros(1, 300); % de 0 a 10s (magnitud 0)
p2 = 5 * ones(1, 300); % de 10 a 20s (escalon magnitud 5)
p3 = 10 * ones(1, 300); % de 20 a 30s (escalon magnitud 10)

% senales finales
u = [p1, p2, p3];
t = linspace(0, 30, n); 

% grafica
figure;
lsim(Gs, u, t);
grid on;
title('respuesta del sistema a tarea 1');
xlabel('tiempo (s)');
ylabel('amplitud');

%% tarea 3 senal arbitraria 1
n = 1000; % muestras (usamos 1000 para dividir en 4 partes exactas de 250)
p1 = zeros(1, 250); % de 0 a 10s (magnitud 0)
p2 = 5 * ones(1, 250); % de 10 a 20s (escalon magnitud 5)
p3 = linspace(15, 25, 250); % de 20 a 30s (rampa de 15 a 25)
p4 = 25 * ones(1, 250); % de 30 a 40s (escalon magnitud 25)

% senales finales
u = [p1, p2, p3, p4];
t = linspace(0, 40, n); 

% grafica
figure;
lsim(Gs, u, t);
grid on;
title('respuesta del sistema a tarea 2');
xlabel('tiempo (s)');
ylabel('amplitud');



%% tarea 4 senal arbitraria 2

n = 1000; %muestras

p1 = zeros(1, 100); %00
p2 = linspace(0, 5, 100);% rampa1
p3 = 5 * ones(1, 200); %escalon magnitud 5
p4 = 10 * ones(1, 200);% escalon
p5 = linspace(25, 15, 400); % seccion 5 ()rampa

% senales finales
u = [p1, p2, p3, p4, p5];
t = linspace(0, 50, n); 

% grafica
figure;
lsim(Gs, u, t);
grid on;
title('respuesta del sistema al reto');
xlabel('tiempo (s)');
ylabel('amplitud');

%% tarea senales aleatorias (prbs)
n = 100; % muestras
rango = [-1, 1]; % rango de amplitud
banda = [0, 0.5]; % banda de frecuencia

% senales finales
u = idinput(n, 'prbs', banda, rango);
t = linspace(0, 100, n);

% grafica
figure;
lsim(Gs, u, t);
grid on;
title('respuesta del sistema a senal prbs');
xlabel('tiempo (s)');
ylabel('amplitud');