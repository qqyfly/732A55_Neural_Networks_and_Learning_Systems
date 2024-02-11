import numpy as np

def calcAccuracy(LPred, LTrue):
    """Calculates prediction accuracy from data labels.

    Args:
        LPred (array): Predicted data labels.
        LTrue (array): Ground truth data labels.

    Returns:
        acc (float): Prediction accuracy.
    """

    # --------------------------------------------
    # === Your code here =========================
    # --------------------------------------------
    cM = calcConfusionMatrix(LPred, LTrue)
    acc = calcAccuracyCM(cM)
    # ============================================
    return acc


def calcConfusionMatrix(LPred, LTrue):
    """Calculates a confusion matrix from data labels.

    Args:
        LPred (array): Predicted data labels.
        LTrue (array): Ground truth data labels.

    Returns:
        cM (array): Confusion matrix, with predicted labels in the rows
            and actual labels in the columns.
    """

    # --------------------------------------------
    # === Your code here =========================
    # --------------------------------------------
    
    # Get unique labels
    unique_labels = np.unique(np.concatenate([LPred, LTrue]))
    unique_labels_count = len(unique_labels)
    
    # Initialize confusion matrix
    cM = np.zeros((unique_labels_count, unique_labels_count))

    # Populate confusion matrix
    for p, r in zip(LPred, LTrue):
        cM[r][p] += 1

    # ============================================

    return cM


def calcAccuracyCM(cM):
    """Calculates prediction accuracy from a confusion matrix.

    Args:
        cM (array): Confusion matrix, with predicted labels in the rows
            and actual labels in the columns.

    Returns:
        acc (float): Prediction accuracy.
    """

    # --------------------------------------------
    # === Your code here =========================
    # --------------------------------------------
    # np.trace will return the sum of diag     
    acc = np.trace(cM) / np.sum(cM)  
    # ============================================
    
    return acc
