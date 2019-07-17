class Animal
{
  float radius;
  float area; 
  float speed; //moving by blocks or pixels?
  int hunger = 100; //range from what to what?
  int age = 0; //measured in days
  int vision; //radius at which they can notice food/animals/predators
  float x;
  float y;
  int rank;
  
  Animal(int r, int s)
  {
    this.radius = r;
    this.area = PI * radius * radius;
    this.speed = s;
  }
  
  void Eat(Animal animal)
  {
    //bigger size should equal more food
    this.hunger = this.hunger + int(animal.area);
  }
  
  void Eat(Food food)
  {
    this.hunger = this.hunger + food.nutrition; 
  }
  
  void Draw()  
  {    
    ellipse(this.x, this.y, this.radius, this.radius);
  }
  
  void Move(float x, float y)
  {
    // maybe make x/y random 0 < value <= 1 depending on 
    // what direction food/other animals are
    // speed should be some num 0 < speed <= 2
    this.x = this.x + (x * this.speed);
    this.y = this.y + (y * this.speed);
  }

  void Die()
  {
    this.dispose();
  }
}
