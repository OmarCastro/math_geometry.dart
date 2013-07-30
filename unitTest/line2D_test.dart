part of unit_tests;


class Line2DTest{
  final Line2D line1 =    new Line2D(0,0,3,3);
  final Point2D line1p1 = new Point2D(0,0);
  final Point2D line1p2 = new Point2D(3,3);
  final Point2D p1 =      new Point2D(3,0);
  final Point2D rp1 =     new Point2D(0,3);
  
  final Line2D line2 =    new Line2D(0,0,3,6);
  final Point2D line2p1 = new Point2D(0,0);
  final Point2D line2p2 = new Point2D(3,6);
  final Point2D p2 =      new Point2D(3,0);
  final Point2D rp2 =     new Point2D(0,3);
  

  
  void Values(){

    
    expect(line1.p1,equals(line1p1));
    expect(line1.p2,equals(line1p2));

  }
  

  
  void PointAt(){
    for(double p2X = 1.0; p2X < 10.0; p2X++){
      for(double p2Y = 1.0; p2Y < 10.0; p2Y++){
        Line2D line = new Line2D(0,0,p2X,p2Y);
        for(double i=0.0; i <= 1.0; i+=0.1){
          expect(line.pointAt(i),equals(new Point2D(i*p2X,i*p2Y)),
              reason:"error on Line2D.pointAt(num t)");
        }
      }
    }
  }
  
  void XYVal(){
    for(int it=0;it < 30;++it){
      double i=it/10;
      expect(line1.xValOf(i),closeTo(i,tolerance),reason:"error on Line2D.xValOf(num y)");
      expect(line1.yValOf(i),closeTo(i,tolerance),reason:"error on Line2D.xValOf(num y)");
      expect(line2.xValOf(i*2),closeTo(i,tolerance),reason:"error on Line2D.xValOf(num y)");
      expect(line2.yValOf(i),closeTo(i*2,tolerance),reason:"error on Line2D.xValOf(num y)");
    }
  }
  
  void Reflect(){
    
    expect(line1.reflect(p1),equals(rp1),reason:"error on Line2D.reflect(Point2D p)");
    expect(line1.reflect(rp1),equals(p1),reason:"error on Line2D.reflect(Point2D p)");
  }
  
  void startTest(){
    group('Line2D',(){
      test("Values",PointAt);
      test("PointAt",PointAt);
      test("XYVal",XYVal);
      test("Reflect",Reflect);
    });
    
  }
}