class Matrix {
  final int rows, cols;
  final float[] data;
  
  Matrix(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    data = new float[rows * cols];
  }
  
  float get(int r, int c) {
    return this.data[r * cols + c];
  }
  
  void set(int r, int c, float val) {
    this.data[r * cols + c] = val;
  }
  
  Matrix mul(Matrix m) {
    if(cols != m.rows) {
      throw new IllegalArgumentException("Cannot multiply matrices of size " 
                + rows + ", " + cols + " and " + m.rows + ", " + m.cols);
    }
    
    Matrix res = new Matrix(rows, m.cols);
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < m.cols; j++) {
        for(int k = 0; k < cols; k++) {
          res.data[i * m.cols + j] += this.get(i, k) * m.get(k, j);
        }
      }
    }
    
    return res;
  }
  
  Matrix addRows(int num, float init) {
    Matrix r = new Matrix(rows + num, cols);
    arrayCopy(data, r.data, rows * cols);
    for(int i = rows; i < rows + num; i++) {
      for(int j = 0; j < cols; j++) {
        r.set(i, j, init);
      }
    }
    return r;
  }
  
  Matrix mulAddBias(Matrix m) {
    if(cols != m.rows) {
      throw new IllegalArgumentException("Cannot multiply matrices of size " 
                + rows + ", " + cols + " and " + m.rows + ", " + m.cols);
    }
    if(m.cols != 1) {
      throw new IllegalArgumentException("Right hand side of multiply with bias" +
                "must be a single coloumn matrix");
    }
    
    Matrix res = new Matrix(rows + 1, m.cols);
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < m.cols; j++) {
        for(int k = 0; k < cols; k++) {
          res.data[i * m.cols + j] += this.get(i, k) * m.get(k, j);
        }
      }
    }
    
    res.set(rows, 0, 1);
    return res;
  }
  
  void mul(float scalar) {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        data[i * cols + j] *= scalar;
      }
    }
  }
  
  Matrix add(Matrix m) {
    if(rows != m.rows || cols != m.cols) {
       throw new IllegalArgumentException("Cannot add matrices of size " 
                + rows + ", " + cols + " and " + m.rows + ", " + m.cols);
    }
    
    Matrix res = new Matrix(rows, cols);
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        res.data[i * cols + j] = this.get(i, j) + m.get(i, j);
      }
    }
    
    return res;
  }
  
  void add(float scalar) {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        data[i * cols + j] += scalar;
      }
    }
  }
  
  void randomize() {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        set(i, j, random(-1, 1));
      }
    }
  }
  
  void randomize(float chance) {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        if(random(1) < chance) {
          data[i * cols + j] = max(-1, min(1, data[i * cols + j] + randomGaussian() / 5));
        }
      }
    } 
  }
  
  Matrix crossOver(Matrix m) {
    if(rows != m.rows || cols != m.cols) {
       throw new IllegalArgumentException("Cannot apply crossOver to matrices of size " 
                 + rows + ", " + cols + " and " + m.rows + ", " + m.cols);
    }
    
    Matrix res = new Matrix(rows, cols);
    int randX = floor(random(rows)), randY = floor(random(cols));

    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
         if(i < randX || (i == randX && j <= randY))
           res.data[i * cols + j] = this.get(i, j);
         else
           res.data[i * cols + j] = m.get(i, j);
      }
    }
    
    return res;
  }
  
  void apply(Operation op) {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        data[i * cols + j] = op.apply(i, j, data[i * cols + j]);
      } 
    }
  }
  
  void print() {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        System.out.print(data[i * cols + j]);
        System.out.print(" ");
      }
      println("");
    }
  }
  
  Matrix clone() {
    Matrix clone = new Matrix(rows, cols);
    arrayCopy(data, clone.data);
    return clone;
  }
  
}

interface Operation {
  float apply(int row, int col, float v);
}
