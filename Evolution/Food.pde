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
 
 void Draw()
 {
   ellipse(this.x, this.y, 5, 5);
 }
  
}
