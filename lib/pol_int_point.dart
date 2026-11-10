import 'package:veevin_maps_polygon/point.dart';
import 'package:veevin_maps_polygon/polygon.dart';

import 'pol_edge.dart';

class VPolIntPoint extends VPoint {
  late VPolEdge edgeA, edgeB;
  bool isInside = false;

  VPolIntPoint({double myPrecision = 0.000000001}) {
    setPrecision(myPrecision);
  }

  VPolIntPoint.initFromEdges(
    VPolEdge edgeA,
    VPolEdge edgeB, {
    double myPrecision = 0.000000001,
  }) {
    setPrecision(myPrecision);
    setIntersectionPoint(edgeA, edgeB);
  }

  void setIntersectionPoint(VPolEdge edgeA, VPolEdge edgeB) {
    this.edgeA = edgeA;
    this.edgeB = edgeB;
    setIntersectionPointFromPoint(
      getIntersectionPoint(edgeA, edgeB, myPrecision: precision)!,
    );
  }

  void setIntersectionPointFromPoint(VPolIntPoint point) {
    lat = point.lat;
    lng = point.lng;
    edgeA = point.edgeA;
    edgeB = point.edgeB;
    isInside = point.isInside;
  }

  static ({double lat, double lng}) getIntersectionPointLatLng(
    ({double lat, double lng}) e1Start,
    ({double lat, double lng}) e1End,
    ({double lat, double lng}) e2Start,
    ({double lat, double lng}) e2End,
  ) {
    double x1 = e1Start.lat;
    double y1 = e1Start.lng;
    double x2 = e1End.lat;
    double y2 = e1End.lng;
    double x3 = e2Start.lat;
    double y3 = e2Start.lng;
    double x4 = e2End.lat;
    double y4 = e2End.lng;

    double denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (denom == 0) {
      // return (lat: 10000, lng: 10000);
      throw Exception('Lines are parallel');
    }

    double px =
        ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) /
        denom;
    double py =
        ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) /
        denom;

    return (lat: px, lng: py);
  }

  static VPolIntPoint? getIntersectionPoint(
    VPolEdge edgeA,
    VPolEdge edgeB, {
    myPrecision = 0.000000001,
  }) {
    final x1 = edgeA.start.lat;
    final y1 = edgeA.start.lng;
    final x2 = edgeA.end.lat;
    final y2 = edgeA.end.lng;

    final x3 = edgeB.start.lat;
    final y3 = edgeB.start.lng;
    final x4 = edgeB.end.lat;
    final y4 = edgeB.end.lng;
    final minAx = x1 < x2 ? x1 : x2;
    final maxAx = x1 > x2 ? x1 : x2;
    final minAy = y1 < y2 ? y1 : y2;
    final maxAy = y1 > y2 ? y1 : y2;
    final minBx = x3 < x4 ? x3 : x4;
    final maxBx = x3 > x4 ? x3 : x4;
    final minBy = y3 < y4 ? y3 : y4;
    final maxBy = y3 > y4 ? y3 : y4;

    if (maxAx < minBx || maxAy < minBy || maxBx < minAx || maxBy < minAy) {
      return null;
    }

    final denominator = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (denominator == 0) return null;

    ({double lat, double lng}) intersectionPoint = getIntersectionPointLatLng(
      (lat: x1, lng: y1),
      (lat: x2, lng: y2),
      (lat: x3, lng: y3),
      (lat: x4, lng: y4),
    );
    var ptinside1 = VPolygon.isPointInsidePolygonEdge(
      intersectionPoint,
      (lat: x1, lng: y1),
      (lat: x2, lng: y2),
      myPrecision: myPrecision,
    );
    var ptinside2 = VPolygon.isPointInsidePolygonEdge(
      intersectionPoint,
      (lat: x3, lng: y3),
      (lat: x4, lng: y4),
      myPrecision: myPrecision,
    );
    VPolIntPoint intersection = VPolIntPoint();
    intersection.lat = intersectionPoint.lat;
    intersection.lng = intersectionPoint.lng;
    intersection.edgeA = edgeA;
    intersection.edgeB = edgeB;
    intersection.isInside = false;
    if (ptinside1 == 0) {
      intersection.isInside = true;
      intersection.edgeA.iPoints.add(intersection);
      intersection.edgeB.iPoints.add(intersection);

      if (!(ptinside2 == 0)) {
        intersection.isInside = false;
        return null;
      }
      return intersection;
    }
    return null;
  }
}
