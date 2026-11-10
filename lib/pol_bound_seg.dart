import 'package:veevin_maps_polygon/point.dart';

class VPolBoundSeg {
  double precision = 0.000000001;
  late VPoint start;
  late VPoint end;

  VPolBoundSeg(this.start, this.end, {myPrecision = 0.000000001}) {
    setPrecision(myPrecision);
  }

  VPolBoundSeg.fromNamedRec(
    ({double lat, double lng}) startValue,
    ({double lat, double lng}) endValue, {
    myPrecision = 0.000000001,
  }) {
    start = VPoint.initFromLatLngRec(startValue, myPrecision: myPrecision);
    end = VPoint.initFromLatLngRec(endValue, myPrecision: myPrecision);
    setPrecision(myPrecision);
  }

  setPrecision(double myPrecision) {
    precision = myPrecision;
  }
}
