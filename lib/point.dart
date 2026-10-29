class VPoint {
  late double lat, lng;
  double precision = 0.000000001;

  double getDistSquare(
    ({double lat, double lng}) pointA,
    ({double lat, double lng}) pointB,
  ) {
    var x = pointA.lat;
    var y = pointA.lng;
    var x1 = pointB.lat;
    var y1 = pointB.lng;

    var xdiff = x - x1;
    var ydiff = y - y1;

    double distSq = xdiff * xdiff + ydiff * ydiff;
    return distSq;
  }

  //0 points are at the same distance
  //-1 - point1 is closer
  // 1 - point2 is closer
  int compareDistances(
    ({double lat, double lng}) point,
    ({double lat, double lng}) point1,
    ({double lat, double lng}) point2,
  ) {
    double dist1 = getDistSquare(point, point1);
    double dist2 = getDistSquare(point, point2);
    int comp = compareWithPrecision(dist1, dist2);
    return comp;
  }

  // 0 - both are equal
  // 1 - Main is greater
  // -1 - Other is greater
  int compareWithPrecision(double valueMain, double valueOther) {
    if ((valueMain - valueOther).abs() <= precision) {
      return 0;
    }
    if (valueMain - valueOther > precision) {
      return 1;
    }
    return -1;
  }
}
