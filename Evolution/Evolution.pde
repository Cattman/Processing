/* 
*  Written by - Alex Watson
*
*  Neural Net example of Natural Selection
*  Using circles as animals
*/

color yellow = #F6FF05;
color red = #FF0505;
color gray = #D3D3D3;
color black = #000000;
color white = #FFFFFF;

Animal[] animals;
Food[] foods;
float[][] takenCoords;
int population = 100;
int numFood = population/2;
int generations = 1; 
//map size would matter

void setup()
{
  size(1800, 1200);
  background(white);
  //populate animals
  int i;  
  int j;
  float currentX;
  float currentY;
  float x = 0.0; // initialize because it yells 
  float y = 0.0; // 0 should get overridden
  boolean coordsAreFree = false;
  animals = new Animal[population];
  foods = new Food[numFood];
  takenCoords = new float[population + numFood][2];
  
  for(i = 0; i < population; i = i+1)
  {
    println("for i");
    // Still need to randomize the init
    int r = int(random(10, 30));
    int s = int(random(10, 30));
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
          if((currentX != x || currentX == 0.0) && (currentX > (x+r) || currentX < (x-r)))
          {
            if((currentY != y || currentY == 0.0) && (currentY > (y+r) || currentY < (y-r)))
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
          
          if(takenCoords[j][0] != x || takenCoords[j][0] == 0.0)
          {
            if(takenCoords[j][1] != y || takenCoords[j][1] == 0.0)
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

void draw()
{
  
}

void EndDay()
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

void DrawObjects()
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
