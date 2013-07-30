part of math;

class Rectangle
{
  num x;
  num y;
  num width;
  num height;

  Rectangle([this.x = 0.0, this.y = 0.0, this.width = 0.0, this.height = 0.0]);
  Rectangle.from(Rectangle r) : this(r.x, r.y, r.width, r.height);
  Rectangle.fromCenter(num w,num h) : this(-w/2, -h/2, w, h);
  Rectangle.fromCenterPoint(Point2D size) : this(-size.x/2, -size.y/2,size.x, size.y);

  Rectangle clone() => new Rectangle.from(this);

  bool get isEmpty => (this.width == 0 && this.height == 0);
  void setEmpty() { this.x = 0.0; this.y = 0.0; this.width = 0.0; this.height = 0.0; }



  num get left => this.x;
      set left(num value){ this.width += this.x - value; this.x = value; }

  num get top => this.y;
      set top(num value){this.height += this.y - value; this.y = value;   }

  num get right => this.x + this.width;
      set right(num value){ this.width = value - this.x; }

  num get bottom => this.y + this.height;
      set bottom(num value){ this.height = value - this.y; }


  Point2D get topLeft => new Point2D(this.x, this.y);
          set topLeft(Point2D value){ this.left = value.x; this.top = value.y; }

  Point2D get bottomLeft => new Point2D(this.x, this.bottom);
          set bottomLeft(Point2D value){ this.bottom = value.x; this.bottom = value.y; }

  Point2D get topRight => new Point2D(this.right, this.y);
          set topRight(Point2D value){ this.right = value.x; this.top = value.y; }

  Point2D get bottomRight => new Point2D(this.right, this.bottom);
          set bottomRight(Point2D value){ this.right = value.x; this.bottom = value.y; }

  Point2D get size => new Point2D(this.width, this.height);
          set size(Point2D value){ this.width = value.x; this.height = value.y; }

  Point2D get center => new Point2D(this.x + this.width/2,this.y + this.height/2);
          set center(Point2D value) => offsetPoint(value);


  // -- point operations -- //

  bool contains(num px, num py) => (this.x <= px && this.y <= py && this.right >= px && this.bottom >= py);
  bool containsPoint(Point2D p) => contains(p.x,p.y);

  void inflate(num dx, num dy) { this.width = this.width + dx; this.height = this.height + dy; }
  void inflatePoint(Point2D p) =>  inflate(p.x,p.y);

  void expandFromCenter(num dx, num dy) {
    this.x = this.x - dx;
    this.y = this.y - dy;
    this.width = this.width + dx*2;
    this.height = this.height + dy*2;
  }
  void expandFromCenterPoint(Point2D p) =>  expandFromCenter(p.x,p.y);

  void offset(num dx, num dy) { this.x = this.x + dx; this.y = this.y + dy; }
  void offsetPoint(Point2D p) => offset(p.x,p.y);

  // -- rect opeations -- //

  bool containsRect(Rectangle r) => (this.left <= r.left && this.top <= r.top && this.right >= r.right && this.bottom >= r.bottom);
  bool equals(Rectangle r) => (this.x == r.x && this.y == r.y && this.width == r.width && this.height == r.height);
  bool intersects(Rectangle r) => (this.left < r.right && this.right > r.left && this.top < r.bottom && this.bottom > r.top);

  void setTo(num rx, num ry, num rwidth, num rheight) { this.x = rx; this.y = ry; this.width = rwidth; this.height = rheight; }
  void copyFrom(Rectangle r) => setTo(r.x,r.y,r.width,r.height);


  Rectangle intersection(Rectangle rect)
  {
    if (this.intersects (rect) == false) {
      return new Rectangle(0.0, 0.0, 0.0, 0.0);
    }

    num rLeft = max (this.left, rect.left);
    num rTop = max (this.top, rect.top);
    num rRight = min (this.right, rect.right);
    num rBottom = min (this.bottom, rect.bottom);

    return new Rectangle(rLeft, rRight, rRight - rLeft, rBottom - rTop);
  }

  Rectangle union(Rectangle rect)
  {
    num rLeft = min (this.left, rect.left);
    num rTop = min (this.top, rect.top);
    num rRight = max (this.right, rect.right);
    num rBottom = max (this.bottom, rect.bottom);

    return new Rectangle(rLeft, rRight, rRight - rLeft, rBottom - rTop);
  }
}
