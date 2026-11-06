import 'package:flutter_test/flutter_test.dart';
import 'package:veevin_maps_polygon/pol_binary.dart';

void main() {
  // Test cases for polygon binary operations
  test('polygon difference cross 1 - new lower left', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: 5.0, lng: 5.0),
      (lat: 15.0, lng: 5.0),
      (lat: 15.0, lng: 15.0),
      (lat: 5.0, lng: 15.0),
    ];
    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(6));

    expect(diffPoly[0].lat, equals(0.0));
    expect(diffPoly[0].lng, equals(0.0));

    expect(diffPoly[1].lat, equals(10.0));
    expect(diffPoly[1].lng, equals(0.0));

    expect(diffPoly[2].lat, equals(10.0));
    expect(diffPoly[2].lng, equals(5.0));

    expect(diffPoly[3].lat, equals(5.0));
    expect(diffPoly[3].lng, equals(5.0));

    expect(diffPoly[4].lat, equals(5.0));
    expect(diffPoly[4].lng, equals(10.0));

    expect(diffPoly[5].lat, equals(0.0));
    expect(diffPoly[5].lng, equals(10.0));
  });

  //
  // error must start with 5,10
  test('polygon difference cross 2 - new upper right', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: 5.0, lng: 5.0),
      (lat: 15.0, lng: 5.0),
      (lat: 15.0, lng: 15.0),
      (lat: 5.0, lng: 15.0),
    ];

    List<({double lat, double lng})> polygonOld = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(6));

    expect(diffPoly[0].lat, equals(10.0));
    expect(diffPoly[0].lng, equals(5.0));

    expect(diffPoly[1].lat, equals(15.0));
    expect(diffPoly[1].lng, equals(5.0));

    expect(diffPoly[2].lat, equals(15.0));
    expect(diffPoly[2].lng, equals(15.0));

    expect(diffPoly[3].lat, equals(5.0));
    expect(diffPoly[3].lng, equals(15.0));

    expect(diffPoly[4].lat, equals(5.0));
    expect(diffPoly[4].lng, equals(10.0));

    expect(diffPoly[5].lat, equals(10.0));
    expect(diffPoly[5].lng, equals(10.0));
  });

  test('polygon difference cross 3 - new lower right', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: -5.0, lng: 5.0),
      (lat: 5.0, lng: 5.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(6));

    expect(diffPoly[0].lat, equals(0.0));
    expect(diffPoly[0].lng, equals(0.0));

    expect(diffPoly[1].lat, equals(10.0));
    expect(diffPoly[1].lng, equals(0.0));

    expect(diffPoly[2].lat, equals(10.0));
    expect(diffPoly[2].lng, equals(10.0));

    expect(diffPoly[3].lat, equals(5.0));
    expect(diffPoly[3].lng, equals(10.0));

    expect(diffPoly[4].lat, equals(5.0));
    expect(diffPoly[4].lng, equals(5.0));

    expect(diffPoly[5].lat, equals(-0.0));
    expect(diffPoly[5].lng, equals(5.0));
  });

  test('polygon difference cross 4 - new lower left', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: -5.0, lng: 5.0),
      (lat: 5.0, lng: 5.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(6));

    expect(diffPoly[0].lat, equals(-5.0));
    expect(diffPoly[0].lng, equals(5.0));

    expect(diffPoly[1].lat, equals(0.0));
    expect(diffPoly[1].lng, equals(5.0));

    expect(diffPoly[2].lat, equals(0.0));
    expect(diffPoly[2].lng, equals(10.0));

    expect(diffPoly[3].lat, equals(5.0));
    expect(diffPoly[3].lng, equals(10.0));

    expect(diffPoly[4].lat, equals(5.0));
    expect(diffPoly[4].lng, equals(15.0));

    expect(diffPoly[5].lat, equals(-5.0));
    expect(diffPoly[5].lng, equals(15.0));
  });

  test('polygon difference cross 5 - new lower right', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: -5.0, lng: 5.0),
      (lat: 5.0, lng: 5.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(6));

    expect(diffPoly[0].lat, equals(0.0));
    expect(diffPoly[0].lng, equals(0.0));

    expect(diffPoly[1].lat, equals(10.0));
    expect(diffPoly[1].lng, equals(0.0));

    expect(diffPoly[2].lat, equals(10.0));
    expect(diffPoly[2].lng, equals(10.0));

    expect(diffPoly[3].lat, equals(5.0));
    expect(diffPoly[3].lng, equals(10.0));

    expect(diffPoly[4].lat, equals(5.0));
    expect(diffPoly[4].lng, equals(5.0));

    expect(diffPoly[5].lat, equals(-0.0));
    expect(diffPoly[5].lng, equals(5.0));
  });

  test('polygon difference corner touch - new lower left', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: -10.0, lng: -10.0),
      (lat: 0.0, lng: -10.0),
      (lat: 0.0, lng: 0.0),
      (lat: -10.0, lng: 0.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);
    expect(diffPoly.length, equals(4));

    expect(diffPoly[0].lat, equals(-10.0));
    expect(diffPoly[0].lng, equals(-10.0));

    expect(diffPoly[1].lat, equals(0.0));
    expect(diffPoly[1].lng, equals(-10.0));

    expect(diffPoly[2].lat, equals(0.0));
    expect(diffPoly[2].lng, equals(0.0));

    expect(diffPoly[3].lat, equals(-10.0));
    expect(diffPoly[3].lng, equals(0.0));
  });

  test('polygon difference corner touch - new upper right', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: -10.0, lng: -10.0),
      (lat: 0.0, lng: -10.0),
      (lat: 0.0, lng: 0.0),
      (lat: -10.0, lng: 0.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(4));

    expect(diffPoly[0].lat, equals(0.0));
    expect(diffPoly[0].lng, equals(0.0));

    expect(diffPoly[1].lat, equals(10.0));
    expect(diffPoly[1].lng, equals(0.0));

    expect(diffPoly[2].lat, equals(10.0));
    expect(diffPoly[2].lng, equals(10.0));

    expect(diffPoly[3].lat, equals(0.0));
    expect(diffPoly[3].lng, equals(10.0));
  });

  test('polygon difference edge touch - new upper right', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: -5.0, lng: -10.0),
      (lat: 5.0, lng: -10.0),
      (lat: 5.0, lng: 0.0),
      (lat: -5.0, lng: 0.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);
    expect(diffPoly.length, equals(5));

    expect(diffPoly[0].lat, equals(5.0));
    expect(diffPoly[0].lng, equals(0.0));

    expect(diffPoly[1].lat, equals(10.0));
    expect(diffPoly[1].lng, equals(0.0));

    expect(diffPoly[2].lat, equals(10.0));
    expect(diffPoly[2].lng, equals(10.0));

    expect(diffPoly[3].lat, equals(0.0));
    expect(diffPoly[3].lng, equals(10.0));

    expect(diffPoly[4].lat, equals(0.0));
    expect(diffPoly[4].lng, equals(0.0));
  });

  test('polygon difference edge touch - new lower left', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: -5.0, lng: -10.0),
      (lat: 5.0, lng: -10.0),
      (lat: 5.0, lng: 0.0),
      (lat: -5.0, lng: 0.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);
    expect(diffPoly.length, equals(5));

    expect(diffPoly[0].lat, equals(-5.0));
    expect(diffPoly[0].lng, equals(-10.0));

    expect(diffPoly[1].lat, equals(5.0));
    expect(diffPoly[1].lng, equals(-10.0));

    expect(diffPoly[2].lat, equals(5.0));
    expect(diffPoly[2].lng, equals(0.0));

    expect(diffPoly[3].lat, equals(0.0));
    expect(diffPoly[3].lng, equals(0.0));

    expect(diffPoly[4].lat, equals(-5.0));
    expect(diffPoly[4].lng, equals(0.0));
  });

  test('polygon difference edge touch - new lower right', () {
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonOld = [
      (lat: 5.0, lng: 10.0),
      (lat: 15.0, lng: 10.0),
      (lat: 15.0, lng: 20.0),
      (lat: 5.0, lng: 20.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonNew, polygonOld);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);
    expect(diffPoly.length, equals(5));

    expect(diffPoly[0].lat, equals(0.0));
    expect(diffPoly[0].lng, equals(0.0));

    expect(diffPoly[1].lat, equals(10.0));
    expect(diffPoly[1].lng, equals(0.0));

    expect(diffPoly[2].lat, equals(10.0));
    expect(diffPoly[2].lng, equals(10.0));

    expect(diffPoly[3].lat, equals(5.0));
    expect(diffPoly[3].lng, equals(10.0));

    expect(diffPoly[4].lat, equals(0.0));
    expect(diffPoly[4].lng, equals(10.0));
  });

  test('polygon difference cut across 1 - new left', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: -5.0, lng: -5.0),
      (lat: 5.0, lng: -5.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(4));

    expect(diffPoly[0].lat, equals(5.0));
    expect(diffPoly[0].lng, equals(0.0));

    expect(diffPoly[1].lat, equals(10.0));
    expect(diffPoly[1].lng, equals(0.0));

    expect(diffPoly[2].lat, equals(10.0));
    expect(diffPoly[2].lng, equals(10.0));

    expect(diffPoly[3].lat, equals(5.0));
    expect(diffPoly[3].lng, equals(10.0));
  });

  test('polygon difference cut across 2 - new right', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 5.0, lng: -5.0),
      (lat: 15.0, lng: -5.0),
      (lat: 15.0, lng: 15.0),
      (lat: 5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(4));

    expect(diffPoly[0].lat, equals(0.0));
    expect(diffPoly[0].lng, equals(0.0));

    expect(diffPoly[1].lat, equals(5.0));
    expect(diffPoly[1].lng, equals(0.0));

    expect(diffPoly[2].lat, equals(5.0));
    expect(diffPoly[2].lng, equals(10.0));

    expect(diffPoly[3].lat, equals(0.0));
    expect(diffPoly[3].lng, equals(10.0));
  });

  test('polygon difference - new completely outside', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: -5.0, lng: -5.0),
      (lat: 15.0, lng: -5.0),
      (lat: 15.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonDifference();
    expect(binary.pDiffPolygons.length, equals(0));
  });

  test('polygon difference - new completely inside', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: -5.0, lng: -5.0),
      (lat: 15.0, lng: -5.0),
      (lat: 15.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    var diffPoly = binary.pDiffPolygons[0].pointsLatLng;
    print(diffPoly);

    expect(diffPoly.length, equals(4));

    expect(diffPoly[0].lat, equals(-5.0));
    expect(diffPoly[0].lng, equals(-5.0));

    expect(diffPoly[1].lat, equals(15.0));
    expect(diffPoly[1].lng, equals(-5.0));

    expect(diffPoly[2].lat, equals(15.0));
    expect(diffPoly[2].lng, equals(15.0));

    expect(diffPoly[3].lat, equals(-5.0));
    expect(diffPoly[3].lng, equals(15.0));
  });

  test('(original partitioned, new polygon not points completely outside', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 3.0, lng: -5.0),
      (lat: 6.0, lng: -5.0),
      (lat: 6.0, lng: 15.0),
      (lat: 3.0, lng: 15.0),
      (lat: 3.0, lng: 7.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonDifference();
    binary.pDiffPolygons[0].getPolygonLatLng();
    binary.pDiffPolygons[1].getPolygonLatLng();
    var diffPoly0 = binary.pDiffPolygons[0].pointsLatLng;
    var diffPoly1 = binary.pDiffPolygons[1].pointsLatLng;
    print(diffPoly0);
    print(diffPoly1);

    expect(diffPoly0.length, equals(5));
    expect(diffPoly1.length, equals(4));

    expect(diffPoly0[0].lat, equals(0.0));
    expect(diffPoly0[0].lng, equals(0.0));

    expect(diffPoly0[1].lat, equals(3.0));
    expect(diffPoly0[1].lng, equals(0.0));

    expect(diffPoly0[2].lat, equals(3.0));
    expect(diffPoly0[2].lng, equals(7.0));

    expect(diffPoly0[3].lat, equals(3.0));
    expect(diffPoly0[3].lng, equals(10.0));

    expect(diffPoly0[4].lat, equals(0.0));
    expect(diffPoly0[4].lng, equals(10.0));

    expect(diffPoly1[0].lat, equals(6.0));
    expect(diffPoly1[0].lng, equals(0.0));

    expect(diffPoly1[1].lat, equals(10.0));
    expect(diffPoly1[1].lng, equals(0.0));

    expect(diffPoly1[2].lat, equals(10.0));
    expect(diffPoly1[2].lng, equals(10.0));

    expect(diffPoly1[3].lat, equals(6.0));
    expect(diffPoly1[3].lng, equals(10.0));
  });

  test(
    'original partitioned, difference new polygon points completely outside',
    () {
      List<({double lat, double lng})> polygonOriginal = [
        (lat: 0.0, lng: 0.0),
        (lat: 10.0, lng: 0.0),
        (lat: 10.0, lng: 10.0),
        (lat: 0.0, lng: 10.0),
      ];
      List<({double lat, double lng})> polygonNew = [
        (lat: 3.0, lng: -5.0),
        (lat: 6.0, lng: -5.0),
        (lat: 6.0, lng: 15.0),
        (lat: 3.0, lng: 15.0),
      ];

      VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
      binary.polygonDifference();
      binary.pDiffPolygons[0].getPolygonLatLng();
      binary.pDiffPolygons[1].getPolygonLatLng();
      var diffPoly0 = binary.pDiffPolygons[0].pointsLatLng;
      var diffPoly1 = binary.pDiffPolygons[1].pointsLatLng;
      print(diffPoly0);
      print(diffPoly1);

      expect(diffPoly0.length, equals(4));
      expect(diffPoly1.length, equals(4));

      expect(diffPoly0[0].lat, equals(0.0));
      expect(diffPoly0[0].lng, equals(0.0));

      expect(diffPoly0[1].lat, equals(3.0));
      expect(diffPoly0[1].lng, equals(0.0));

      expect(diffPoly0[2].lat, equals(3.0));
      expect(diffPoly0[2].lng, equals(10.0));

      expect(diffPoly0[3].lat, equals(0.0));
      expect(diffPoly0[3].lng, equals(10.0));

      expect(diffPoly1[0].lat, equals(6.0));
      expect(diffPoly1[0].lng, equals(0.0));

      expect(diffPoly1[1].lat, equals(10.0));
      expect(diffPoly1[1].lng, equals(0.0));

      expect(diffPoly1[2].lat, equals(10.0));
      expect(diffPoly1[2].lng, equals(10.0));

      expect(diffPoly1[3].lat, equals(6.0));
      expect(diffPoly1[3].lng, equals(10.0));
    },
  );

  test('polygon overlap cross 1 - new upper right', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 5.0, lng: 5.0),
      (lat: 15.0, lng: 5.0),
      (lat: 15.0, lng: 15.0),
      (lat: 5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(8));

    expect(unPoly[0].lat, equals(0.0));
    expect(unPoly[0].lng, equals(0.0));

    expect(unPoly[1].lat, equals(10.0));
    expect(unPoly[1].lng, equals(0.0));

    expect(unPoly[2].lat, equals(10.0));
    expect(unPoly[2].lng, equals(5.0));

    expect(unPoly[3].lat, equals(15.0));
    expect(unPoly[3].lng, equals(5.0));

    expect(unPoly[4].lat, equals(15.0));
    expect(unPoly[4].lng, equals(15.0));

    expect(unPoly[5].lat, equals(5.0));
    expect(unPoly[5].lng, equals(15.0));

    expect(unPoly[6].lat, equals(5.0));
    expect(unPoly[6].lng, equals(10.0));

    expect(unPoly[7].lat, equals(0.0));
    expect(unPoly[7].lng, equals(10.0));
  });

  test('polygon overlapp cross 2 - new lower left', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 5.0, lng: 5.0),
      (lat: 15.0, lng: 5.0),
      (lat: 15.0, lng: 15.0),
      (lat: 5.0, lng: 15.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(8));

    expect(unPoly[0].lat, equals(10.0));
    expect(unPoly[0].lng, equals(5.0));

    expect(unPoly[1].lat, equals(15.0));
    expect(unPoly[1].lng, equals(5.0));

    expect(unPoly[2].lat, equals(15.0));
    expect(unPoly[2].lng, equals(15.0));

    expect(unPoly[3].lat, equals(5.0));
    expect(unPoly[3].lng, equals(15.0));

    expect(unPoly[4].lat, equals(5.0));
    expect(unPoly[4].lng, equals(10.0));

    expect(unPoly[5].lat, equals(0.0));
    expect(unPoly[5].lng, equals(10.0));

    expect(unPoly[6].lat, equals(0.0));
    expect(unPoly[6].lng, equals(0.0));

    expect(unPoly[7].lat, equals(10.0));
    expect(unPoly[7].lng, equals(0.0));
  });

  test('polygon overlapp cross 3 - new lower right', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: -5.0, lng: 5.0),
      (lat: 5.0, lng: 5.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(8));

    expect(unPoly[0].lat, equals(-5.0));
    expect(unPoly[0].lng, equals(5.0));

    expect(unPoly[1].lat, equals(0.0));
    expect(unPoly[1].lng, equals(5.0));

    expect(unPoly[2].lat, equals(0.0));
    expect(unPoly[2].lng, equals(0.0));

    expect(unPoly[3].lat, equals(10.0));
    expect(unPoly[3].lng, equals(0.0));

    expect(unPoly[4].lat, equals(10.0));
    expect(unPoly[4].lng, equals(10.0));

    expect(unPoly[5].lat, equals(5.0));
    expect(unPoly[5].lng, equals(10.0));

    expect(unPoly[6].lat, equals(5.0));
    expect(unPoly[6].lng, equals(15.0));

    expect(unPoly[7].lat, equals(-5.0));
    expect(unPoly[7].lng, equals(15.0));
  });

  test('polygon overlapp cross 4 - new upper left', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: -5.0, lng: 5.0),
      (lat: 5.0, lng: 5.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(8));

    expect(unPoly[0].lat, equals(0.0));
    expect(unPoly[0].lng, equals(0.0));

    expect(unPoly[1].lat, equals(10.0));
    expect(unPoly[1].lng, equals(0.0));

    expect(unPoly[2].lat, equals(10.0));
    expect(unPoly[2].lng, equals(10.0));

    expect(unPoly[3].lat, equals(5.0));
    expect(unPoly[3].lng, equals(10.0));

    expect(unPoly[4].lat, equals(5.0));
    expect(unPoly[4].lng, equals(15.0));

    expect(unPoly[5].lat, equals(-5.0));
    expect(unPoly[5].lng, equals(15.0));

    expect(unPoly[6].lat, equals(-5.0));
    expect(unPoly[6].lng, equals(5.0));

    expect(unPoly[7].lat, equals(0.0));
    expect(unPoly[7].lng, equals(5.0));
  });

  test('polygon overlap cut across 1 - new left', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: -5.0, lng: -5.0),
      (lat: 5.0, lng: -5.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(8));

    expect(unPoly[0].lat, equals(5.0));
    expect(unPoly[0].lng, equals(0.0));

    expect(unPoly[1].lat, equals(10.0));
    expect(unPoly[1].lng, equals(0.0));

    expect(unPoly[2].lat, equals(10.0));
    expect(unPoly[2].lng, equals(10.0));

    expect(unPoly[3].lat, equals(5.0));
    expect(unPoly[3].lng, equals(10.0));

    expect(unPoly[4].lat, equals(5.0));
    expect(unPoly[4].lng, equals(15.0));

    expect(unPoly[5].lat, equals(-5.0));
    expect(unPoly[5].lng, equals(15.0));

    expect(unPoly[6].lat, equals(-5.0));
    expect(unPoly[6].lng, equals(-5.0));

    expect(unPoly[7].lat, equals(5.0));
    expect(unPoly[7].lng, equals(-5.0));
  });

  test('polygon overlap cut across 2 - new right', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 5.0, lng: -5.0),
      (lat: 15.0, lng: -5.0),
      (lat: 15.0, lng: 15.0),
      (lat: 5.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(8));

    expect(unPoly[0].lat, equals(0.0));
    expect(unPoly[0].lng, equals(0.0));

    expect(unPoly[1].lat, equals(5.0));
    expect(unPoly[1].lng, equals(0.0));

    expect(unPoly[2].lat, equals(5.0));
    expect(unPoly[2].lng, equals(-5.0));

    expect(unPoly[3].lat, equals(15.0));
    expect(unPoly[3].lng, equals(-5.0));

    expect(unPoly[4].lat, equals(15.0));
    expect(unPoly[4].lng, equals(15.0));

    expect(unPoly[5].lat, equals(5.0));
    expect(unPoly[5].lng, equals(15.0));

    expect(unPoly[6].lat, equals(5.0));
    expect(unPoly[6].lng, equals(10.0));

    expect(unPoly[7].lat, equals(0.0));
    expect(unPoly[7].lng, equals(10.0));
  });

  test('polygon edge touch 1 - new upper left', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: -10.0, lng: 5.0),
      (lat: 0.0, lng: 5.0),
      (lat: 0.0, lng: 15.0),
      (lat: -10.0, lng: 15.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(8));

    expect(unPoly[0].lat, equals(0.0));
    expect(unPoly[0].lng, equals(0.0));

    expect(unPoly[1].lat, equals(10.0));
    expect(unPoly[1].lng, equals(0.0));

    expect(unPoly[2].lat, equals(10.0));
    expect(unPoly[2].lng, equals(10.0));

    expect(unPoly[3].lat, equals(0.0));
    expect(unPoly[3].lng, equals(10.0));

    expect(unPoly[4].lat, equals(0.0));
    expect(unPoly[4].lng, equals(15.0));

    expect(unPoly[5].lat, equals(-10.0));
    expect(unPoly[5].lng, equals(15.0));

    expect(unPoly[6].lat, equals(-10.0));
    expect(unPoly[6].lng, equals(5.0));

    expect(unPoly[7].lat, equals(0.0));
    expect(unPoly[7].lng, equals(5.0));
  });

  test('polygon edge touch 2 - new lower right', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: -10.0, lng: 5.0),
      (lat: 0.0, lng: 5.0),
      (lat: 0.0, lng: 15.0),
      (lat: -10.0, lng: 15.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(8));

    expect(unPoly[0].lat, equals(-10.0));
    expect(unPoly[0].lng, equals(5.0));

    expect(unPoly[1].lat, equals(0.0));
    expect(unPoly[1].lng, equals(5.0));

    expect(unPoly[2].lat, equals(0.0));
    expect(unPoly[2].lng, equals(0.0));

    expect(unPoly[3].lat, equals(10.0));
    expect(unPoly[3].lng, equals(0.0));

    expect(unPoly[4].lat, equals(10.0));
    expect(unPoly[4].lng, equals(10.0));

    expect(unPoly[5].lat, equals(0.0));
    expect(unPoly[5].lng, equals(10.0));

    expect(unPoly[6].lat, equals(0.0));
    expect(unPoly[6].lng, equals(15.0));

    expect(unPoly[7].lat, equals(-10.0));
    expect(unPoly[7].lng, equals(15.0));
  });

  //test failed
  test('polygon corner touch - new upper right', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 10.0, lng: 10.0),
      (lat: 20.0, lng: 10.0),
      (lat: 20.0, lng: 20.0),
      (lat: 10.0, lng: 20.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    binary.pUnPolygons[1].getPolygonLatLng();
    expect(binary.pUnPolygons.length, equals(2));
    var unPoly1 = binary.pUnPolygons[0].pointsLatLng;
    var unPoly2 = binary.pUnPolygons[1].pointsLatLng;
    print(unPoly1);
    print(unPoly2);

    expect(unPoly1.length, equals(4));
    expect(unPoly2.length, equals(4));

    expect(unPoly1[0].lat, equals(0.0));
    expect(unPoly1[0].lng, equals(0.0));

    expect(unPoly1[1].lat, equals(10.0));
    expect(unPoly1[1].lng, equals(0.0));

    expect(unPoly1[2].lat, equals(10.0));
    expect(unPoly1[2].lng, equals(10.0));

    expect(unPoly1[3].lat, equals(0.0));
    expect(unPoly1[3].lng, equals(10.0));

    expect(unPoly2[0].lat, equals(10.0));
    expect(unPoly2[0].lng, equals(10.0));

    expect(unPoly2[1].lat, equals(20.0));
    expect(unPoly2[1].lng, equals(10.0));

    expect(unPoly2[2].lat, equals(20.0));
    expect(unPoly2[2].lng, equals(20.0));

    expect(unPoly2[3].lat, equals(10.0));
    expect(unPoly2[3].lng, equals(20.0));
  });

  test('polygon corner touch - new lower left', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 10.0, lng: 10.0),
      (lat: 20.0, lng: 10.0),
      (lat: 20.0, lng: 20.0),
      (lat: 10.0, lng: 20.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    binary.pUnPolygons[1].getPolygonLatLng();
    expect(binary.pUnPolygons.length, equals(2));
    var unPoly2 = binary.pUnPolygons[0].pointsLatLng;
    var unPoly1 = binary.pUnPolygons[1].pointsLatLng;
    print(unPoly1);
    print(unPoly2);

    expect(unPoly1.length, equals(4));
    expect(unPoly2.length, equals(4));

    expect(unPoly1[0].lat, equals(0.0));
    expect(unPoly1[0].lng, equals(0.0));

    expect(unPoly1[1].lat, equals(10.0));
    expect(unPoly1[1].lng, equals(0.0));

    expect(unPoly1[2].lat, equals(10.0));
    expect(unPoly1[2].lng, equals(10.0));

    expect(unPoly1[3].lat, equals(0.0));
    expect(unPoly1[3].lng, equals(10.0));

    expect(unPoly2[0].lat, equals(10.0));
    expect(unPoly2[0].lng, equals(10.0));

    expect(unPoly2[1].lat, equals(20.0));
    expect(unPoly2[1].lng, equals(10.0));

    expect(unPoly2[2].lat, equals(20.0));
    expect(unPoly2[2].lng, equals(20.0));

    expect(unPoly2[3].lat, equals(10.0));
    expect(unPoly2[3].lng, equals(20.0));
  });

  test('polygon overlap 1', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    List<({double lat, double lng})> polygonNew = [
      (lat: -5.0, lng: -5.0),
      (lat: 5.0, lng: -5.0),
      (lat: 5.0, lng: 3.0),
      (lat: 7.0, lng: 3.0),
      (lat: 7.0, lng: -5.0),
      (lat: 15.0, lng: -5.0),
      (lat: 15.0, lng: 15.0),
      (lat: 7.0, lng: 15.0),
      (lat: 7.0, lng: 7.0),
      (lat: 5.0, lng: 7.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];
    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    expect(binary.pUnPolygons.length, equals(1));
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(12));

    expect(unPoly[0].lat, equals(5.0));
    expect(unPoly[0].lng, equals(-0.0));

    expect(unPoly[1].lat, equals(7.0));
    expect(unPoly[1].lng, equals(0.0));

    expect(unPoly[2].lat, equals(7.0));
    expect(unPoly[2].lng, equals(-5.0));

    expect(unPoly[3].lat, equals(15.0));
    expect(unPoly[3].lng, equals(-5.0));

    expect(unPoly[4].lat, equals(15.0));
    expect(unPoly[4].lng, equals(15.0));

    expect(unPoly[5].lat, equals(7.0));
    expect(unPoly[5].lng, equals(15.0));

    expect(unPoly[6].lat, equals(7.0));
    expect(unPoly[6].lng, equals(10.0));

    expect(unPoly[7].lat, equals(5.0));
    expect(unPoly[7].lng, equals(10.0));

    expect(unPoly[8].lat, equals(5.0));
    expect(unPoly[8].lng, equals(15.0));

    expect(unPoly[9].lat, equals(-5.0));
    expect(unPoly[9].lng, equals(15.0));

    expect(unPoly[10].lat, equals(-5.0));
    expect(unPoly[10].lng, equals(-5.0));

    expect(unPoly[11].lat, equals(5.0));
    expect(unPoly[11].lng, equals(-5.0));
  });

  test('polygon overlap 2', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: -5.0, lng: -5.0),
      (lat: 5.0, lng: -5.0),
      (lat: 5.0, lng: 3.0),
      (lat: 7.0, lng: 3.0),
      (lat: 7.0, lng: -5.0),
      (lat: 15.0, lng: -5.0),
      (lat: 15.0, lng: 15.0),
      (lat: 7.0, lng: 15.0),
      (lat: 7.0, lng: 7.0),
      (lat: 5.0, lng: 7.0),
      (lat: 5.0, lng: 15.0),
      (lat: -5.0, lng: 15.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(12));

    expect(unPoly[0].lat, equals(-5.0));
    expect(unPoly[0].lng, equals(-5.0));

    expect(unPoly[1].lat, equals(5.0));
    expect(unPoly[1].lng, equals(-5.0));

    expect(unPoly[2].lat, equals(5.0));
    expect(unPoly[2].lng, equals(0.0));

    expect(unPoly[3].lat, equals(7.0));
    expect(unPoly[3].lng, equals(0.0));

    expect(unPoly[4].lat, equals(7.0));
    expect(unPoly[4].lng, equals(-5.0));

    expect(unPoly[5].lat, equals(15.0));
    expect(unPoly[5].lng, equals(-5.0));

    expect(unPoly[6].lat, equals(15.0));
    expect(unPoly[6].lng, equals(15.0));

    expect(unPoly[7].lat, equals(7.0));
    expect(unPoly[7].lng, equals(15.0));

    expect(unPoly[8].lat, equals(7.0));
    expect(unPoly[8].lng, equals(10.0));

    expect(unPoly[9].lat, equals(5.0));
    expect(unPoly[9].lng, equals(10.0));

    expect(unPoly[10].lat, equals(5.0));
    expect(unPoly[10].lng, equals(15.0));

    expect(unPoly[11].lat, equals(-5.0));
    expect(unPoly[11].lng, equals(15.0));
  });

  test('original partitioned, difference new polygon points completely outside, overlap', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 0.0, lng: 0.0),
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
    ];
    List<({double lat, double lng})> polygonNew = [
      (lat: 6.0, lng: -5.0),
      (lat: 6.0, lng: 15.0),
      (lat: 3.0, lng: 15.0),
      (lat: 3.0, lng: -5.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    expect(binary.pUnPolygons.length, equals(1));
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(12));

    expect(unPoly[0].lat, equals(0.0));
    expect(unPoly[0].lng, equals(0.0));

    expect(unPoly[1].lat, equals(3.0));
    expect(unPoly[1].lng, equals(-0.0));

    expect(unPoly[2].lat, equals(3.0));
    expect(unPoly[2].lng, equals(-5.0));

    expect(unPoly[3].lat, equals(6.0));
    expect(unPoly[3].lng, equals(-5.0));

    expect(unPoly[4].lat, equals(6.0));
    expect(unPoly[4].lng, equals(-0.0));

    expect(unPoly[5].lat, equals(10.0));
    expect(unPoly[5].lng, equals(0.0));

    expect(unPoly[6].lat, equals(10.0));
    expect(unPoly[6].lng, equals(10.0));

    expect(unPoly[7].lat, equals(6.0));
    expect(unPoly[7].lng, equals(10.0));

    expect(unPoly[8].lat, equals(6.0));
    expect(unPoly[8].lng, equals(15.0));

    expect(unPoly[9].lat, equals(3.0));
    expect(unPoly[9].lng, equals(15.0));

    expect(unPoly[10].lat, equals(3.0));
    expect(unPoly[10].lng, equals(10.0));

    expect(unPoly[11].lat, equals(0.0));
    expect(unPoly[11].lng, equals(10.0));
  });

  test('original partitioned, difference new polygon points completely outside, overlap', () {
    List<({double lat, double lng})> polygonOriginal = [
      (lat: 3.0, lng: -5.0),
      (lat: 6.0, lng: -5.0),
      (lat: 6.0, lng: 15.0),
      (lat: 3.0, lng: 15.0),
    ];

    List<({double lat, double lng})> polygonNew = [
      (lat: 10.0, lng: 0.0),
      (lat: 10.0, lng: 10.0),
      (lat: 0.0, lng: 10.0),
      (lat: 0.0, lng: 0.0),
    ];

    VPolBinary binary = VPolBinary.runInit(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unPoly = binary.pUnPolygons[0].pointsLatLng;
    print(unPoly);

    expect(unPoly.length, equals(12));

    expect(unPoly[0].lat, equals(3.0));
    expect(unPoly[0].lng, equals(-5.0));

    expect(unPoly[1].lat, equals(6.0));
    expect(unPoly[1].lng, equals(-5.0));

    expect(unPoly[2].lat, equals(6.0));
    expect(unPoly[2].lng, equals(0.0));

    expect(unPoly[3].lat, equals(10.0));
    expect(unPoly[3].lng, equals(0.0));

    expect(unPoly[4].lat, equals(10.0));
    expect(unPoly[4].lng, equals(10.0));

    expect(unPoly[5].lat, equals(6.0));
    expect(unPoly[5].lng, equals(10.0));

    expect(unPoly[6].lat, equals(6.0));
    expect(unPoly[6].lng, equals(15.0));

    expect(unPoly[7].lat, equals(3.0));
    expect(unPoly[7].lng, equals(15.0));

    expect(unPoly[8].lat, equals(3.0));
    expect(unPoly[8].lng, equals(10.0));

    expect(unPoly[9].lat, equals(0.0));
    expect(unPoly[9].lng, equals(10.0));

    expect(unPoly[10].lat, equals(0.0));
    expect(unPoly[10].lng, equals(0.0));

    expect(unPoly[11].lat, equals(3.0));
    expect(unPoly[11].lng, equals(0.0));
  });
}
