static final Operation SIGMOID = new Operation() {
    float apply(int r, int c, float x) {
      return  1 / (1 + pow((float) Math.E, -x));
    }
};

class NeuralNetwork {
  Operation activationFn;
  int inputNodes, hiddenNodes, outNodes;
  Matrix whi, whh, woh;
  
  NeuralNetwork(Operation activation, int nInputs, int nHidden, int nOut) {
    activationFn = activation;
    inputNodes = nInputs;
    hiddenNodes = nHidden;
    outNodes = nOut;
    
    whi = new Matrix(hiddenNodes, inputNodes + 1);
    whh = new Matrix(hiddenNodes, hiddenNodes + 1);
    woh = new Matrix(outNodes, hiddenNodes + 1);
    
    whi.randomize();
    whh.randomize();
    woh.randomize();
  }
  
  void mutate(float mutationRate) {
    whi.randomize(mutationRate);
    whh.randomize(mutationRate);
    woh.randomize(mutationRate);
  }
  
  NeuralNetwork crossOver(NeuralNetwork nn) {
    NeuralNetwork offspring = new NeuralNetwork(activationFn, inputNodes, hiddenNodes, outNodes);
    offspring.whi = whi.crossOver(nn.whi);
    offspring.whh = whh.crossOver(nn.whh);
    offspring.woh = woh.crossOver(nn.woh);
    return offspring;
  }
  
  Matrix singleColMatrixWithBias(float[] arr) {
    Matrix m = new Matrix(arr.length + 1, 1);
    arrayCopy(arr, m.data, arr.length);
    m.data[arr.length] = 1;
    return m;
  }
  
  float[] feedForward(float[] in) {
    Matrix input = singleColMatrixWithBias(in);
    
    Matrix h1Output = whi.mul(input);
    h1Output.apply(activationFn);
    h1Output = h1Output.addRows(1, 1);
    
    Matrix h2Output = whh.mul(h1Output);
    h2Output.apply(activationFn);
    h2Output = h2Output.addRows(1, 1);
    
    Matrix out = woh.mul(h2Output);
    out.apply(activationFn);
    
    return out.data;
  }
  
  NeuralNetwork clone() {
    NeuralNetwork clone = new NeuralNetwork(activationFn, inputNodes, hiddenNodes, outNodes);
    clone.whi = whi.clone();
    clone.whh = whh.clone();
    clone.woh = woh.clone();
    return clone;
  }

}
