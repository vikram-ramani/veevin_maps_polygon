import 'package:flutter_test/flutter_test.dart';
import 'package:veevin_maps_polygon/polygon.dart';

void main() {
  /*
  test('getNewPolygonFromLatLngBounds builds polygon from 4 corners', () {
    final vPolygon = V2PolygonVeevin();
    final bounds = PolygonLatlngBounds(
      lat_1: 10.0,
      lng_1: 20.0,
      lat_2: 11.0,
      lng_2: 21.0,
      lat_3: 12.0,
      lng_3: 22.0,
      lat_4: 13.0,
      lng_4: 23.0,
      setBusinessTypes: {'a'},
    );

    final polygon = vPolygon.getNewPolygonFromLatLngBounds(bounds);
    final points = polygon;

    expect(points.length, greaterThanOrEqualTo(4));
    expect(points[0], equals((lat: 10.0, lng: 20.0)));
    expect(points[1], equals((lat: 11.0, lng: 21.0)));
    expect(points[2], equals((lat: 12.0, lng: 22.0)));
    expect(points[3], equals((lat: 13.0, lng: 23.0)));
  });*/

  test('point standing edge right side', () {
    ({double lat, double lng}) edgeStart = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 0.0, lng: 10.0);
    ({double lat, double lng}) point = (lat: 5.0, lng: 5.0);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
    expect(result, equals(-1));
  });

  test('point standing edge right side 2', () {
    ({double lat, double lng}) edgeStart = (lat: 10.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 10.0, lng: 10.0);
    ({double lat, double lng}) point = (lat: 15.0, lng: 0.0);
    List<({double lat, double lng})> points =
        []; //= [point, edgeStart, edgeEnd];
    points.add(point);
    points.add(edgeStart);
    points.add(edgeEnd);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
    expect(result, equals(-1));
  });

  test('point standing edge left side', () {
    ({double lat, double lng}) edgeStart = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 0.0, lng: 10.0);
    ({double lat, double lng}) point = (lat: -5.0, lng: 5.0);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
    expect(result, equals(1));
  });

  test('point standing edge left side 2', () {
    ({double lat, double lng}) edgeStart = (lat: 10.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 10.0, lng: 10.0);
    ({double lat, double lng}) point = (lat: 15.0, lng: 0.0);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeEnd, edgeStart);
    expect(result, equals(1));
  });

  test(
    'point inside standing edge clockwise on the line, within the line segment',
    () {
      ({double lat, double lng}) edgeStart = (lat: 0.0, lng: 0.0);
      ({double lat, double lng}) edgeEnd = (lat: 0.0, lng: 10.0);
      ({double lat, double lng}) point = (lat: 0.0, lng: 5.0);
      VPolygon vPolygon = VPolygon();
      int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
      int result1 = vPolygon.isPointInsidePolygonEdge(
        point,
        edgeEnd,
        edgeStart,
      );
      expect(result, equals(0));
      expect(result1, equals(0));
    },
  );

  test('point inside standing edge clockwise on the line, outside the line segment', () {
    ({double lat, double lng}) edgeStart = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 0.0, lng: 10.0);
    ({double lat, double lng}) point = (lat: 0.0, lng: 15.0);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
    int result1 = vPolygon.isPointInsidePolygonEdge(point, edgeEnd, edgeStart);
    expect(result, equals(2));
    expect(result1, equals(2));
  });

  test('point flat edge left side', () {
    ({double lat, double lng}) edgeStart = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 10.0, lng: 0.0);
    ({double lat, double lng}) point = (lat: 0.0, lng: 5.0);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
    expect(result, equals(1));
  });

  test('point flat edge right side', () {
    ({double lat, double lng}) edgeStart = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 10.0, lng: 0.0);
    ({double lat, double lng}) point = (lat: 5.0, lng: -5.0);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
    expect(result, equals(-1));
  });

  test('point inside flat edge on the line, within the line segment', () {
    ({double lat, double lng}) edgeStart = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 10.0, lng: 0.0);
    ({double lat, double lng}) point = (lat: 5.0, lng: 0.0);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
    int result1 = vPolygon.isPointInsidePolygonEdge(point, edgeEnd, edgeStart);
    expect(result, equals(0));
    expect(result1, equals(0));
  });

  test('point inside flat edge on the line, outside the line segment', () {
    ({double lat, double lng}) edgeStart = (lat: 0.0, lng: 0.0);
    ({double lat, double lng}) edgeEnd = (lat: 10.0, lng: 0.0);
    ({double lat, double lng}) point = (lat: 15.0, lng: 0.0);
    VPolygon vPolygon = VPolygon();
    int result = vPolygon.isPointInsidePolygonEdge(point, edgeStart, edgeEnd);
    int result1 = vPolygon.isPointInsidePolygonEdge(point, edgeEnd, edgeStart);
    expect(result, equals(2));
    expect(result, equals(2));
  });

  test('outside point outside polygon counter clockwise', () {
    List<({double lat, double lng})> polygon = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    ({double lat, double lng}) point = (lat: 15.0, lng: 0.0);
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygon);
    bool inside = vPolygon.isPointInsideOrOnEdgePolygonVV(point);
    expect(inside, equals(false));
  });

  test('outside point outside polygon clockwise', () {
    List<({double lat, double lng})> polygon = [
      (lat: 0.0, lng: 0.0),
      (lat: 0.0, lng: 10.0),
      (lat: 10.0, lng: 10.0),
      (lat: 10.0, lng: 0.0),
    ];
    ({double lat, double lng}) point = (lat: 15.0, lng: 0.0);
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygon);
    bool inside = vPolygon.isPointInsideOrOnEdgePolygonVV(point);
    expect(inside, equals(false));
  });

  test(' point on edge polygon counter clockwise', () {
    List<({double lat, double lng})> polygon = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    ({double lat, double lng}) point = (lat: 0.0, lng: 0.0);
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygon);
    bool inside = vPolygon.isPointInsideOrOnEdgePolygonVV(point);
    expect(inside, equals(true));
  });

  // polygon can be in any order not  counter clockwise order to work
  test(' point inside polygon clockwise ', () {
    List<({double lat, double lng})> polygon = [
      (lat: 0.0, lng: 0.0),
      (lat: 0.0, lng: 10.0),
      (lat: 10.0, lng: 10.0),
      (lat: 10.0, lng: 0.0),
    ];
    ({double lat, double lng}) point = (lat: 5.0, lng: 5.0);
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygon);
    bool inside = vPolygon.isPointInsideOrOnEdgePolygonVV(point);
    expect(inside, equals(true));
  });

  test(' point on edge polygon counter clockwise 2', () {
    List<({double lat, double lng})> polygon = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    ({double lat, double lng}) point = (lat: 5.0, lng: 0.0);
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygon);
    bool inside = vPolygon.isPointInsideOrOnEdgePolygonVV(point);
    expect(inside, equals(true));
  });

  test(' point inside polygon counter clockwise 2', () {
    List<({double lat, double lng})> polygon = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    ({double lat, double lng}) point = (lat: 5.0, lng: 5.0);
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygon);
    bool inside = vPolygon.isPointInsideOrOnEdgePolygonVV(point);
    expect(inside, equals(true));
  });

  test(' point inside polygon clockwise (repeat)', () {
    List<({double lat, double lng})> polygon = [
      (lat: 0.0, lng: 0.0),
      (lat: 0.0, lng: 10.0),
      (lat: 10.0, lng: 10.0),
      (lat: 10.0, lng: 0.0),
    ];
    ({double lat, double lng}) point = (lat: 5.0, lng: 5.0);
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygon);
    bool inside = vPolygon.isPointInsideOrOnEdgePolygonVV(point);
    expect(inside, equals(true));
  });

  test('corner point 1 - inside polygon vv', () {
    ({double lat, double lng}) point1 = (lat: 10, lng: 10);
    ({double lat, double lng}) point2 = (lat: 10, lng: 20);
    ({double lat, double lng}) point3 = (lat: 0, lng: 10);
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 10.0, lng: 10.0),
      (lat: 20.0, lng: 10.0),
      (lat: 20.0, lng: 20.0),
      (lat: 10.0, lng: 20.0),
    ];
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygonOriginal);
    bool result1 = vPolygon.isPointInsideOrOnEdgePolygonVV(point1);
    bool result2 = vPolygon.isPointInsideOrOnEdgePolygonVV(point2);
    bool result3 = vPolygon.isPointInsideOrOnEdgePolygonVV(point3);
    expect(result1, true);
    expect(result2, true);
    expect(result3, false); //test failed
  });

  test('corner point 2- inside polygon vv', () {
    ({double lat, double lng}) point1 = (lat: 10, lng: 10);
    ({double lat, double lng}) point2 = (lat: 10, lng: 20);
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    VPolygon vPolygon = VPolygon();
    vPolygon.loadPolygon(polygonOriginal);
    bool result1 = vPolygon.isPointInsideOrOnEdgePolygonVV(point1);
    bool result2 = vPolygon.isPointInsideOrOnEdgePolygonVV(point2);
    expect(result1, true);
    expect(result2, false);
  });
}
