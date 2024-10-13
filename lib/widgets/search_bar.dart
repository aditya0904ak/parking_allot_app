// search_bar.dart

import 'package:flutter/material.dart';

class SearchBar1 extends StatelessWidget {
  final Function(String) onSearch; // Callback to handle search queries

  const SearchBar1({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: onSearch, // Call the function when the text changes
        decoration: const InputDecoration(
          hintText: 'Search for parking...',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
