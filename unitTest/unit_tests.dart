library unit_tests;

import 'dart:math';
import 'package:unittest/unittest.dart';
import '../math/geometry.dart';

part 'point2D_test.dart';
part 'matrix_test.dart';
part 'line2D_test.dart';

const tolerance = 0.0000001;


class C1{
  num a,b,c,d,e,f,g,h;
}

class C2{
  List<num> a;
}

main(){
  new Point2DTest()..startTest();
  new MatrixTest()..startTest();
  new Line2DTest()..startTest();
}



