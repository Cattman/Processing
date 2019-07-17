import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Evolution extends PApplet {

/* 
  Written by - Alex Watson

  Neural Net example of Natural Selection
  Using circles as animals
  Run with ctrl+shift+B
*/

int yellow = 0xffF6FF05;
int red = 0xffFF0505;
int gray = 0xffD3D3D3;
int black = 0xff000000;
int white = 0xffFFFFFF;

Animal[] animals;
Food[] foods;
float[][] takenCoords;
int population = 100;
int numFood = population/2;
int generations = 1; 

//map size would matter

public void setup()
{
  
  background(white);
  //populate animals
  int i;  
  int j;
  float currentX;
  float currentY;
  float x = 0.0f; // initialize because it yells 
  float y = 0.0f; // 0 should get overridden
  boolean coordsAreFree = false;
  animals = new Animal[population];
  foods = new Food[numFood];
  takenCoords = new float[population + numFood][2];
  
  for(i = 0; i < population; i = i+1)
  {
    println("for i");
    // Still need to randomize the init
    int r = PApplet.parseInt(random(10, 30));
    int s = PApplet.parseInt(random(10, 30));
    Animal a = new Animal(r,s);    
    
    //check if coords are occupado there should be i num coords now
    while(!coordsAreFree)
    {
      x = random(0, width);//random //<>//
      y = random(0, height);
      j = 0;
      if(i > 0)
      {
        for(j = 0; j < i; j = j+1)
        {          
          currentX = takenCoords[j][0];
          currentY = takenCoords[j][1];
          if((currentX != x || currentX == 0.0f) && (currentX > (x+r) || currentX < (x-r)))
          {
            if((currentY != y || currentY == 0.0f) && (currentY > (y+r) || currentY < (y-r)))
            { //<>//
              println("Coord free");
              coordsAreFree = true;
            }
            break;
          }
          break;
        }
      }
      else
      {
        coordsAreFree = true;
      }
    }
    //coords should be free    
    a.x = x;
    a.y = y;
    takenCoords[i][0] = a.x;
    takenCoords[i][1] = a.y;    
    
    animals[i] = a;
    println("add animal");
    coordsAreFree = false;
  }
  
  //print food
  for(i = 0; i < numFood; i = i+1)
  {    
    //check if coords are occupado there should be i num coords now
    while(!coordsAreFree)
    {
      x = random(0, width);//random
      y = random(0, height);
      if(i>1)
      {
        for(j = 0; j < i; j = j+1){
          
          if(takenCoords[j][0] != x || takenCoords[j][0] == 0.0f)
          {
            if(takenCoords[j][1] != y || takenCoords[j][1] == 0.0f)
            {
              println("Coord free");
              coordsAreFree = true;
            }
          }        
        }
      }
      else
      {
        coordsAreFree = true;
      }
    }
    //coords should be free    
    Food f = new Food(x,y);
    takenCoords[i][0] = x;
    takenCoords[i][1] = y;    
    
    foods[i] = f;
    println("add food");
    coordsAreFree = false;
  }
  
  DrawObjects();  
}

public void draw()
{
  
}

public void EndDay()
{
  int i;
  for(i = 0; i < population; i = i + 1)
  {
    animals[i].hunger = animals[i].hunger - 10;
    if (animals[i].hunger <= 0)
    {
      //kill
    }
  }
}

public void DrawObjects()
{
  int i;
  println("drawing");
  fill(red);
  for(i = 0; i < animals.length; i = i+1)
  {
    animals[i].Draw();
  }
  fill(yellow);
  for(i = 0; i < foods.length; i = i+1)
  {
    foods[i].Draw();
  }
}
class Animal
{
  float radius;
  float area; 
  float speed; //moving by blocks or pixels?
  int hunger = 100; //range from what to what?
  float x;
  float y;
  int rank;
  
  Animal(int r, int s)
  {
    this.radius = r;
    this.area = PI * radius * radius;
    this.speed = s;
  }
  
  public void Eat(Animal animal)
  {
    //bigger size should equal more food
    this.hunger = this.hunger + PApplet.parseInt(animal.area);
  }
  
  public void Eat(Food food)
  {
    this.hunger = this.hunger + food.nutrition; 
  }
  
  public void Draw()  
  {    
    ellipse(this.x, this.y, this.radius, this.radius);
  }
  
  public void Move(float x, float y)
  {
    // maybe make x/y random 0 < value <= 1 depending on 
    // what direction food/other animals are
    // speed should be some num 0 < speed <= 2
    this.x = this.x + (x * this.speed);
    this.y = this.y + (y * this.speed);
  }
}
class Food
{
 float x; 
 float y;
 int nutrition = 5;
 
 Food(float x, float y)
 {
   this.x = x;
   this.y = y;
 }
 
 public void Draw()
 {
   ellipse(this.x, this.y, 5, 5);
 }
  
}
  public void settings() {  size(1800, 1200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Evolution" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
