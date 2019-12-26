class Food {  
  
  PVector pos;  
  
  Food () {  
    pos = new PVector();   
    pos.x = int(random(40)) * SIZE;   
    pos.y = int(random(40)) * SIZE;  
  }  
  
  void show() {  
    fill(255,0,0);  
    rect(pos.x, pos.y, SIZE, SIZE);  
  }  
  
  Food clone() {  
    Food clone = new Food();  
    clone.pos = new PVector(pos.x, pos.y);  
    return clone;  
  }  
}  
