part of unit_tests;

///tests for the matrix class
class MatrixTest{

  void testMatrixBox(){
    for(int i=0; i <= 10;++i){
      
      num scaleX = 0.1*i, scaleY = 0.25*i , rotation = i*PI/10,
          translationX = 30+i, translationY = 50*i;
  
      Matrix m1 = new Matrix.identity()
          ..rotate(rotation)
          ..scale(scaleX, scaleY)
          ..translate(translationX, translationY);
  
      Matrix m2 = new Matrix.Box(scaleX, scaleY, rotation, translationX, translationY);
      expect(m1,equals(m2), reason: "error in implementation of [setTobox]");
    }
  }

  void testInvert(){
    for(int i=0; i <= 10;++i){
      
      num scaleX = 0.1*i, scaleY = 0.25*i , rotation = i*PI/10,
          translationX = 30+i, translationY = 50*i;

      
      Matrix m1 = new Matrix.Box(scaleX, scaleY, rotation, translationX, translationY);
      if(scaleX*scaleY != 0){
        Matrix m2 = m1.clone()..invert()..invert();
        expect(m1.a,closeTo(m2.a,tolerance), reason: "error in implementation of [invert] on iteration $i");
        expect(m1.b,closeTo(m2.b,tolerance), reason: "error in implementation of [invert] on iteration $i");
        expect(m1.c,closeTo(m2.c,tolerance), reason: "error in implementation of [invert] on iteration $i");
        expect(m1.d,closeTo(m2.d,tolerance), reason: "error in implementation of [invert] on iteration $i");
        expect(m1.tx,closeTo(m2.tx,tolerance), reason: "error in implementation of [invert] on iteration $i");
        expect(m1.ty,closeTo(m2.ty,tolerance), reason: "error in implementation of [invert] on iteration $i");

      }
    }
  }

  void startTest(){
    group('MatrixTest',(){
      test("testMatrixBox",testMatrixBox);
      test("testInvert",testInvert);
    });
  }
}

