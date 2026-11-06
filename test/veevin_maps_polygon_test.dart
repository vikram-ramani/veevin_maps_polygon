import 'package:flutter_test/flutter_test.dart';

import 'package:veevin_maps_polygon/point.dart';
import 'package:veevin_maps_polygon/pol_binary.dart';
import 'package:veevin_maps_polygon/polygon.dart';

void main() {
  test('test point', () {
    final point = VPoint();
    point.lat = 0.0;
    point.lng = 0.0;

    expect(point.lat, equals(0.0));
    expect(point.lng, equals(0.0));
  });

  test('polygon difference keeps the area of A outside overlapping B', () {
    final binary = VPolBinary.runInit(
      [(lat: 0, lng: 0), (lat: 4, lng: 0), (lat: 4, lng: 4), (lat: 0, lng: 4)],
      [
        (lat: 2, lng: -1),
        (lat: 5, lng: -1),
        (lat: 5, lng: 3),
        (lat: 2, lng: 3),
      ],
    )..polygonDifference();

    expect(binary.pDiffPolygons, hasLength(1));
    expect(_signedArea(binary.pDiff), closeTo(10, 0.000001));
  });

  test(
    'polygon difference keeps contained cutouts as a reverse-wound ring',
    () {
      final binary = VPolBinary.runInit(
        [
          (lat: 0, lng: 0),
          (lat: 4, lng: 0),
          (lat: 4, lng: 4),
          (lat: 0, lng: 4),
        ],
        [
          (lat: 1, lng: 1),
          (lat: 3, lng: 1),
          (lat: 3, lng: 3),
          (lat: 1, lng: 3),
        ],
      )..polygonDifference();

      expect(binary.pDiffPolygons, hasLength(2));
      expect(
        _signedArea(binary.pDiffPolygons[0]) +
            _signedArea(binary.pDiffPolygons[1]),
        closeTo(12, 0.000001),
      );
    },
  );

  test('polygon difference handles disjoint and fully covered polygons', () {
    final binary = VPolBinary.runInit(
      [(lat: 0, lng: 0), (lat: 4, lng: 0), (lat: 4, lng: 4), (lat: 0, lng: 4)],
      [(lat: 5, lng: 5), (lat: 6, lng: 5), (lat: 6, lng: 6), (lat: 5, lng: 6)],
    )..polygonDifference();
    expect(binary.pDiffPolygons, hasLength(1));
    expect(_signedArea(binary.pDiff), closeTo(16, 0.000001));

    binary
      ..runInit(
        [
          (lat: 0, lng: 0),
          (lat: 4, lng: 0),
          (lat: 4, lng: 4),
          (lat: 0, lng: 4),
        ],
        [
          (lat: -1, lng: -1),
          (lat: 5, lng: -1),
          (lat: 5, lng: 5),
          (lat: -1, lng: 5),
        ],
      )
      ..polygonDifference();
    expect(binary.pDiffPolygons, isEmpty);
    expect(binary.pDiff.points, isEmpty);
  });

  test('polygon union joins overlapping boundaries at intersections', () {
    final binary = VPolBinary.runInit(
      [(lat: 0, lng: 0), (lat: 4, lng: 0), (lat: 4, lng: 4), (lat: 0, lng: 4)],
      [
        (lat: 2, lng: -1),
        (lat: 5, lng: -1),
        (lat: 5, lng: 3),
        (lat: 2, lng: 3),
      ],
    )..polygonUnion();

    expect(binary.pUnPolygons, hasLength(1));
    expect(_signedArea(binary.pUn), closeTo(22, 0.000001));
  });

  test('polygon union handles containment and disjoint polygons', () {
    final binary = VPolBinary.runInit(
      [(lat: 0, lng: 0), (lat: 4, lng: 0), (lat: 4, lng: 4), (lat: 0, lng: 4)],
      [(lat: 1, lng: 1), (lat: 3, lng: 1), (lat: 3, lng: 3), (lat: 1, lng: 3)],
    )..polygonUnion();

    expect(binary.pUnPolygons, hasLength(1));
    expect(_signedArea(binary.pUn), closeTo(16, 0.000001));

    binary
      ..runInit(
        [
          (lat: 0, lng: 0),
          (lat: 4, lng: 0),
          (lat: 4, lng: 4),
          (lat: 0, lng: 4),
        ],
        [
          (lat: 5, lng: 5),
          (lat: 6, lng: 5),
          (lat: 6, lng: 6),
          (lat: 5, lng: 6),
        ],
      )
      ..polygonUnion();

    expect(binary.pUnPolygons, hasLength(2));
    expect(
      binary.pUnPolygons.fold<double>(0, (area, polygon) {
        return area + _signedArea(polygon);
      }),
      closeTo(17, 0.000001),
    );
  });
}

double _signedArea(VPolygon polygon) {
  var area = 0.0;
  for (int i = 0; i < polygon.points.length; i++) {
    final current = polygon.points[i];
    final next = polygon.points[(i + 1) % polygon.points.length];
    area += current.lat * next.lng - next.lat * current.lng;
  }
  return area / 2;
}
