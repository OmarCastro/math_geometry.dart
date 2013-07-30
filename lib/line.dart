part of math;

class Line2D{


  Point2D p1,p2;


  num get x1 => p1.x;
  num get x2 => p2.x;
  num get y1 => p1.y;
  num get y2 => p2.y;

  /// b value of f(x) = b + mx;
  num get b => p1.y - m * p1.x;

  /// m value of f(x) = b + mx;
  num get m => dy/dx;

  /// difference of the x value of the 2 ends of the line
  num get dx => p2.x - p1.x;

  /// difference of the y value of the 2 ends of the line
  num get dy => p2.y - p1.y;

  /// checks if the line is horizontal
  bool get isHorizontal =>  p2.y == p1.y;

  /// checks if the line is vertical
  bool get isVertical =>  p2.x == p1.x;

  num get lenght => sqrt(dx * dx + dy * dy);

  num get lenghtSquared => dx * dx + dy * dy;


  Line2D(num x1, num y1, num x2, num y2):
    p1 = new Point2D(x1,y1),
    p2 = new Point2D(x2,y2);

  Line2D.Points(Point2D startPoint,Point2D endPoint):
    p1 = startPoint.clone(),
    p2 = endPoint.clone();

  Line2D.from(Line2D line):
    p1 = line.p1.clone(),
    p2 = line.p2.clone();

  Line2D.polar(num lenght, num angle):
    p1 = new Point2D.Zero(),
    p2 = new Point2D(lenght*cos(angle),lenght*sin(angle));

  Line2D.polarFromPoint(Point2D p,num lenght, num angle):
    p1 = p.clone(),
    p2 = new Point2D(lenght*cos(angle)+p.x,lenght*sin(angle)+p.y);


  Line2D clone() => new Line2D.from(this);

  void setTo(num x1, num y1, num x2, num y2){
   p1.setTo(x1, y1); p2.setTo(x2, y2);
  }

  void setToPoints(Point2D startPoint,Point2D endPoint){
    p1.copyFrom(startPoint); p2.copyFrom(endPoint);
  }

  void copyFrom(Line2D line){
    p1.copyFrom(line.p1); p2.copyFrom(line.p2);
  }

  void offsetPoint(Point2D point){
    p1.offsetPoint(point); p2.offsetPoint(point);
  }


  void offset(num dx,num dy){
    p1.offset(dx, dy);p2.offset(dx, dy);
  }

  /// gets the y value of parameter x, returns null line is vertical
  num yValOf(num x) => (isVertical)  ? null : pointAt((x-p1.x)/dx).y;

  /// gets the x value of parameter y, returns null line is horizontal
  num xValOf(num y) => (isHorizontal)? null : pointAt((y-p1.y)/dy).x;

  /**
   * Returns the point at the parameterized position specified by t.
   * The function returns the line's start point if t = 0,
   * and its end point if t = 1.
   */
  Point2D pointAt(num t) => (p2 - p1)..multiply(t)..add(p1);

  /**
   * return the parameter t of intersection between the
   * line and [line], returns null if it doesnt intersect;
   * to return the point you should use [pointAt] like this:
   *     Line2D a = getLineFromSomeWhere();
   *     Line2D b = getAnotherLineFromSomeWhere();
   *
   *     //in case you know they intersects
   *     Point2D intersection = a.pointAt(a.intersection(b));
   *
   * if you want to check if they intersect
   *     num t =  a.intersection(b);
   *     if(t == null || t < 0 || t > 1){
   *      //they dont intersect
   *     } else {
   *      Point2D intersection = a.pointAt(val);
   *     }
   *
   */
  num intersection(Line2D line){
    Point2D a = p2 - p1, b = line.p2 - line.p1;
    num f = a.perpDot(b);
    if(f == 0) return null;
    return 1.0 - (a.perpDot(line.p2 - this.p2) / f);
  }

/**
 * Returns the nearest parameterized position of the point specified by t.
 */
  num nearestParamT(Point2D p){
    num l2 = lenghtSquared;
    return (l2 == 0)? 0 : (p - p1).dot(p2 - p1) / l2;
  }

  Point2D nearestPointInLine(Point2D p){
    num t = nearestParamT(p);
    return (t < 0.0)? p1.clone() :(t > 1.0)? p2.clone() : pointAt(t);
  }

  Point2D nearestPointInInfiniteLine(Point2D p) => pointAt(nearestParamT(p));

  /// gets the distance of a point [p] to the line
  num distanceToPoint(Point2D p) => (nearestPointInLine(p)..subtract(p)).length;

  /// gets the point that reflects in the line
  Point2D reflect(Point2D p) => nearestPointInInfiniteLine(p)..multiply(2)..subtract(p);

}
