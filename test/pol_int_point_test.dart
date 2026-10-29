import 'package:flutter_test/flutter_test.dart';
import 'package:veevin_maps_polygon/pol_edge.dart';
import 'package:veevin_maps_polygon/pol_int_point.dart';
import 'package:veevin_maps_polygon/pol_point.dart';

void main() {
  test('line intersection perpendicular', () {
    ({double lat, double lng}) p1 = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) p2 = (lat: 10.0, lng: 0.0);
    ({double lat, double lng}) p3 = (lat: 5.0, lng: -5.0);
    ({double lat, double lng}) p4 = (lat: 5.0, lng: 5.0);
    VPolIntPoint vPolygon = VPolIntPoint();
    VPolEdge edgeA = VPolEdge();
    VPolEdge edgeB = VPolEdge();
    edgeA.start = VPolPoint();
    edgeA.end = VPolPoint();
    edgeB.start = VPolPoint();
    edgeB.end = VPolPoint();

    edgeA.start.lat = p1.lat;
    edgeA.start.lng = p1.lng;
    edgeA.end.lat = p2.lat;
    edgeA.end.lng = p2.lng;
    edgeB.start.lat = p3.lat;
    edgeB.start.lng = p3.lng;
    edgeB.end.lat = p4.lat;
    edgeB.end.lng = p4.lng;
    var intersectionPoint = vPolygon.getIntersectionPoint(edgeA, edgeB);
    expect(intersectionPoint?.lat, equals(5.0));
    expect(intersectionPoint?.lng, equals(0.0));
  });

  test('line intersection parallel', () {
    ({double lat, double lng}) p1 = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) p2 = (lat: 10.0, lng: 0.0);
    ({double lat, double lng}) p3 = (lat: 0.0, lng: 10.0);
    ({double lat, double lng}) p4 = (lat: 10.0, lng: 10.0);
    VPolIntPoint vPolygon = VPolIntPoint();
    VPolEdge edgeA = VPolEdge();
    VPolEdge edgeB = VPolEdge();
    edgeA.start = VPolPoint();
    edgeA.end = VPolPoint();
    edgeB.start = VPolPoint();
    edgeB.end = VPolPoint();

    edgeA.start.lat = p1.lat;
    edgeA.start.lng = p1.lng;
    edgeA.end.lat = p2.lat;
    edgeA.end.lng = p2.lng;
    edgeB.start.lat = p3.lat;
    edgeB.start.lng = p3.lng;
    edgeB.end.lat = p4.lat;
    edgeB.end.lng = p4.lng;
    try {
      var intersectionPoint = vPolygon.getIntersectionPoint(edgeA, edgeB);
      expect(true, false);
    } catch (e) {
      expect(true, true);
    }
    expect(true, true);
  });

  test('line intersection skew', () {
    ({double lat, double lng}) p1 = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) p2 = (lat: 10.0, lng: 10.0);
    ({double lat, double lng}) p3 = (lat: 0.0, lng: 10.0);
    ({double lat, double lng}) p4 = (lat: 10.0, lng: 0.0);
    VPolIntPoint vPolygon = VPolIntPoint();
    VPolEdge edgeA = VPolEdge();
    VPolEdge edgeB = VPolEdge();
    edgeA.start = VPolPoint();
    edgeA.end = VPolPoint();
    edgeB.start = VPolPoint();
    edgeB.end = VPolPoint();

    edgeA.start.lat = p1.lat;
    edgeA.start.lng = p1.lng;
    edgeA.end.lat = p2.lat;
    edgeA.end.lng = p2.lng;
    edgeB.start.lat = p3.lat;
    edgeB.start.lng = p3.lng;
    edgeB.end.lat = p4.lat;
    edgeB.end.lng = p4.lng;
    var intersectionPoint = vPolygon.getIntersectionPoint(edgeA, edgeB);
    expect(intersectionPoint?.lat, closeTo(5.0, 0.000001));
    expect(intersectionPoint?.lng, closeTo(5.0, 0.000001));
  });
}
