
import numpy as np
from matplotlib import pyplot as plt


def getpolicy(Q):
    """ Get best policy matrix from the Q-matrix.
    You have to implement this function yourself. It is not necessary to loop
    in order to do this, and looping will be much slower than using matrix
    operations. It's possible to implement this in one line of code.
    """
    # shape = Q.shape
    # P = np.zeros((shape[0], shape[1]))
     
    # for i in range(shape[0]):        
    #     for j in range(shape[1]) :        
    #        P[i][j] = np.argmax(Q[i,j])          
    P = np.argmax(Q, axis=2)
    return P
    


def getvalue(Q):
    """ Get best value matrix from the Q-matrix.
    You have to implement this function yourself. It is not necessary to loop
    in order to do this, and looping will be much slower than using matrix
    operations. It's possible to implement this in one line of code.
    """
    # shape = Q.shape
    # V = np.zeros((shape[0], shape[1]))
     
    # for i in range(shape[0]) :        
    #     for j in range(shape[1]) :        
    #        V[i][j] = np.max(Q[i,j])            

    V = np.max(Q, axis=2)
    return V
