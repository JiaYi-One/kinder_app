import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kinder_app/screens/login.dart';
import 'package:kinder_app/screens/home.dart';
import 'package:kinder_app/screens/settings.dart';
import 'package:kinder_app/screens/profile.dart';
import 'package:kinder_app/screens/student.dart';
import 'package:kinder_app/widgets/nav_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Firebase initializes before the app runs
  await Firebase.initializeApp(); // Initializes Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kindergarten',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
    const LoginScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      // Navigate to StudentScreen dynamically
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StudentScreen(), // No hardcoded studentId
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Kinder'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: AppDrawer(
        currentIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
      body: _screens[_selectedIndex],
    );
  }
}
