part of unit_tests;

class RectangleTest
{
  Rectangle rect1 = new Rectangle(0, 0, 10, 10);
  Rectangle rectCenter = new Rectangle.fromCenter(10, 10);
  
  void testIntersection(){
    int sizeXY = 10;
    for(int value = -20; value < 20; value++){
      String iterRason = "on iteration where value = $value";
      String reason = "error in implementation $iterRason";
      Rectangle toTest = new Rectangle(value,value,sizeXY,sizeXY);
      
      if(value <= -15 || value >= 5){
        expect(toTest.intersects(rectCenter), false, reason: reason);
      } else {
        expect(toTest.intersects(rectCenter), true, reason: reason);
        num top = max(toTest.top, rectCenter.top);
        num left = max(toTest.left, rectCenter.left);
        num bottom = min(toTest.bottom, rectCenter.bottom);
        num right = min(toTest.right, rectCenter.right);
        var intersection = toTest.intersection(rectCenter);
        expect(intersection.top, top, reason : "wrong intersction top value $iterRason");
        expect(intersection.left, left, reason : "wrong intersction left value $iterRason");
        expect(intersection.bottom, bottom, reason : "wrong intersction bottom value $iterRason");
        expect(intersection.right, right, reason : "wrong intersction right value $iterRason");
      }
      
      num top = min(toTest.top, rectCenter.top);
      num left = min(toTest.left, rectCenter.left);
      num bottom = max(toTest.bottom, rectCenter.bottom);
      num right = max(toTest.right, rectCenter.right);
      var union = toTest.union(rectCenter);
      expect(union.top, top, reason : "wrong union top value $iterRason");
      expect(union.left, left, reason : "wrong union left value $iterRason");
      expect(union.bottom, bottom, reason : "wrong union bottom value $iterRason");
      expect(union.right, right, reason : "wrong union right value $iterRason");
      
      
    }

  }

  void startTest(){
    test("Rectangle - intersection & union",testIntersection);
  }
}