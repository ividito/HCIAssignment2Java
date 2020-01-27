// I have no clue how encapsulation works for Processing, so don't encapsulate these and make everything in other classes public

ArrayList<Shape> actionStack = new ArrayList<Shape>();
Shape drawMode;
int startX, startY, endX, endY, pointer;

void setup(){
  size(640, 640);
  drawMode = new Circle(1, 1, 1, 1, 1);
  ellipseMode(CORNERS);
}

void draw(){
  pointer = actionStack.size();
  background(150);
  textSize(32);
  text("Drawing: "+ drawMode.toString(), 10, 30);
  for (int i = 0; i<pointer; i++){
    actionStack.get(i).draw();
  }
}

void mousePressed(){
  Shape nextShape = drawMode.getShape();
  startX = mouseX;
  startY = mouseY;
  nextShape.update(startX, startY, startX, startY);
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
  if (key == BACKSPACE){
    actionStack.remove(pointer-1);
  }
  if (key == 'e'){
      drawMode = new Circle(1, 1, 1, 1, 1);
  }
  // TODO add more keys
}





// Draw Action Definitions Below

public abstract class Shape{
  public abstract void draw();
  public abstract void update(int x1, int y1, int x2, int y2);
  public abstract void addStroke(); // TODO change to setStroke, add setColor
  public abstract Shape getShape();
  public String toString(){
    return "None";
  }  
}

//
public class Circle extends Shape{
  public int x1, y1, x2, y2, st;
  public Circle(int x1, int y1, int x2, int y2, int stwgt){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      this.st = stwgt;
  }
  
  public void draw(){
    strokeWeight(st);
    ellipse(x1,y1,x2,y2);
  }
  
  public void update(int x1, int y1, int x2, int y2){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
  }
  
  public void addStroke(){st++;}
  
  public Circle getShape(){return new Circle(x1, y1, x2, y2, st);}
  
  public String toString(){
    return "Circle";
  }
}
