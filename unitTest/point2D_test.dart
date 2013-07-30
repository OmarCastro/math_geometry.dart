part of unit_tests;

/// tests for the point2dClass
class Point2DTest
{

  Point2D p1 = new Point2D(0,1);
  Point2D p2 = new Point2D(0,0);
  Point2D p3 = new Point2D(10,0);

  Point2DTest();

  void testDistance(){
    expect(p1.distanceTo(p2),equals(1));
    expect(p1.distanceTo(p3),equals(sqrt(101)));
    expect(p2.distanceTo(p3),equals(10));

  }

  void testPolar(){
    num p1rho = 10, p1theta = PI/2;
    Point2D polar1 = new Point2D.polar(p1rho,p1theta);
    expect(polar1.rho, equals(p1rho), reason:"rho value is different");
    expect(polar1.theta, equals(p1theta), reason:"theta value is different");

  }

  void startTest(){
    test("Point2DTest - Distance",testDistance);
    test("Point2DTest - Polar",testPolar);
  }
}