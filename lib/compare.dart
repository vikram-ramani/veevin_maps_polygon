class VCompare {
  double precision = 0.000000001;

  VCompare() {
    precision = 0.000000001;
  }

  VCompare.withPrecision(double myPrecision) {
    this.precision = myPrecision;
  }

  // 0 - both are equal
  // 1 - Main is greater
  // -1 - Other is greater
  int compareWithPrecision(double valueMain, double valueOther) {
    if ((valueMain - valueOther).abs() <= precision) {
      return 0;
    }
    if (valueMain - valueOther > precision) {
      return 1;
    }
    return -1;
  }
}
