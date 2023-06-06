import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/profile/:id',
            builder: (context, state) => ProfileScreen(id: state.pathParameters['id']),
          ),
          GoRoute(
            path: '/404',
            builder: (context, state) => const NotFoundScreen(),
          ),
        ],
        errorBuilder: (context, state) => const NotFoundScreen(),
      ),
    );
  }
}

class Profile {
  final String id;
  final String name;
  final String email;

  const Profile({
    required this.id,
    required this.name,
    required this.email,
  });
}

const List<Profile> availableProfiles = [
  Profile(id: '1', name: 'Dipak', email: 'dipak@gmail.com'),
  Profile(id: '2', name: 'Nikhil', email: 'nikhil@gmail.com'),
  Profile(id: '3', name: 'Rohan', email: 'rohan@gmail.com'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToProfile(BuildContext context, Profile profile) {
    context.go('/profile/${profile.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Profiles'),
      ),
      body: ListView.builder(
        itemCount: availableProfiles.length,
        itemBuilder: (context, index) {
          final Profile profile = availableProfiles[index];
          return _tileItem(context, profile);
        },
      ),
    );
  }

  Widget _tileItem(BuildContext context, Profile profile) {
    return ListTile(
      onTap: () => _navigateToProfile(context, profile),
      leading: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Text(
          '#${profile.id}',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      title: Text(profile.name),
      subtitle: Text(profile.email),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final String? id;

  const ProfileScreen({Key? key, this.id}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? profile;

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    _loadProfile();
    super.didUpdateWidget(oldWidget);
  }

  void _loadProfile() {
    try {
      profile = null;
      profile = availableProfiles.firstWhere((e) => e.id == widget.id);
    } catch (_) {}
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.pushReplacement('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const NotFoundScreen();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: _handleBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${profile!.id}'),
            Text('Name: ${profile!.name}'),
            Text('Email: ${profile!.email}'),
          ],
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  void _navigateToHome(BuildContext context) {
    context.pushReplacement('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Page not found',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () => _navigateToHome(context),
              child: const Text('Go Home'),
            )
          ],
        ),
      ),
    );
  }
}
