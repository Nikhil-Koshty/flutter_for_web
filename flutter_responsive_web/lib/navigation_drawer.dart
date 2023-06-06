import 'package:flutter/material.dart';
import 'package:flutter_responsive_web/rs_builder.dart';

class PhoneNavigationBar extends StatelessWidget {
  final int selectedTabIndex;
  final List<IconData> icons;
  final List<String> labels;
  final void Function(int index)? onSelectionChanged;

  const PhoneNavigationBar({
    Key? key,
    required this.selectedTabIndex,
    required this.icons,
    required this.labels,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      phone: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        items: [
          for (int i = 0; i < labels.length; i++)
            BottomNavigationBarItem(
              icon: Icon(icons[i]),
              label: labels[i],
            ),
        ],
        onTap: onSelectionChanged,
      ),
    );
  }
}

class TabletNavigationBar extends StatelessWidget {
  final int selectedTabIndex;
  final List<IconData> icons;
  final List<String> labels;
  final void Function(int index)? onSelectionChanged;

  const TabletNavigationBar({
    Key? key,
    required this.selectedTabIndex,
    required this.icons,
    required this.labels,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      tablet: _Drawer(
        selectedTabIndex: selectedTabIndex,
        icons: icons,
        labels: labels,
        onSelectionChanged: onSelectionChanged,
      ),
    );
  }
}

class DesktopNavigationBar extends StatelessWidget {
  final int selectedTabIndex;
  final List<IconData> icons;
  final List<String> labels;
  final void Function(int index)? onSelectionChanged;

  const DesktopNavigationBar({
    Key? key,
    required this.selectedTabIndex,
    required this.icons,
    required this.labels,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      desktop: _Drawer(
        selectedTabIndex: selectedTabIndex,
        icons: icons,
        labels: labels,
        onSelectionChanged: onSelectionChanged,
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  final int selectedTabIndex;
  final List<IconData> icons;
  final List<String> labels;
  final void Function(int index)? onSelectionChanged;

  const _Drawer({
    Key? key,
    required this.selectedTabIndex,
    required this.icons,
    required this.labels,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16, top: 16.0, bottom: 36.0),
                child: const FlutterLogo(size: 48),
              ),
            ],
          ),
          for (int i = 0; i < labels.length; i++)
            ListTile(
              onTap: () => onSelectionChanged?.call(i),
              selected: i == selectedTabIndex,
              leading: Icon(icons[i]),
              title: Text(labels[i]),
            ),
        ],
      ),
    );
  }
}
