// home_page.dart

import 'package:flutter/material.dart';
import 'package:project_ui_demo/widgets/search_bar.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Add the search bar
          SearchBar1(onSearch: (query) {
            // Implement search functionality here
            print('Search query: $query'); // For demonstration purposes
          }),
          // Map or List of Nearby Parking Spots
          Container(
            height: 200, // Placeholder for map or list
            color: Colors.grey[300],
            child: const Center(child: Text('Map or Nearby Spots Here')),
          ),
          // Quick Booking Button

        ],
      ),
    );
  }
}
