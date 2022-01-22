# Python script to replicate figure 3D from Huang
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from matplotlib.colors import Normalize

# Define differential equation system
def f(X, a1, a2, b1, b2, thetaA1, thetaA2, thetaB1, thetaB2, k1, k2, n):
    x1, x2 = X
    dx1 = a1 * (x1**n)/(thetaA1**n + x1**n) + \
        b1 * (thetaB1**n)/(thetaB1**n + x2**n) - k1 * x1
    
    dx2 = a2 * (x2**n)/(thetaA2**n + x2**n) + \
        b2 * (thetaB2**n)/(thetaB2**n + x1**n) - k2 * x2
    return [dx1, dx2]

# Define grid 
x1 = np.linspace(0, 2, 20)
x2 = np.linspace(0, 2, 20)
X1, X2 = np.meshgrid(x1, x2)

# Parameter values for differential equation system
a1 = 1
a2 = 1
b1 = 1
b2 = 1
thetaA1 = 0.5
thetaA2 = 0.5
thetaB1 = 0.5
thetaB2 = 0.5
k1 = 1
k2 = 1
n = 4

# Fill in plot values
u, v = np.zeros(X1.shape), np.zeros(X2.shape)
NI, NJ = X1.shape
for i in range(NI):
    for j in range(NJ):
        x = X1[i, j]
        y = X2[i, j]
        yP = f([x, y], a1, a2, b1, b2,  
                thetaA1, thetaA2, thetaB1, thetaB2,   
                k1, k2, n)
        u[i, j] = yP[0]
        v[i, j] = yP[1]

# Create figure and export
color = np.hypot(u, v)

Q = plt.quiver(X1, X2, u, v, color, units = 'x', pivot = 'tip')
plt.title('Replica of figure 3D [Huang]')
plt.xlabel('$x_1$ = GATA1')
plt.ylabel('$x_2$ = PU.1')
plt.savefig('img/phasePlot.png', dpi = 300)
