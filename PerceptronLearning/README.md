# Perceptron Learning

This simple experiment generates a set of random point and then trains a pereceptron to classify
them with respect to a fixed line. To modify the classification line, change its equation in
`Point.pde` (the function is `separation`).

While training, the classification line will be displayed on screen, and the correctly classified
points will appear in green. Fully colored points belong to class one (left of classification line),
while half colored ones belong to class two (right of classification line).

To change the speed at which the line will fit the data, you can increase the learning rate passed
to `Perceptron.train`.
