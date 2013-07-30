part of math;

class Point2D
{

  num x;
  num y;

  /// Creates a 2D point with the specified parameters.
  
  
  Point2D(this.x, this.y);
  /// Creates a null 2D point.
  Point2D.Zero(): this(0.0,0.0);
  /// Creates a copy of the point [p]
  Point2D.from(Point2D p) : this(p.x, p.y);
  /// Creates a point the polar coordinates
  Point2D.polar(num len, num angle): this(len * cos(angle), len * sin(angle));
  /// Creates a clone of the point
  Point2D clone() => new Point2D(this.x, this.y);


  /// Calculates the distance between [p1] and [p2]
  static num distance(Point2D p1, Point2D p2) => p1.distanceTo(p2);
  
  /// Calculates the interpolation between [p1] and [p2]
  static Point2D interpolate(Point2D p1, Point2D p2) => new Point2D((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);


  num get length => sqrt(this.x * this.x + this.y * this.y);
  num get lengthSquared => this.x * this.x + this.y * this.y;
  num get angle => atan2(this.y,this.x);
  num get angleInDegrees => angle*180/PI;
  num get rho => length;
  num get theta => angle;

  void add(Point2D p){this.x += p.x;this.y += p.y;}
  void subtract(Point2D p){this.x -= p.x; this.y -= p.y;}
  void multiply(num value){this.x *= value; this.y *= value;}
  void divide(num value){this.x /= value; this.y /= value;}

  Point2D operator + (Point2D p) => new Point2D(this.x + p.x, this.y + p.y);
  Point2D operator - (Point2D p) => new Point2D(this.x - p.x, this.y - p.y);
  Point2D operator * (num value) => new Point2D(this.x * value, this.y * value);
  Point2D operator / (num value) => new Point2D(this.x / value, this.y / value);
  num dot(Point2D p) => this.x*p.x + this.y*p.y;
  num perpDot(Point2D p) => this.y*p.x - this.x*p.y;

  bool operator == (Point2D p) => this.x == p.x && this.y == p.y;

  void copyFrom(Point2D p) { this.x = p.x; this.y = p.y; }
  void setTo(num px, num py) { this.x = px; this.y = py; }


  void normalize(num length)
  {
    num currentLength = this.length;
    this.x = this.x * length / currentLength;
    this.y = this.y * length / currentLength;
  }

  void offset(num dx, num dy)
  {
    this.x = this.x + dx;
    this.y = this.y + dy;
  }

  void offsetPoint(Point2D point) => offset(point.x,point.y);

  void transform(Matrix matrix)
  {
    num currentX = this.x;
    num currentY = this.y;

    this.x = currentX * matrix.a + currentY * matrix.c + matrix.tx;
    this.y = currentX * matrix.b + currentY * matrix.d + matrix.ty;
  }


  num distanceTo(Point2D other)
  {
      num dx = x - other.x;
      num dy = y - other.y;
      return sqrt(dx * dx + dy * dy);
  }

  String toString() => "point{x: $x, y:$y}";


}


