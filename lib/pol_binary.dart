import 'package:veevin_maps_polygon/point.dart';
import 'package:veevin_maps_polygon/pol_bound_seg.dart';
import 'package:veevin_maps_polygon/pol_int_point.dart';
import 'package:veevin_maps_polygon/pol_point.dart';
import 'package:veevin_maps_polygon/polygon.dart';

class VPolBinary {
  double precision = 0.000000001;
  late VPolygon pA, pB;
  late VPolygon pDiff, pUn;

  /// Boundary rings for `A - B`; hole rings have opposite winding.
  List<VPolygon> pDiffPolygons = [];
  List<VPolygon> pUnPolygons = [];

  VPolBinary({double myPrecision = 0.000000001}) {
    setPrecision(myPrecision);
  }

  VPolBinary.runInit(
    List<({double lat, double lng})> pointsLatLngA,
    List<({double lat, double lng})> pointsLatLngB, {
    double myPrecision = 0.000000001,
  }) {
    setPrecision(myPrecision);
    runInit(pointsLatLngA, pointsLatLngB);
  }

  void setPrecision(double myPrecision) {
    precision = myPrecision;
  }

  void runInit(
    List<({double lat, double lng})> pointsLatLngA,
    List<({double lat, double lng})> pointsLatLngB,
  ) {
    pA = VPolygon();
    pB = VPolygon();
    pA.loadPolygon(pointsLatLngA);
    pB.loadPolygon(pointsLatLngB);
    pDiff = VPolygon();
    pUn = VPolygon();
    pDiffPolygons = [];
    pUnPolygons = [];
    polygonGetIntersectionPoints();
  }

  void polygonGetIntersectionPoints() {
    for (final point in pA.points) {
      point.next.iPoints.clear();
    }
    for (final point in pB.points) {
      point.next.iPoints.clear();
    }
    for (int i = 0; i < pA.points.length; i++) {
      final aEdge = pA.points[i].next;
      for (int j = 0; j < pB.points.length; j++) {
        final bEdge = pB.points[j].next;
        VPolIntPoint.getIntersectionPoint(aEdge, bEdge, myPrecision: precision);
      }
    }
  }

  //pA -pB
  // get difference polygon
  void polygonDifference() {
    final segments = <VPolBoundSeg>[
      ...getBoundarySegments(pA, pB, keepInside: false),
      ...getBoundarySegments(pB, pA, keepInside: true, reverse: true),
    ];
    pDiffPolygons = traceBoundaryRings(segments, operation: 'difference');
    pDiff = pDiffPolygons.isEmpty ? VPolygon() : pDiffPolygons.first;
  }

  List<VPolBoundSeg> getBoundarySegments(
    VPolygon polygon,
    VPolygon other, {
    required bool keepInside,
    bool reverse = false,
  }) {
    final segments = <VPolBoundSeg>[];
    for (final point in polygon.points) {
      final edge = point.next;
      final start = (lat: edge.start.lat, lng: edge.start.lng);
      final end = (lat: edge.end.lat, lng: edge.end.lng);
      final splitPoints =
          <({double lat, double lng})>[
            start,
            for (final intersection in edge.iPoints)
              if (intersection.isInside)
                (lat: intersection.lat, lng: intersection.lng),
            end,
          ]..sort(
            (a, b) => VPoint.getDistSquare(
              start,
              a,
            ).compareTo(VPoint.getDistSquare(start, b)),
          );

      final orderedPoints = <({double lat, double lng})>[];
      for (final splitPoint in splitPoints) {
        if (orderedPoints.isEmpty ||
            !VPoint.samePoint(
              orderedPoints.last,
              splitPoint,
              myPrecision: precision,
            )) {
          orderedPoints.add(splitPoint);
        }
      }

      for (int i = 0; i < orderedPoints.length - 1; i++) {
        final segmentStart = orderedPoints[i];
        final segmentEnd = orderedPoints[i + 1];
        final midpoint = (
          lat: (segmentStart.lat + segmentEnd.lat) / 2,
          lng: (segmentStart.lng + segmentEnd.lng) / 2,
        );
        final isInside = other.isPointInsideOrOnEdgePolygonVV(midpoint);
        if (isInside != keepInside) continue;

        segments.add(
          reverse
              ? VPolBoundSeg.fromNamedRec(
                  segmentEnd,
                  segmentStart,
                  myPrecision: precision,
                )
              : VPolBoundSeg.fromNamedRec(
                  segmentStart,
                  segmentEnd,
                  myPrecision: precision,
                ),
        );
      }
    }
    return segments;
  }

  List<VPolygon> traceBoundaryRings(
    List<VPolBoundSeg> segments, {
    required String operation,
  }) {
    final usedSegments = List<bool>.filled(segments.length, false);
    final polygons = <VPolygon>[];

    for (int i = 0; i < segments.length; i++) {
      if (usedSegments[i]) continue;

      final ring = <({double lat, double lng})>[
        segments[i].start.toLatLngRec(),
      ];
      var currentSegmentIndex = i;
      var isClosed = false;

      while (!usedSegments[currentSegmentIndex]) {
        final segment = segments[currentSegmentIndex];
        usedSegments[currentSegmentIndex] = true;
        if (VPoint.samePoint(
          segment.end.toLatLngRec(),
          ring.first,
          myPrecision: precision,
        )) {
          isClosed = true;
          break;
        }
        ring.add(segment.end.toLatLngRec());

        currentSegmentIndex = -1;
        for (
          int candidateIndex = 0;
          candidateIndex < segments.length;
          candidateIndex++
        ) {
          if (!usedSegments[candidateIndex] &&
              VPoint.samePoint(
                segments[candidateIndex].start.toLatLngRec(),
                segment.end.toLatLngRec(),
                myPrecision: precision,
              )) {
            currentSegmentIndex = candidateIndex;
            break;
          }
        }
        if (currentSegmentIndex == -1) {
          throw StateError('Polygon $operation produced an open boundary.');
        }
      }

      if (!isClosed) {
        throw StateError('Polygon $operation produced an open boundary.');
      }
      if (ring.length >= 3) {
        polygons.add(_polygonFromRing(ring));
      }
    }

    return polygons;
  }

  VPolygon _polygonFromRing(List<({double lat, double lng})> ring) {
    final polygon = VPolygon()..pointsLatLng = List.of(ring);
    for (final coordinate in ring) {
      polygon.points.add(
        VPolPoint()
          ..lat = coordinate.lat
          ..lng = coordinate.lng,
      );
    }
    polygon.populateEdges();
    return polygon;
  }

  // pA + pB
  // Get the union polygon boundaries, including separate rings when disjoint.
  void polygonUnion() {
    final segments = <VPolBoundSeg>[
      ...getBoundarySegments(pA, pB, keepInside: false),
      ...getBoundarySegments(pB, pA, keepInside: false),
    ];
    pUnPolygons = traceBoundaryRings(segments, operation: 'union');
    pUn = pUnPolygons.isEmpty ? VPolygon() : pUnPolygons.first;
  }
}
