# Class 3 Answers

## 3.1

### 3.1.a

XOR problem is that when we build a Neural Network(only one layer of perceptron) to produce the truth table related to the XOR.

### 3.1.b

The reason is the classes in XOR are not linearly separable
which means you can not draw a line to separate them.

## 3.2

According to wikipedia, A complex pattern-classification problem, cast in a high-dimensional space nonlinearly, is more likely to be linearly separable than in a low-dimensional space, provided that the space is not densely populated.

Which means, for rth-order polynomial separating surfaces, the number $L_{m}(r)$ of separable truth functions of m variables is bounded above by 

$$
L_{m}(r) < C(2m,
\left(\begin{matrix}
m+r \\
m
\end{matrix}
\right)
)
$$

So the more m variables (which means casting into a higher dimensional space), the easier it becomes to separate the points.

## 3.3

### Suggest features and sketch how the features distribute in the feature space for both classes

Since rect and square have different length/width rate, we can use this as a feature.for rect it will near 1, for square it will far from 1.
We can also use abs(x1-x2) as a feature. the related value will be 0 or not zero.

since there will have noises existed, we will define a small value $\epsilon$ to check the result.

### Suggest a suitable classifier based on this

We can use SVM or decision tree(random forest) to separate the objects to classes.

## 3.4

To predict a temp in the next day, we need do the following steps.

* Data Collection:Gather historical weather data that includes relevant features such as temperature, humidity, wind speed

* Data Preprocessing:Normalize and na processing are needed.

* Feature Selection:Choose the features that are most relevant for predicting the temperature.

* Data Splitting:Split the dataset into training, validation, and test sets.

* Model Architecture:Choose an appropriate neural network architecture. For time series prediction tasks like this, recurrent neural networks (RNNs) or long short-term memory networks (LSTMs) are commonly used due to their ability to capture temporal dependencies.

* Loss Function and Optimization:Define a loss function that measures the difference between the predicted temperature and the actual temperature. Common choices include mean squared error (MSE) for regression problems.

* Choose an optimizer (e.g., Adam or SGD) to minimize the loss function during training.

* Training the Neural Network:Feed the training data into the neural network and adjust the weights based on the error using backpropagation.Iterate through multiple epochs, monitoring the performance on the validation set to avoid overfitting.

* Hyperparameter Tuning:Adjust hyperparameters like learning rate, the number of layers, and the number of neurons in each layer based on the validation set performance.

* Evaluation:Evaluate the trained model on the test set to assess its performance on unseen data.

* Prediction:Use the trained neural network to predict the temperature for the next day based on the input features.
  
* Monitoring and Updating: retraining the model regularly.

## 3.5

### 3.5.a

### 3.5.b

### 3.5.c

## 3.6

### 3.6.a

### 3.6.b

## 3.7

## 3.8

### 3.8.a

### 3.8.b

## 3.9
