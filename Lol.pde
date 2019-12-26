class Brain {  
  
  int iNodes, hNodes, oNodes;  
  int hLayers;  
  Food food;  
  Matrix[] weights;  
  
  Brain(int i, int h, int o, int z){  
   iNodes = i;  
   hNodes = h;  
   oNodes = o;  
   hLayers = z;  
     
   weights = new Matrix[hLayers + 1];  
   weights[0] = new Matrix(hNodes, iNodes + 1);  
   weights[1] = new Matrix(hNodes, hNodes + 1);  
   weights[2] = new Matrix(oNodes, hNodes + 1);  
     
   for (Matrix weight : weights)  
     weight.randomize();  
   }  
     
   void mutate(float mutationRate){  
     for(Matrix weight : weights)  
       weight.mutate(mutationRate);  
   }  
     
   float[] output(float[] input){  
     Matrix inputs = weights[0].toSingleColMatrix(input);  
     Matrix outputs;  
     Matrix temp1, temp2;  
       
     for(Matrix weight : weights){  
       temp1 = inputs.bias();   
       temp2 = weight.dotProduct(temp1);  
       inputs = temp2.activate();  
     }  
     outputs = inputs;  
     return outputs.toArray();    
   }  
     
     Brain reproduce(Brain partner){  
     int i;  
     Brain child = new Brain(iNodes, hNodes, oNodes, hLayers);  
       
     for(i=0; i<weights.length; i++){  
       child.weights[i] = weights[i].reproduce(partner.weights[i]);  
     }  
     return child;  
   }  
     
    Brain clone() {  
     int i;  
     Brain clone = new Brain(iNodes,hNodes,oNodes,hLayers);  
     for(i=0; i<weights.length; i++) {  
        clone.weights[i] = weights[i].clone();   
     }  
     return clone;  
    }
}
