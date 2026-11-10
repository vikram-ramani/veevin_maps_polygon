import 'package:veevin_maps_polygon/compare.dart';

class VPoint {
  late double lat, lng;
  double precision = 0.000000001;

  VPoint() {
    setPrecision(0.000000001);
  }

  VPoint.initFromLatLng(
    double latValue,
    double lngValue, {
    double myPrecision = 0.000000001,
  }) {
    lat = latValue;
    lng = lngValue;
    setPrecision(myPrecision);
  }

  VPoint.initFromLatLngRec(
    ({double lat, double lng}) point, {
    double myPrecision = 0.000000001,
  }) {
    lat = point.lat;
    lng = point.lng;
    setPrecision(myPrecision);
  }

  VPoint.withPrecision(double myPrecision) {
    setPrecision(myPrecision);
  }

  ({double lat, double lng}) toLatLngRec() {
    return (lat: lat, lng: lng);
  }

  void setPrecision(double myPrecision) {
    precision = myPrecision;
  }

  void setLatLng(double latNew, double lngNew) {
    lat = latNew;
    lng = lngNew;
  }

  void setLatLngFromPoint(VPoint point) {
    lat = point.lat;
    lng = point.lng;
  }

  double getDistSquareFromPoint(VPoint point) {
    return getDistSquare(
      (lat: lat, lng: lng),
      (lat: point.lat, lng: point.lng),
    );
  }

  static double getDistSquare(
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
  int compareDistancesFromThisPoint(VPoint point1, VPoint point2) {
    return compareDistances(
      (lat: lat, lng: lng),
      (lat: point1.lat, lng: point1.lng),
      (lat: point2.lat, lng: point2.lng),
      myPrecision: precision,
    );
  }

  bool isSame(VPoint point) {
    return samePoint(
      (lat: lat, lng: lng),
      (lat: point.lat, lng: point.lng),
      myPrecision: precision,
    );
  }

  //0 points are at the same distance
  //-1 - point1 is closer
  // 1 - point2 is closer
  static int compareDistances(
    ({double lat, double lng}) point,
    ({double lat, double lng}) point1,
    ({double lat, double lng}) point2, {
    double myPrecision = 0.000000001,
  }) {
    double dist1 = getDistSquare(point, point1);
    double dist2 = getDistSquare(point, point2);
    int comp = VCompare.withPrecision(myPrecision)
        .compareWithPrecision(dist1, dist2);
    return comp;
  }

  static bool samePoint(
    ({double lat, double lng}) first,
    ({double lat, double lng}) second, {
    double myPrecision = 0.000000001,
  }) {
    return (first.lat - second.lat).abs() <= myPrecision &&
        (first.lng - second.lng).abs() <= myPrecision;
  }
}
