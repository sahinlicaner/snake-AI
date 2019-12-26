final int SIZE = 20;  
final int iNodes = 24;  
final int hNodes = 16;  
final int oNodes = 4;  
final int hLayers = 2;  
final int fps = 5000;  
final int populationSize = 1000;  
final float mutationRate = 0.05;  
  
Population pop;  
   
void setup() {  
   frameRate(fps);  
   size(800, 800);  
   pop = new Population(populationSize);  
}  
   
void draw(){  
  background(0);  
  noFill();  
  stroke(255);  
  rectMode(CORNER);  
  rect(SIZE,SIZE,width - 2*(SIZE), height - 2*(SIZE));  
   
  if(pop.isEveryoneDead()) {  
        pop.computeFitness();  
        pop.naturalSelection();  
     } else {  
         pop.update();  
         pop.show();  
     }  
  }  
