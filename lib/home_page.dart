import 'package:flutter/material.dart';
import 'package:project_ui_demo/widgets/booking_page.dart';
import 'package:project_ui_demo/widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width;

    // Define unique parking spot names
    final List<String> parkingSpots = [
      'Downtown Parking Lot',
      'Central Plaza Parking',
      'Riverside Garage',
      'Green Park Parking Area',
    ];

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
            color: Colors.grey[200],
            child: Center(
              child: Image.asset(
                'assets/images/google_maps4.png',
                height: 200,
                width: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // List of Parking Spots
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: parkingSpots.length, // Dynamically set count
            itemBuilder: (context, index) {
              // Adjust the index to start from 1
              final displayIndex = index + 1;
              return GestureDetector(
                onTap: () {
                  // Navigate to booking page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingsPage(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellow[100]!, Colors.lime[50]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Parking Image
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('assets/images/parking_image_$displayIndex.png'), // Update with new path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Parking Name
                      Expanded(
                        child: Text(
                          parkingSpots[index],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      // Arrow Icon
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueAccent[200],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
