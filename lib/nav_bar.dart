// home_page.dart

import 'package:flutter/material.dart';
import 'package:project_ui_demo/my_bookings.dart';
import 'home_page.dart';
import 'package:project_ui_demo/profile_page.dart';
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // List of pages to display in the body based on the selected index
  final List<Widget> _pages = [
    const HomePage(), // Use the imported HomePage widget
    MyBookingsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ParkIT',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: _pages[_selectedIndex], // Display the current page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Bookings Page Widget


// Profile Page Widget
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Profile Page!'),
//     );
//   }
// }
