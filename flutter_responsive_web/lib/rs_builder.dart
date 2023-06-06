import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget phone;
  final Widget tablet;
  final Widget desktop;

  static const double _phoneSize = 576;
  static const double _tabletSize = 768;
  static const double _desktopSize = 1200;

  static bool isTablet(double width) => width >= _tabletSize && width < _desktopSize;

  const ResponsiveBuilder({
    Key? key,
    this.phone = const SizedBox.shrink(),
    this.tablet = const SizedBox.shrink(),
    this.desktop = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width >= _desktopSize) {
      return desktop;
    } else if (width >= _tabletSize) {
      return tablet;
    } else {
      return phone;
    }
  }
}
