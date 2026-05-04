import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import signal

# 1. Definición de Parámetros del Circuito LTI
R = 100.0
L = 0.1
Cap = 1e-6

A = [[0, 1/Cap], 
     [-1/L, -R/L]]
B = [[0], 
     [1/L]]
C = [[1, 0]]
D = [[0]]

# Creación del objeto de estado con SciPy
sys_rlc = signal.StateSpace(A, B, C, D)

# 2. Generación del Archivo CSV (Señal Arbitraria Ficticia)
t_generado = np.linspace(0, 0.06, 600)
# Vamos a hacer una señal que empiece en 0V, salte a 8V y luego baje a 3V
u_generada = np.piecewise(t_generado, 
                          [t_generado < 0.015, (t_generado >= 0.015) & (t_generado < 0.04), t_generado >= 0.04], 
                          [0, 8, 3])

df = pd.DataFrame({'tiempo': t_generado, 'voltaje': u_generada})
df.to_csv('senal_arbitraria.csv', index=False)
print("Archivo 'senal_arbitraria.csv' creado exitosamente.")

# 3. Lectura de CSV y Simulación LTI (El reto en sí)
datos_leidos = pd.read_csv('senal_arbitraria.csv')
t_in = datos_leidos['tiempo'].values
u_in = datos_leidos['voltaje'].values

# Función lsim de scipy.signal simula la respuesta de sistemas de tiempo continuo
tout, yout, xout = signal.lsim(sys_rlc, U=u_in, T=t_in)

# 4. Graficar los resultados
plt.figure(figsize=(8, 5))
plt.plot(t_in, u_in, 'r--', label='Voltaje de Entrada (CSV)')
plt.plot(tout, yout, 'b-', linewidth=2, label='Voltaje del Capacitor (Simulado)')
plt.title('Simulación en Python usando scipy.signal y archivo CSV')
plt.xlabel('Tiempo [s]')
plt.ylabel('Voltaje [V]')
plt.legend()
plt.grid(True)
plt.show()