import 'package:flutter/material.dart';
import 'package:flutter_responsive_web/navigation_drawer.dart';
import 'package:flutter_responsive_web/rs_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedTabIndex = 0;

  final List<IconData> _icons = const [
    Icons.home,
    Icons.business,
    Icons.person,
  ];

  final List<String> _labels = const [
    'Home',
    'Discover',
    'Profile',
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedTabIndex = index;
      _tabController.index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: _selectedTabIndex, length: _labels.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        DesktopNavigationBar(
          selectedTabIndex: _selectedTabIndex,
          icons: _icons,
          labels: _labels,
          onSelectionChanged: _changeTab,
        ),
        Expanded(
          child: Scaffold(
            drawer: ResponsiveBuilder.isTablet(width)
                ? TabletNavigationBar(
                    selectedTabIndex: _selectedTabIndex,
                    icons: _icons,
                    labels: _labels,
                    onSelectionChanged: _changeTab,
                  )
                : null,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(_labels[_selectedTabIndex]),
            ),
            body:  TabBarView(
              controller: _tabController,
              children: const [
                HomeScreen(),
                DiscoverScreen(),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: PhoneNavigationBar(
              selectedTabIndex: _selectedTabIndex,
              icons: _icons,
              labels: _labels,
              onSelectionChanged: _changeTab,
            ),
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: _Body(),
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: _Body(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Row(
          children: [
            const Expanded(flex: 1, child: SizedBox.shrink()),
            Expanded(
              flex: 3,
              child: ResponsiveBuilder(
                phone: _Box(number: index + 1),
                tablet: Row(
                  children: [
                    Expanded(child: _Box(number: (2*index) + 1)),
                    Expanded(child: _Box(number: (2*index) + 2)),
                  ],
                ),
                desktop: Row(
                  children: [
                    Expanded(child: _Box(number: (3*index) + 1)),
                    Expanded(child: _Box(number: (3*index) + 2)),
                    Expanded(child: _Box(number: (3*index) + 3)),
                  ],
                ),
              ),
            ),
            const Expanded(flex: 1, child: SizedBox.shrink()),
          ],
        );
      },
    );
  }
}

class _Box extends StatelessWidget {
  final int number;

  const _Box({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        color: Theme.of(context).primaryColor.withOpacity(0.6),
        child: Center(
          child: Text(
            '# $number',
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
