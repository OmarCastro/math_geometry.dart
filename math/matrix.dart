part of math;

class Matrix
{
  num _a, _b, _c, _d, _tx, _ty;
  num _det;

  /// ceates a matrix with the specified parameters.
  Matrix(a, num b, num c, num d, num tx, num ty) :
    _a = a, _b = b, _c = c, _d = d, _tx = tx, _ty = ty, _det = a * d - b * c;

  /// creates an identity matrix */
  Matrix.identity() :
    _a = 1.0, _b = 0.0, _c = 0.0, _d = 1.0, _tx = 0.0, _ty = 0.0, _det = 1.0;

  Matrix.Box(num scaleX, num scaleY, [num rotation = 0.0,
             num translationX = 0.0, num translationY = 0.0]){
   this.setTobox(scaleX, scaleY, rotation, translationX, translationY);
  }

  /// Creates a copy of the matrix */
  Matrix clone()
  {
    return new Matrix(_a, _b, _c, _d, _tx, _ty);
  }

  /// Creates a copy of the inverted matrix */
  Matrix cloneInvert()
  {
    num a =    (_d / _det);
    num b =  - (_b / _det);
    num c =  - (_c / _det);
    num d =    (_a / _det);
    num tx = - (a * _tx + c * _ty);
    num ty = - (b * _tx + d * _ty);

    return new Matrix(a, b, c, d, tx, ty);
  }


  num get a => _a;
  num get b => _b;
  num get c => _c;
  num get d => _d;
  num get tx => _tx;
  num get ty => _ty;
  num get det => _det;

  /// creates a transformed point from point [p]
  Point2D transformPoint(Point2D p)
  {
    return new Point2D(p.x * _a + p.y * _c + _tx, p.x * _b + p.y * _d + _ty);
  }

  /// creates a transformed point from point [p] without applying translates
  Point2D deltaTransformPoint(Point2D p)
  {
    return new Point2D(p.x * _a + p.y * _c, p.x * _b + p.y * _d);
  }

  /// concatenates this matrix with [matrix]
  void concat(Matrix matrix)
  {
    num a1 =   _a;
    num b1 =   _b;
    num c1 =   _c;
    num d1 =   _d;
    num tx1 =  _tx;
    num ty1 =  _ty;
    num det1 = _det;

    num a2 =   matrix.a;
    num b2 =   matrix.b;
    num c2 =   matrix.c;
    num d2 =   matrix.d;
    num tx2 =  matrix.tx;
    num ty2 =  matrix.ty;
    num det2 = matrix.det;

    _a =   (a1 * a2 + b1 * c2);
    _b =   (a1 * b2 + b1 * d2);
    _c =   (c1 * a2 + d1 * c2);
    _d =   (c1 * b2 + d1 * d2);
    _tx =  (tx1 * a2 + ty1 * c2 + tx2);
    _ty =  (tx1 * b2 + ty1 * d2 + ty2);
    _det = (det1 * det2);
  }

  /// Creates a matrix my calling [setTobox]
  Matrix createBox(num scaleX, num scaleY, [num rotation = 0.0, num translationX = 0.0, num translationY = 0.0])
  {
    return new Matrix.identity()..setTobox(scaleX, scaleY, rotation, translationX, translationY);
  }

  /// sets the current matrix to an identity matrix
  void setToIdentity()
  {
    _a =   1.0;
    _b =   0.0;
    _c =   0.0;
    _d =   1.0;
    _tx =  0.0;
    _ty =  0.0;
    _det = 1.0;
  }

  /// Inverts current the matrix
  void invert()
  {
    num a =   _a;
    num b =   _b;
    num c =   _c;
    num d =   _d;
    num tx =  _tx;
    num ty =  _ty;
    num det = _det;

    _a =    (d / det);
    _b =  - (b / det);
    _c =  - (c / det);
    _d =    (a / det);
    _tx = - (_a * tx + _c * ty);
    _ty = - (_b * tx + _d * ty);
    _det =  (1.0 / det);
  }

  /**
   * [setTobox] method lets you change the matrix as you would if
   *  you were to apply [identity], [rotate]([rotation]), [scale]([scaleX],[scaleY])
   *  , and [translate]([translationX],[translationY])
   */
  void setTobox(num scaleX, num scaleY, [num rotation = 0.0, num translationX = 0.0, num translationY = 0.0]){
    num cosR = cos(rotation);
    num sinR = sin(rotation);

    _a  = cosR  * scaleX;
    _b  = sinR  * scaleY;
    _c  = -sinR * scaleX;
    _d  = cosR  * scaleY;
    _tx = translationX;
    _ty = translationY;
    _det = scaleX * scaleY;
  }

 /**
  * Rotates with [tx] and [ty] as origin
  * it equals as [translate]([tx],[ty]); [rotate]([rotation]); [translate](-[tx],-[ty])
  */
  void rotateTrAsOrigin(num rotation){
    num cosR = cos(rotation);
    num sinR = sin(rotation);

    num a =  _a;
    num b =  _b;
    num c =  _c;
    num d =  _d;

    _a =  (a * cosR - b * sinR);
    _b =  (a * sinR + b * cosR);
    _c =  (c * cosR - d * sinR);
    _d =  (c * sinR + d * cosR);
  }

  /// Applies the rotate transform; [rotation] should be in radians
  void rotate(num rotation)
  {
    num cosR = cos(rotation);
    num sinR = sin(rotation);

    num a =  _a;
    num b =  _b;
    num c =  _c;
    num d =  _d;
    num tx = _tx;
    num ty = _ty;

    _a =  (a * cosR - b * sinR);
    _b =  (a * sinR + b * cosR);
    _c =  (c * cosR - d * sinR);
    _d =  (c * sinR + d * cosR);
    _tx = (tx * cosR - ty * sinR);
    _ty = (tx * sinR + ty * cosR);
  }

  /// Applies the skew transform
  void skew(num skewX, num skewY)
  {
    num tanX = tan(skewX);
    num tanY = tan(skewY);

    num a =  _a;
    num b =  _b;
    num c =  _c;
    num d =  _d;
    num tx = _tx;
    num ty = _ty;

    _a =   (a - b * tanX);
    _b =   (b + a * tanY);
    _c =   (c - d * tanX);
    _d =   (d + c * tanY);
    _tx =  (tx - ty * tanX);
    _ty =  (ty + tx * tanY);
    _det = _a * _d - _b * _c;
  }

  /// Applies the scale transform
  void scale(num scaleX, num scaleY)
  {
    _a   *= scaleX;
    _b   *= scaleY;
    _c   *= scaleX;
    _d   *= scaleY;
    _tx  *= scaleX;
    _ty  *= scaleY;
    _det *= scaleX * scaleY;
  }

  /// Applies the translate transform
  void translate(num translationX, num translationY)
  {
    _tx += translationX;
    _ty += translationY;
  }

  /// Set the matrix with the specified parameters.
  void setTo(num a, num b, num c, num d, num tx, num ty)
  {
    _a =   a;
    _b =   b;
    _c =   c;
    _d =   d;
    _tx =  tx;
    _ty =  ty;
    _det = (a * d - b * c);
  }

  /// Copies from matrix [m]
  void copyFrom(Matrix m) => setTo(m.a,m.b,m.c,m.d,m.tx,m.ty);

  /// Copies from inverse of [matrix]
  void copyFromInverseOf(Matrix matrix)
  {
    num a =   matrix.a;
    num b =   matrix.b;
    num c =   matrix.c;
    num d =   matrix.d;
    num tx =  matrix.tx;
    num ty =  matrix.ty;
    num det = matrix.det;

    _a =    (d / det);
    _b =  - (b / det);
    _c =  - (c / det);
    _d =    (a / det);
    _tx = - (_a * tx + _c * ty);
    _ty = - (_b * tx + _d * ty);
    _det =  (1.0 / det);
  }

  bool operator == (Matrix m) =>
      (a == m.a && b == m.b && c == m.c && d == m.d && tx == m.tx && ty == m.ty);

  String toString() => "matrix("
                      "${a.toStringAsFixed(2)},"
                      "${b.toStringAsFixed(2)},"
                      "${c.toStringAsFixed(2)},"
                      "${d.toStringAsFixed(2)},"
                      "${tx.toStringAsFixed(2)},"
                      "${ty.toStringAsFixed(2)})";
}


