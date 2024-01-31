import numpy as np

def calcAccuracy(LPred, LTrue):
    """Calculates prediction accuracy from data labels.

    Args:
        LPred (array): Predicted data labels.
        LTrue (array): Ground truth data labels.

    Retruns:
        acc (float): Prediction accuracy.
    """

    # --------------------------------------------
    # === Your code here =========================
    # --------------------------------------------
    correct_predictions = np.sum(LPred == LTrue)
    total_samples = len(LTrue)
    acc = correct_predictions / total_samples
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

    # Initialize confusion matrix
    cM = np.zeros((len(unique_labels), len(unique_labels)), dtype=int)

    # Fill confusion matrix
    for i, true_label in enumerate(unique_labels):
        true_indices = (LTrue == true_label)
        for j, pred_label in enumerate(unique_labels):
            pred_indices = (LPred == pred_label)
            cM[i, j] = np.sum(true_indices & pred_indices)
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
    correct_predictions = np.sum(np.diag(cM))
    total_predictions = np.sum(cM)
    acc = correct_predictions / total_predictions
    # ============================================
    
    return acc
