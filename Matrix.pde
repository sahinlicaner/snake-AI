class Matrix {  
    
  int rows, cols;  
  float[][] matrix;  
     
  Matrix(int row, int col) {  
    rows = row;  
    cols = col;  
    matrix = new float[rows][cols];  
  }  
    
  Matrix(float[][] mat) {  
    matrix = mat;  
    rows = matrix.length;  
    cols = matrix[0].length;  
  }  
    
  void output() {  
    int i, j;  
      
    for (i=0; i<rows; i++) {  
      for (j=0; j<cols; j++) {  
        print(matrix[i][j] + " ");  
      }  
      println();  
    }   
    println();  
  }  
    
  void scalarProduct(float n) {  
    int i, j;  
    for (i=0; i<rows; i++) {  
      for (j=0; j<cols; j++) {  
        matrix[i][j] *= n;  
      }  
    }  
  }  
    
  Matrix dotProduct(Matrix mat) {  
    int i, j, k;  
    Matrix product = new Matrix(cols, mat.rows);   
    float result;  
      
    if (cols == mat.rows) {  
      for (i=0; i<rows; i++) {  
        for (j=0; j<mat.cols; j++) {  
          result = 0;  
          for (k=0; k<cols; k++) {  
            result += matrix[i][k] * mat.matrix[k][j];   
          }  
          product.matrix[i][j] = result;  
        }  
      }  
    }  
    return product;  
  }  
    
  void randomize() {  
    int i, j;  
      
    for (i=0; i<rows; i++) {  
      for (j=0; j<cols; j++) {  
        matrix[i][j] = random(-1, 1);  
      }  
    }  
  }  
    
  Matrix toSingleColMatrix(float[] arr) {  
    int i;  
    Matrix mat = new Matrix(arr.length, 1);  
      
    for (i=0; i<arr.length; i++) {  
      mat.matrix[i][0] = arr[i];    
    }  
    return mat;  
  }  
    
  float[] toArray() {  
    int i, j;  
    float[] arr = new float[rows*cols];  
      
    for(i=0; i<rows; i++) {  
      for(j=0; j<cols; j++) {  
        arr[i*cols + j] = matrix[i][j];  
      }   
    }  
    return arr;  
  }  
    
  void toMatrix(float[] arr) {  
    int i, j;  
      
    for(i=0; i<rows; i++) {  
      for(j=0; j<cols; j++) {  
        matrix[i][j] = arr[i*cols + rows];  
      }   
    }  
  }  
    
  Matrix bias() {  
    int i;  
    Matrix mat = new Matrix(rows+1, 1);  
      
    for(i=0; i<rows; i++){  
      mat.matrix[i][0] = matrix[i][0];  
    }  
    mat.matrix[rows][0] = 1;  
    return mat;  
  }  
    
  float sigmoid(float x) {  
  float y = 1 / (1 + pow((float)Math.E, -x));  
  return y;  
  }  
    
  Matrix sigmoidDerivative() {  
    int i, j;  
    Matrix mat = new Matrix(rows, cols);  
      
    for(i=0; i<rows; i++) {  
      for(j=0; j<cols; j++) {  
        mat.matrix[i][j] = matrix[i][j] * (1 - matrix[i][j]);  
      }  
    }  
    return mat;  
  }  
    
  Matrix activate(){  
    int i, j;  
    Matrix mat = new Matrix(rows, cols);  
      
    for(i=0; i<rows; i++) {  
      for(j=0; j<cols; j++) {  
        mat.matrix[i][j] = sigmoid(matrix[i][j]);  
      }  
    }  
    return mat;  
  }  
    
   void mutate(float mutationRate) {  
    int i, j;  
       
    for (i =0; i<rows; i++) {  
      for (j = 0; j<cols; j++) {  
        float num = random(1);  
        if (num<mutationRate) {  
          matrix[i][j] += randomGaussian() / 10;  
            
          if (matrix[i][j]>1) {  
            matrix[i][j] = 1;  
          }  
          else if (matrix[i][j] <-1) {  
            matrix[i][j] = -1;  
          }  
        }  
      }  
    }  
  }  
    
  Matrix reproduce(Matrix partner){  
    int randRows = int(random(rows));  
    int randCols = int(random(cols));  
    int i, j;  
      
    Matrix child = new Matrix(rows, cols);  
      
    for (i=0; i<rows; i++){  
      for(j=0; j<cols; j++){  
        if (i < randRows || (i == randRows && j <= randCols))  
          child.matrix[i][j] = matrix[i][j];  
          else  
            child.matrix[i][j] = partner.matrix[i][j];  
      }    
    }  
    return child;  
  }  
    
    
  Matrix clone() {  
    int i, j;  
    Matrix clone = new  Matrix(rows, cols);  
      
    for (i=0; i<rows; i++) {  
      for (j=0; j<cols; j++) {  
        clone.matrix[i][j] = matrix[i][j];  
      }  
    }  
    return clone;  
  }  
}  
