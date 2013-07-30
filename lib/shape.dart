part of math;

class Shape2D{

  List<Point2D> points;
  Rectangle BBox;
  Shape2D():points = new List<Point2D>(),BBox = new Rectangle();

  Shape2D.rectangle(num x,num y,num w,num h):BBox = new Rectangle(){
    setToRectangle(new Rectangle(x,y,w,h));
  }

  Shape2D.fromRectangle(Rectangle r):BBox = new Rectangle(){
    setToRectangle(r);
  }


  void setToRectangle(Rectangle r){
    points = [r.topLeft,r.topRight,r.bottomRight,r.bottomLeft];
    updateBBox();
  }

  void setToTransformedRectangle(Rectangle r,Matrix m){
    points = [r.topLeft.clone()..transform(m),r.topRight.clone()..transform(m)
             ,r.bottomRight.clone()..transform(m),r.bottomLeft.clone()..transform(m)];
    updateBBox();
  }

  void updateBBox(){
    if(points.isEmpty){
      BBox.setEmpty();
    }
    else{
      num top = points.first.y;
      num bottom = top;
      num left = points.first.x;
      num right = left;
      for(Point2D point in points){
        if(top    > point.y) top    = point.y;
        if(bottom < point.y) bottom = point.y;
        if(left   > point.x) left   = point.x;
        if(right  < point.x) right  = point.x;
      }
      BBox.setTo(left,top,right-left,bottom-top);
    }

  }
}

