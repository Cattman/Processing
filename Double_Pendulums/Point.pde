public class Point{
  private float r;
  public float x;
  public float y;
  public float ax = 0;
  public float ay = -9.81;
  private int m;
  public float vx = 0;
  public float vy = 0;
  private float theta;
  
  public Point(int radius, int mass){
    r = radius;
    m = mass;
  }
  
  
}
