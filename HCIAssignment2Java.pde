import de.voidplus.dollar.*;
import development.*;

// I have no clue how encapsulation works for Processing, so don't encapsulate these and make everything in other classes public

ArrayList<Shape> actionStack = new ArrayList<Shape>();
Shape drawMode;
String colour = "black";
int strokeWeight = 8;
int startX, startY, endX, endY, pointer;
OneDollar one;

void setup(){
  size(640, 640);
  drawMode = new Circle(1, 1, 1, 1, 1);
  ellipseMode(CORNERS);
  rectMode(CORNERS);
  fill(0,0,0);
  one = new OneDollar(this);
  one.disableAutoCheck();
  one.setVerbose(true);
  
  // Gesture Declarations
  
  one.learn("triangle", new int[] {137,139,135,141,133,144,132,146,130,149,128,151,126,155,123,160,120,166,116,171,112,177,107,183,102,188,100,191,95,195,90,199,86,203,82,206,80,209,75,213,73,213,70,216,67,219,64,221,61,223,60,225,62,226,65,225,67,226,74,226,77,227,85,229,91,230,99,231,108,232,116,233,125,233,134,234,145,233,153,232,160,233,170,234,177,235,179,236,186,237,193,238,198,239,200,237,202,239,204,238,206,234,205,230,202,222,197,216,192,207,186,198,179,189,174,183,170,178,164,171,161,168,154,160,148,155,143,150,138,148,136,148} );
  one.learn("circle", new int[] {127,141,124,140,120,139,118,139,116,139,111,140,109,141,104,144,100,147,96,152,93,157,90,163,87,169,85,175,83,181,82,190,82,195,83,200,84,205,88,213,91,216,96,219,103,222,108,224,111,224,120,224,133,223,142,222,152,218,160,214,167,210,173,204,178,198,179,196,182,188,182,177,178,167,170,150,163,138,152,130,143,129,140,131,129,136,126,139} );
  one.learn("rectangle", new int[] {78,149,78,153,78,157,78,160,79,162,79,164,79,167,79,169,79,173,79,178,79,183,80,189,80,193,80,198,80,202,81,208,81,210,81,216,82,222,82,224,82,227,83,229,83,231,85,230,88,232,90,233,92,232,94,233,99,232,102,233,106,233,109,234,117,235,123,236,126,236,135,237,142,238,145,238,152,238,154,239,165,238,174,237,179,236,186,235,191,235,195,233,197,233,200,233,201,235,201,233,199,231,198,226,198,220,196,207,195,195,195,181,195,173,195,163,194,155,192,145,192,143,192,138,191,135,191,133,191,130,190,128,188,129,186,129,181,132,173,131,162,131,151,132,149,132,138,132,136,132,122,131,120,131,109,130,107,130,90,132,81,133,76,133} );
  one.learn("x", new int[] {87,142,89,145,91,148,93,151,96,155,98,157,100,160,102,162,106,167,108,169,110,171,115,177,119,183,123,189,127,193,129,196,133,200,137,206,140,209,143,212,146,215,151,220,153,222,155,223,157,225,158,223,157,218,155,211,154,208,152,200,150,189,148,179,147,170,147,158,147,148,147,141,147,136,144,135,142,137,140,139,135,145,131,152,124,163,116,177,108,191,100,206,94,217,91,222,89,225,87,226,87,224} );
  one.learn("check", new int[] {91,185,93,185,95,185,97,185,100,188,102,189,104,190,106,193,108,195,110,198,112,201,114,204,115,207,117,210,118,212,120,214,121,217,122,219,123,222,124,224,126,226,127,229,129,231,130,233,129,231,129,228,129,226,129,224,129,221,129,218,129,212,129,208,130,198,132,189,134,182,137,173,143,164,147,157,151,151,155,144,161,137,165,131,171,122,174,118,176,114,177,112,177,114,175,116,173,118} );
  one.learn("caret", new int[] {79,245,79,242,79,239,80,237,80,234,81,232,82,230,84,224,86,220,86,218,87,216,88,213,90,207,91,202,92,200,93,194,94,192,96,189,97,186,100,179,102,173,105,165,107,160,109,158,112,151,115,144,117,139,119,136,119,134,120,132,121,129,122,127,124,125,126,124,129,125,131,127,132,130,136,139,141,154,145,166,151,182,156,193,157,196,161,209,162,211,167,223,169,229,170,231,173,237,176,242,177,244,179,250,181,255,182,257} );
  one.learn("zigzag", new int[] {307,216,333,186,356,215,375,186,399,216,418,186} );
  one.learn("arrow", new int[] {68,222,70,220,73,218,75,217,77,215,80,213,82,212,84,210,87,209,89,208,92,206,95,204,101,201,106,198,112,194,118,191,124,187,127,186,132,183,138,181,141,180,146,178,154,173,159,171,161,170,166,167,168,167,171,166,174,164,177,162,180,160,182,158,183,156,181,154,178,153,171,153,164,153,160,153,150,154,147,155,141,157,137,158,135,158,137,158,140,157,143,156,151,154,160,152,170,149,179,147,185,145,192,144,196,144,198,144,200,144,201,147,199,149,194,157,191,160,186,167,180,176,177,179,171,187,169,189,165,194,164,196} );
  one.learn("v", new int[] {89,164,90,162,92,162,94,164,95,166,96,169,97,171,99,175,101,178,103,182,106,189,108,194,111,199,114,204,117,209,119,214,122,218,124,222,126,225,128,228,130,229,133,233,134,236,136,239,138,240,139,242,140,244,142,242,142,240,142,237,143,235,143,233,145,229,146,226,148,217,149,208,149,205,151,196,151,193,153,182,155,172,157,165,159,160,162,155,164,150,165,148,166,146} );
  one.learn("delete", new int[] {123,129,123,131,124,133,125,136,127,140,129,142,133,148,137,154,143,158,145,161,148,164,153,170,158,176,160,178,164,183,168,188,171,191,175,196,178,200,180,202,181,205,184,208,186,210,187,213,188,215,186,212,183,211,177,208,169,206,162,205,154,207,145,209,137,210,129,214,122,217,118,218,111,221,109,222,110,219,112,217,118,209,120,207,128,196,135,187,138,183,148,167,157,153,163,145,165,142,172,133,177,127,179,127,180,125} );
  one.learn("pigtail", new int[] {81,219,84,218,86,220,88,220,90,220,92,219,95,220,97,219,99,220,102,218,105,217,107,216,110,216,113,214,116,212,118,210,121,208,124,205,126,202,129,199,132,196,136,191,139,187,142,182,144,179,146,174,148,170,149,168,151,162,152,160,152,157,152,155,152,151,152,149,152,146,149,142,148,139,145,137,141,135,139,135,134,136,130,140,128,142,126,145,122,150,119,158,117,163,115,170,114,175,117,184,120,190,125,199,129,203,133,208,138,213,145,215,155,218,164,219,166,219,177,219,182,218,192,216,196,213,199,212,201,211} );

  one.bind("triangle circle rectangle x check zigzag caret arrow v delete pigtail", "detected");
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
  one.track(mouseX, mouseY);
  redraw();
}

void mouseReleased(){
  one.check();
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
  if (key == 'w'){ // l for line (to keep it close to other keys)
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

// Simple callback for gestures
void detected(String gesture, float percent, int startX, int startY, int centroidX, int centroidY, int endX, int endY){
  println("Gesture: "+gesture+", "+startX+"/"+startY+", "+centroidX+"/"+centroidY+", "+endX+"/"+endY);
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
