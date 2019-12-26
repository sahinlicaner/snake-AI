class Population {  
    
  Snake [] snakes;  
  Snake topSnake;  
    
  int gen = 1;  
  float topFitness = 0;  
    
  boolean showTop = true;  
    
  Population(int size) {  
    snakes = new Snake[size];  
    for(int i = 0; i < snakes.length; i++){  
      snakes[i] = new Snake();  
    }  
    topSnake = snakes[0].clone();  
    topSnake.isTopSnake = true;  
  }  
    
  boolean isEveryoneDead(){  
    for(int i = 0; i < snakes.length; i++) {  
      if (snakes[i].alive) {  
        return false;  
      }  
      if(topSnake.alive) {  
         return false;   
      }  
    }  
    return true;  
  }  
    
  void update(){  
    if (topSnake.alive) {  
      topSnake.look();  
      topSnake.computeVelocity();  
      topSnake.move();  
    }      
    for(int i = 0; i < snakes.length; i++) {  
        snakes[i].look();  
        snakes[i].computeVelocity();  
        snakes[i].move();  
    }  
      //setCurrentBest();  
  }  
    
  void show () {  
    if (showTop) {  
      topSnake.show();     
    } else {    
    for(int i = 0; i < snakes.length; i++) {  
      if(snakes[i].alive == true) {  
          snakes[i].show();  
        }  
      }  
    }  
  }  
    
  void computeFitness(){  
    for(int i = 0; i < snakes.length; i++) {  
      snakes[i].computeFitness();    
    }  
  }  
    
  void setTopSnake(){  
    float maxFitness = 0;  
    int index = 0;  
      
    for(int i = 0; i < snakes.length; i++){  
      if(snakes[i].fitness > maxFitness) {  
        maxFitness = snakes[i].fitness;  
        index = i;  
      }  
    }  
    if (maxFitness > topFitness) {  
      topFitness = maxFitness;  
      topSnake = snakes[index].cloneForTopSnake();  
    } else {  
      topSnake = topSnake.cloneForTopSnake();  
    }  
  }  
    
  void naturalSelection(){  
    Snake [] newSnakes = new Snake[snakes.length];  
      
    setTopSnake();  
    newSnakes[0] = topSnake.clone();  
      
    for(int i = 1; i < snakes.length; i++){  
      Snake firstParent = snakeSelection();  
      Snake secondParent = snakeSelection();  
        
      Snake child = firstParent.reproduce(secondParent);  
      child.mutate(mutationRate);  
      newSnakes[i] = child;  
    }  
    snakes = newSnakes.clone();  
    gen++;  
  }  
    
    Snake snakeSelection() {  
    long fitnessSum = 0;  
    for (int i =0; i<snakes.length; i++) {  
      fitnessSum += snakes[i].fitness;  
    }  
      
    long rand = floor(random(fitnessSum));  
    long runningSum = 0;  
  
    for (int i = 0; i< snakes.length; i++) {  
      runningSum += snakes[i].fitness;   
      if (runningSum > rand) {  
        return snakes[i];  
      }  
    }  
    return snakes[0];  
  }  
}  
