<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

Polygon difference and union using floating point arithmetic. These are binary operations. Used for geo coordinates, with adjustible precision.

## Features

Polygon difference and union operations using floating point arithmetic. These are binary operations. Additional polygon functions to explore.

## Getting started

No prerequisites for this package. 

## Usage
Examples.
Polygon difference:
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

      VPolBinary binary = VPolBinary(polygonOriginal, polygonNew);
      binary.polygonDifference();
      binary.pDiffPolygons[0].getPolygonLatLng();
      binary.pDiffPolygons[1].getPolygonLatLng();
      var diffPoly0 = binary.pDiffPolygons[0].pointsLatLng;
      var diffPoly1 = binary.pDiffPolygons[1].pointsLatLng;

Polygon Union:
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

    VPolBinary binary = VPolBinary(polygonOriginal, polygonNew);
    binary.polygonUnion();
    binary.pUnPolygons[0].getPolygonLatLng();
    var unionPoly = binary.pUnPolygons[0].pointsLatLng;

## Additional information

For more information:
homepage: https://github.com/veevin/veevin_maps_polygon
email: <vikram.ramani@outlook.com>
