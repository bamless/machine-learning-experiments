class Perceptron {
  float weights[] = new float[2];
  float bias;
  
  Perceptron() {
    for(int i = 0; i < weights.length; i++) {
      weights[i] = random(-1, 1);
    }
    bias = random(-1, 1);
  }
  
  // Activation function
  int sign(float x) {
    return x >= 0 ? 1 : -1;
  }
  
  // Executes the model and returns a classification of the input
  int guess(float[] input) {
    float sum = bias;
    for(int i = 0; i < weights.length; i++) {
      sum += input[i] * weights[i];
    }
    return sign(sum);
  }
  
  // Trains the perceptron
  void train(float learningRate, float[] input, int label) {
    int guess = guess(input);
    int error = label - guess;
    
    // Gradient descent
    for(int i = 0; i < weights.length; i++) {
      weights[i] += learningRate * error * input[i];    
    }
    
    bias += learningRate * error;
  }
  
  // Draws the learned separation line of the data
  void show() {
    stroke(0);
    Point p1 = new Point(-1, -bias / weights[1] -(weights[0] / weights[1]) * -1);
    Point p2 = new Point(1, -bias / weights[1] -(weights[0] / weights[1]) * 1);
    // TODO: remove the printing
    println("y = " + -(weights[0] / weights[1]) + "x + " + -bias / weights[1]);
    line(p1.pixelX(), p1.pixelY(), p2.pixelX(), p2.pixelY());
  }
}
