class Ball{
  float _x;
  float _y;
  int _radius;
  int _area = _radius * _radius;
  color _color;
  
  Ball(int x, int y, int radius, color c){
    _x = x;
    _y = y;
    _radius = radius;
    _color = c;
  } 
}
