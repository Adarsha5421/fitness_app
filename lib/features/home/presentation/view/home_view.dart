import 'package:fitness_tracker/view/homepage_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  // List of bottom navigation screens
  final List<Widget> lstBOttomScreen = [
    const HomePage(),
    const PlaceholderScreen(label: 'Workout'),
    const PlaceholderScreen(label: 'Profile'),
    const PlaceholderScreen(label: 'Search'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: lstBOttomScreen[_selectedIndex], // Display the selected screen
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.deepOrange,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Workout',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index; // Update the index to switch screens
            });
          },
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String label;

  const PlaceholderScreen({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}
