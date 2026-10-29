import 'package:flutter_test/flutter_test.dart';
import 'package:veevin_maps_polygon/point.dart';
import 'package:veevin_maps_polygon/pol_binary.dart';

void main() {
  test('test point', () {
    final point = VPoint();
    point.lat = 0.0;
    point.lng = 0.0;

    expect(point.lat, equals(0.0));
    expect(point.lng, equals(0.0));
  });

  test('polygon difference keeps the area of A outside overlapping B', () {
    final binary = VPolBinary(
      [(lat: 0, lng: 0), (lat: 4, lng: 0), (lat: 4, lng: 4), (lat: 0, lng: 4)],
      [
        (lat: 2, lng: -1),
        (lat: 5, lng: -1),
        (lat: 5, lng: 3),
        (lat: 2, lng: 3),
      ],
    )..polygonDifference();

    expect(binary.pDiffPolygons, hasLength(1));
    expect(binary.pDiffPolygons[0].pointsLatLng, hasLength(6));
    expect(binary.pDiffPolygons[0].pointsLatLng[0], equals((lat: 0, lng: 0)));
    expect(binary.pDiffPolygons[0].pointsLatLng[1], equals((lat: 2, lng: 0)));
    expect(binary.pDiffPolygons[0].pointsLatLng[2], equals((lat: 2, lng: 3)));
    expect(binary.pDiffPolygons[0].pointsLatLng[3], equals((lat: 4, lng: 3)));
    expect(binary.pDiffPolygons[0].pointsLatLng[4], equals((lat: 4, lng: 4)));
    expect(binary.pDiffPolygons[0].pointsLatLng[5], equals((lat: 0, lng: 4)));
  });

  test('get boundary segments 1', () {
    final binary = VPolBinary(
      [(lat: 0, lng: 0), (lat: 4, lng: 0), (lat: 4, lng: 4), (lat: 0, lng: 4)],
      [
        (lat: 2, lng: -1),
        (lat: 5, lng: -1),
        (lat: 5, lng: 3),
        (lat: 2, lng: 3),
      ],
    );

    final segments1 = <BoundarySegment>[
      ...binary.getBoundarySegments(binary.pA, binary.pB, keepInside: false),
    ];
    expect(segments1, hasLength(4));
    expect(segments1[0].start, equals((lat: 0, lng: 0)));
    expect(segments1[0].end, equals((lat: 2, lng: 0)));
    expect(segments1[1].start, equals((lat: 4, lng: 3)));
    expect(segments1[1].end, equals((lat: 4, lng: 4)));
    expect(segments1[2].start, equals((lat: 4, lng: 4)));
    expect(segments1[2].end, equals((lat: 0, lng: 4)));
    expect(segments1[3].start, equals((lat: 0, lng: 4)));
    expect(segments1[3].end, equals((lat: 0, lng: 0)));

    final segments2 = <BoundarySegment>[
      ...binary.getBoundarySegments(
        binary.pB,
        binary.pB,
        keepInside: true,
        reverse: true,
      ),
    ];
    expect(segments2, hasLength(6));
    expect(segments2[0].start, equals((lat: 5, lng: -1)));
    expect(segments2[0].end, equals((lat: 2, lng: -1)));
    expect(segments2[1].start, equals((lat: 5, lng: 3)));
    expect(segments2[1].end, equals((lat: 5, lng: -1)));
    expect(segments2[2].start, equals((lat: 4, lng: 3)));
    expect(segments2[2].end, equals((lat: 5, lng: 3)));
    expect(segments2[3].start, equals((lat: 2, lng: 3)));
    expect(segments2[3].end, equals((lat: 4, lng: 3)));
    expect(segments2[4].start, equals((lat: 2, lng: 0)));
    expect(segments2[4].end, equals((lat: 2, lng: 3)));
    expect(segments2[5].start, equals((lat: 2, lng: -1)));
    expect(segments2[5].end, equals((lat: 2, lng: 0)));

    final segments3 = <BoundarySegment>[
      ...binary.getBoundarySegments(
        binary.pB,
        binary.pB,
        keepInside: true,
        reverse: false,
      ),
    ];
    expect(segments3, hasLength(6));
    expect(segments3[0].start, equals((lat: 2, lng: -1)));
    expect(segments3[0].end, equals((lat: 5, lng: -1)));
    expect(segments3[1].start, equals((lat: 5, lng: -1)));
    expect(segments3[1].end, equals((lat: 5, lng: 3)));
    expect(segments3[2].start, equals((lat: 5, lng: 3)));
    expect(segments3[2].end, equals((lat: 4, lng: 3)));
    expect(segments3[3].start, equals((lat: 4, lng: 3)));
    expect(segments3[3].end, equals((lat: 2, lng: 3)));
    expect(segments3[4].start, equals((lat: 2, lng: 3)));
    expect(segments3[4].end, equals((lat: 2, lng: 0)));
    expect(segments3[5].start, equals((lat: 2, lng: 0)));
    expect(segments3[5].end, equals((lat: 2, lng: -1)));
  });
}
