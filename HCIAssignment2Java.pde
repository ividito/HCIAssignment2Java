// I have no clue how encapsulation works for Processing, so don't encapsulate these and make everything in other classes public

ArrayList<Shape> actionStack = new ArrayList<Shape>();
Shape drawMode;
String colour = "black";
int strokeWeight = 8;
int startX, startY, endX, endY, pointer;

void setup(){
  size(640, 640);
  drawMode = new Circle(1, 1, 1, 1, 1);
  ellipseMode(CORNERS);
  rectMode(CORNERS);
  fill(0,0,0);
}

void draw(){
  pointer = actionStack.size();
  background(150);
  fill(0,0,0);
  textSize(32);
  text("Drawing: "+ drawMode.toString() + " in " + colour, 10, 30);
  for (int i = 0; i<pointer; i++){
    actionStack.get(i).draw();
  }
}

void mousePressed(){
  Shape nextShape = drawMode.getShape();
  startX = mouseX;
  startY = mouseY;
  nextShape.update(startX, startY, startX, startY);
  nextShape.setColour(colour);
  nextShape.setStrokeWeight(strokeWeight);
  actionStack.add(nextShape);
  println(actionStack);
}

void mouseDragged(){
  endX = mouseX;
  endY = mouseY;
  actionStack.get(pointer-1).update(startX, startY, endX, endY);
  redraw();
}

void mouseReleased(){
  endX = mouseX;
  endY = mouseY;
  actionStack.get(pointer-1).update(startX, startY, endX, endY);
  redraw();
}

void keyPressed(){
  println("keypress");
  if (key == BACKSPACE){
    actionStack.remove(pointer-1); // could maybe have error handling
  }
  if (key == 'e'){ // e for ellipse
      drawMode = new Circle(1, 1, 1, 1, 1);
  }
  if (key == 'r'){ // s for square/rectangle
      drawMode = new Rectangle(1, 1, 1, 1, 1);
  }
  if (key == 'l'){ // l for line
    drawMode = new Line(1,1,1,1,1);
  }
  if (key == 'c'){ // c for colour
    cycleColour();
  }
  if (key == 's'){ // s for stroke
    cycleStroke();
  }
}

void cycleColour(){
  switch(colour){
      case("black"):
        colour = "red";
        break;
      case("red"):{
        colour = "green";
        break;
      }
      case("green"):{
        colour = "blue";
        break;
      }
      case("blue"):{
        colour = "black";
        break;
      }
    }
}
void cycleStroke(){
  switch(strokeWeight){
    case(8):
      strokeWeight = 15;
      break;
    case(15):
      strokeWeight = 2;
      break;
    case(2):
      strokeWeight = 8;
      break;
  }
}

// Draw Action Definitions Below

public abstract class Shape{
  public int st;
  public String colour;
  public void draw(){
    switch(this.colour){
      case("black"):
        fill(0,0,0);
        stroke(0,0,0);
        break;
      case("red"):
        fill(255,0,0);
        stroke(255,0,0);
        break;
      case("green"):
        fill(0,255,0);
        stroke(0,255,0);
        break;
      case("blue"):
        fill(0,0,255);
        stroke(0,0,255);
        break;
    } 
  }
  public abstract void update(int x1, int y1, int x2, int y2);
  public abstract Shape getShape();
  public String toString(){
    return "None";
  }  
  public void setColour(String c){this.colour = c;}
  public String getColour(){return colour;}
  public void setStrokeWeight(int s){this.st = s;}
}


public class Rectangle extends Shape{
   public int x1, y1, x2, y2;
   public Rectangle(int x1, int y1, int x2, int y2, int stwgt){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      this.st = stwgt;
   }
   public void draw(){
    super.draw();
    strokeWeight(st);
    rect(x1,y1,x2,y2);
  }
  
  public void update(int x1, int y1, int x2, int y2){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
  }
    
  public Rectangle getShape(){return new Rectangle(x1, y1, x2, y2, st);}
  
  public String toString(){
    return "Rectangle";
  }
}

public class Circle extends Shape{
  public int x1, y1, x2, y2;
  public Circle(int x1, int y1, int x2, int y2, int stwgt){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      this.st = stwgt;
  }
  
  public void draw(){
    super.draw();
    strokeWeight(st);
    ellipse(x1,y1,x2,y2);
  }
  
  public void update(int x1, int y1, int x2, int y2){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
  }
    
  public Circle getShape(){return new Circle(x1, y1, x2, y2, st);}
  
  public String toString(){
    return "Circle";
  }
}

public class Line extends Shape{
  public int x1, y1, x2, y2;
  public Line(int x1, int y1, int x2, int y2, int stwgt){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      this.st = stwgt;
  }
  
  public void draw(){ // TODO should have special color handling for stroke color (line only)
    super.draw();
    strokeWeight(st);
    line(x1,y1,x2,y2);
  }
  
  public void update(int x1, int y1, int x2, int y2){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
  }
    
  public Line getShape(){return new Line(x1, y1, x2, y2, st);}
  
  public String toString(){
    return "Line";
  }
}
