import 'dart:math';

import 'package:veevin_maps_polygon/pol_edge.dart';
import 'package:veevin_maps_polygon/pol_int_point.dart';
import 'package:veevin_maps_polygon/pol_point.dart';

class VPolygon {
  final double precision = 0.000000001;
  bool printDebug = false;
  List<VPolPoint> points = [];
  List<({double lat, double lng})> pointsLatLng = [];

  void loadPolygon(List<({double lat, double lng})> pointsLatLngNew) {
    pointsLatLng = pointsLatLngNew;
    bool isClockwise = !checkAntiClockwise();
    latLngToPoints(isClockwise);
    populateEdges();
  }

  void getPolygonLatLng() {
    pointsLatLng.clear();
    for (var point in points) {
      pointsLatLng.add((lat: point.lat, lng: point.lng));
    }
  }

  bool checkAntiClockwise() {
    if (pointsLatLng.isEmpty) return false;

    double sum = 0.0;
    for (int i = 0; i < pointsLatLng.length; i++) {
      final current = pointsLatLng[i];
      final next = pointsLatLng[(i + 1) % pointsLatLng.length];
      sum += (next.lng - current.lng) * (next.lat + current.lat);
    }
    return sum > 0;
  }

  void latLngToPoints(bool isClockwise) {
    points.clear();
    if (isClockwise) {
      pointsLatLng = pointsLatLng.reversed.toList();
    }
    for (var latLng in pointsLatLng) {
      final point = VPolPoint();
      point.lat = latLng.lat;
      point.lng = latLng.lng;
      points.add(point);
    }
  }

  void populateEdges() {
    if (points.isEmpty) return;

    for (int i = 0; i < points.length; i++) {
      final current = points[i];
      final next = points[(i + 1) % points.length];
      final prev = points[(i - 1 + points.length) % points.length];
      VPolEdge prevEdge = VPolEdge();
      VPolEdge nextEdge = VPolEdge();
      prevEdge.start = prev;
      prevEdge.end = current;
      nextEdge.start = current;
      nextEdge.end = next;
      current.prev = prevEdge;
      current.next = nextEdge;
    }
  }

  bool isPointInsideOrOnEdgePolygonVV(({double lat, double lng}) point) {
    List<({double lat, double lng})> polygon = pointsLatLng;
    int rayInterCounter = 0;
    for (int i = 0; i < polygon.length; i++) {
      var currentPoint = polygon[i];
      var nextPoint = polygon[(i + 1) % polygon.length];

      if ((point.lng >= currentPoint.lng && point.lng <= nextPoint.lng) ||
          (point.lng <= currentPoint.lng && point.lng >= nextPoint.lng)) {
        if (point.lat <= max(nextPoint.lat, currentPoint.lat)) {
          ({double lat, double lng}) rightSidePoint = (
            lat: point.lat + 10.0,
            lng: point.lng,
          );
          try {
            var rightInterectionPoint = VPolIntPoint()
                .getIntersectionPointLatLng(
                  point,
                  rightSidePoint,
                  currentPoint,
                  nextPoint,
                );

            double latDiff = rightInterectionPoint.lat - point.lat;
            if (latDiff > precision) {
              // tests passed with latdiff.abs() also
              rayInterCounter++;
            } else if (latDiff.abs() <= precision) {
              return true;
            }
          } catch (e) {
            if (point.lat >= min(nextPoint.lat, currentPoint.lat)) {
              return true;
            }
          }
        }
      }
    }
    if (rayInterCounter % 2 ==
        1) // Check if the point is on the edge of the polygon
    {
      return true;
    }

    return false;
  }

  int isPointInsidePolygonEdge(
    ({double lat, double lng}) point,
    ({double lat, double lng}) edgeStart1,
    ({double lat, double lng}) edgeEnd1,
  ) {
    var (x1, y1) = (edgeStart1.lat, edgeStart1.lng);
    var (x2, y2) = (edgeEnd1.lat, edgeEnd1.lng);
    var (xp, yp) = (point.lat, point.lng);
    double edgXDiff = x2 - x1;
    double edgYDiff = y2 - y1;
    if (edgXDiff.abs() < precision) {
      // Vertical line case
      double pointXDiff = xp - x1;
      //double pointYDiff = yp - y1;
      if (pointXDiff.abs() < precision) {
        if ((y1 <= yp && yp <= y2) || (y2 <= yp && yp <= y1)) {
          return 0; // Point is on the edge
        }
        return 2; // Point is outside the polygon
      } else if ((pointXDiff > 0 && edgYDiff > 0) ||
          (pointXDiff < 0 && edgYDiff < 0)) {
        return -1; // Point is outside the polygon
      }
      return 1; // Point is inside the polygon
    }
    double mSlope = (y2 - y1) / edgXDiff;
    double cIntercept = y1 - mSlope * x1;
    double yOnLine = mSlope * xp + cIntercept;
    double yDiff = yp - yOnLine;
    if (yDiff.abs() < precision) {
      if ((x1 <= xp && xp <= x2) || (x2 <= xp && xp <= x1)) {
        return 0; // Point is inside the polygon
      }
      return 2; // Point is outside the polygon
    } else if ((yDiff > 0 && edgXDiff > 0) || (yDiff < 0 && edgXDiff < 0)) {
      return 1;
    }
    return -1;
  }

  ({double latmin, double latmax, double lngmin, double lngmax})
  getPolygonBounds(List<({double lat, double lng})> polygon) {
    double latmin = double.infinity;
    double latmax = double.negativeInfinity;
    double lngmin = double.infinity;
    double lngmax = double.negativeInfinity;
    for (var point in polygon) {
      if (point.lat < latmin) latmin = point.lat;
      if (point.lat > latmax) latmax = point.lat;
      if (point.lng < lngmin) lngmin = point.lng;
      if (point.lng > lngmax) lngmax = point.lng;
    }
    return (latmin: latmin, latmax: latmax, lngmin: lngmin, lngmax: lngmax);
  }

  bool doPolygonsIntersectExact(
    List<({double lat, double lng})> polygon1,
    List<({double lat, double lng})> polygon2,
  ) {
    final polygonToCheck = VPolygon()..pointsLatLng = polygon2;
    for (var point in polygon1) {
      if (polygonToCheck.isPointInsideOrOnEdgePolygonVV(point)) {
        return true;
      }
    }
    return false;
  }

  bool doPolygonsIntersectWithBounds(
    List<({double lat, double lng})> polygon1,
    List<({double lat, double lng})> polygon2,
  ) {
    var bounds1 = getPolygonBounds(polygon1);
    var bounds2 = getPolygonBounds(polygon2);

    return !(bounds1.latmax < bounds2.latmin ||
        bounds1.latmin > bounds2.latmax ||
        bounds1.lngmax < bounds2.lngmin ||
        bounds1.lngmin > bounds2.lngmax);
  }

  bool doPolygonsIntersect(
    List<({double lat, double lng})> polygon1,
    List<({double lat, double lng})> polygon2,
  ) {
    if (!doPolygonsIntersectWithBounds(polygon1, polygon2)) {
      return false;
    }
    return doPolygonsIntersectExact(polygon1, polygon2);
  }
}
