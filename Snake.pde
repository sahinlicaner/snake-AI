class Snake {  
  int passedTime = 0;  
  int remainingTime = 100;  
  int len = 3;  
  int fitness = 0;  
  int foodIndex = 0;  
    
  PVector pos, vel;  
  ArrayList<PVector> body;  
  ArrayList<Food> foodList;  
  
  boolean alive = true;  
  boolean isTopSnake = false;  
  Food food;  
  Brain brain;  
   
  float[] inputs, outputs;  
    
  Snake(){  
    pos = new PVector(width/2, height/2);  
    vel = new PVector(SIZE, 0);  
      
    body = new ArrayList<PVector>();  
    body.add(new PVector(width/2, height/2 + SIZE));  
    body.add(new PVector(width/2, height/2 + 2*SIZE));  
      
    inputs = new float[iNodes];  
    outputs = new float[oNodes];  
    brain = new Brain(iNodes, hNodes, oNodes, hLayers);  
      
    food = new Food();  
    foodList = new ArrayList<Food>();  
    foodList.add(food.clone());  
      
  }  
    
  Snake(ArrayList<Food> foods){  
    outputs = new float[4];  
    inputs = new float[24];  
    isTopSnake = true;  
    body = new ArrayList<PVector>();    
    foodList = new ArrayList<Food>(foods.size());  
    
    for (Food f : foods){  
      foodList.add(f.clone());  
    }  
    food = foodList.get(foodIndex);  
    foodIndex++;  
      
      
    pos = new PVector(width/2, height/2);  
    body = new ArrayList<PVector>();  
    body.add(new PVector(width/2, height/2 + SIZE));  
    body.add(new PVector(width/2, height/2 + 2*SIZE));  
  }  
    
  void mutate(float mutationRate){  
    brain.mutate(mutationRate);  
  }  
    
  void computeVelocity(){  
    if (alive) {  
    int i, index = 0;  
    float max = 0;  
      
    outputs = brain.output(inputs);  
      
    for(i=0; i<outputs.length; i++){  
      if(outputs[i] > max){  
        max = outputs[i];  
        index = i;  
      }  
    }  
      switch(index){  
        case 0:  
          vel.x =-SIZE;  
          vel.y =0;  
          break;  
        case 1:  
          vel.x =0;  
          vel.y =-SIZE;  
          break;  
        case 2:  
          vel.x =SIZE;  
          vel.y =0;  
          break;  
        case 3:  
          vel.x =0;  
          vel.y =SIZE;  
          break;  
      }  
    }}  
      
    void eat(){  
      remainingTime += 100;  
      body.add(pos);  
      len++;  
        
      if (!isTopSnake){  
        food = new Food();   
        while (body.contains(food.pos)) {  
          food = new Food();  
        }  
      } else {  
        food = foodList.get(foodIndex);  
      }  
    }  
      
    void move(){  
        
      if (alive) {  
        PVector temp;  
        passedTime++;  
        remainingTime--;  
          
        if (remainingTime < 0)  
          alive = false;  
          
        if ((pos.x + vel.x) < 3*SIZE || pos.x + vel.x > width - SIZE || pos.y + vel.y < SIZE || pos.y + vel.y > height - SIZE)  
          alive = false;  
            
        for (int i=0; i<body.size(); i++){  
          if(pos.x + vel.x == body.get(i).x && pos.y + vel.y == body.get(i).y)  
            alive = false;  
        }    
          
        if (pos.x + vel.x == food.pos.x && pos.y + vel.y == food.pos.y){  
          eat();  
          body.add(pos);   
        } else {  
          for(int i = 0; i < body.size() - 1; i++){  
            temp = new PVector(body.get(i + 1).x, body.get(i + 1).y);  
            body.set(i, temp);  
          }  
          temp = new PVector(pos.x, pos.y);  
          body.set(len - 2, pos);  
        }  
        pos.add(vel);  
      }  
    }  
      
    void show(){  
      int i;  
      fill(255);  
        
        
      for (i=0; i<body.size(); i++) {  
        rect(body.get(i).x, body.get(i).y, SIZE, SIZE);  
      }  
      if(!alive) {  
       fill(150);  
     } else {  
       fill(255);  
     }  
      rect(pos.x, pos.y, SIZE, SIZE);  
      food.show();  
    }  
      
    void computeFitness(){  
      if (len < 12)  
        fitness = int(pow(passedTime, 2)) * int(pow(2, len));  
      else  
        fitness = int(pow(passedTime, 2)) * int(pow(2, 12));  
        fitness *= (len - 12);  
    }  
  
    Snake reproduce(Snake secondParent){  
      Snake child = new Snake();  
      child.brain = brain.reproduce(secondParent.brain);  
      return child;  
    }  
      
    Snake clone(){  
      Snake clone = new Snake();  
      clone.brain  = brain.clone();  
      return clone;  
    }  
      
    Snake cloneForTopSnake() {  
     Snake clone = new Snake(foodList);  
     clone.brain = brain.clone();  
     return clone;  
  }  
      
    void look() {  
      float [] temp;  
        
      temp = lookInDirection (new PVector(0, SIZE));  
      inputs[0] = temp[0];  
      inputs[1] = temp[1];  
      inputs[2] = temp[2];  
        
      temp = lookInDirection (new PVector(SIZE, SIZE));  
      inputs[3] = temp[0];  
      inputs[4] = temp[1];  
      inputs[5] = temp[2];  
        
      temp = lookInDirection (new PVector(SIZE, 0));  
      inputs[6] = temp[0];  
      inputs[7] = temp[1];  
      inputs[8] = temp[2];  
        
      temp = lookInDirection (new PVector(SIZE, -SIZE));  
      inputs[9] = temp[0];  
      inputs[10] = temp[1];  
      inputs[11] = temp[2];  
        
      temp = lookInDirection (new PVector(0, -SIZE));  
      inputs[12] = temp[0];  
      inputs[13] = temp[1];  
      inputs[14] = temp[2];  
        
      temp = lookInDirection (new PVector(-SIZE, -SIZE));  
      inputs[15] = temp[0];  
      inputs[16] = temp[1];  
      inputs[17] = temp[2];  
        
      temp = lookInDirection (new PVector(-SIZE, 0));  
      inputs[18] = temp[0];  
      inputs[19] = temp[1];  
      inputs[20] = temp[2];  
        
      temp = lookInDirection (new PVector(-SIZE, SIZE));  
      inputs[21] = temp[0];  
      inputs[22] = temp[1];  
      inputs[23] = temp[2];  
    }  
      
    float [] lookInDirection(PVector direction) {  
      float [] vision = new float[3];  
      PVector point = new PVector(pos.x, pos.y);  
        
      boolean isFoodLocated = false;  
      boolean isBodyLocated = false;  
        
      int distance = 0;  
      point.add(direction);  
      distance++;  
        
      while(!((point.x < SIZE) || (point.x >= width - SIZE) || (point.y < SIZE) || (point.y >= height - SIZE))) {  
        if (!isFoodLocated && (point.x == food.pos.x && point.y == food.pos.y)){  
          vision[0] = 1;  
          isFoodLocated = true;  
        }  
        if (!isBodyLocated && body.contains(point)){  
          vision[1] = 1 / distance;  
          isBodyLocated = true;  
        }  
        
        point.add(direction);  
        distance++;  
      }  
        
      vision[2] = 1 / distance;  
      return vision;  
    }  
}  
