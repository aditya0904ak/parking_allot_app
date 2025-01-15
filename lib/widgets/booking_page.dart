import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tflite_flutter/tflite_flutter.dart';



class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<bool> bookedSlots = List.generate(8, (index) => false);
  List<int> countdownTimers = List.generate(8, (index) => 40);
  List<Timer?> timers = List.generate(8, (index) => null);
  static const int warningTime = 10;
  bool showWarning = false;
  int warningSlotIndex = -1;
  int selectedSlot = -1;
  int selectedPriceIndex = -1;

  void startTimer(int index) {
    countdownTimers[index] = 40;
    timers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdownTimers[index] > 0) {
        setState(() {
          countdownTimers[index]--;
        });
        if (countdownTimers[index] <= warningTime && countdownTimers[index] > 0 && !showWarning) {
          showWarningDialog(index);
        }
      } else {
        unbookSlot(index);
        timer.cancel();
      }
    });
  }

  void showWarningDialog(int index) {
    setState(() {
      showWarning = true;
      warningSlotIndex = index;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Time Warning'),
          content: Text('Slot ${index + 1} will be unbooked in $warningTime seconds!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  showWarning = false;
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    ).then((_) {
      setState(() {
        showWarning = false;
      });
    });
  }

  void unbookSlot(int index) {
    setState(() {
      bookedSlots[index] = false;
      countdownTimers[index] = 40;
    });
    timers[index]?.cancel();
  }

  @override
  void dispose() {
    for (var timer in timers) {
      timer?.cancel();
    }
    super.dispose();
  }

  void showPricingOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Price for Slot ${selectedSlot + 1}'),
          content: SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(8, (index) {
                  int rate = 50 * (index + 1);

                  // Calculate a unique color based on index/price
                  Color bgColor = Color.lerp(Colors.lightGreen, Colors.red, index / 8)!;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPriceIndex = index;
                      });
                      Navigator.of(context).pop(); // Close price dialog
                      showConfirmBookingDialog();
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Rs $rate\n${index + 1} hr',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showConfirmBookingDialog() {
    if (bookedSlots[selectedSlot]) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Booking'),
          content: Text('You selected Slot ${selectedSlot + 1} at a rate of Rs ${50 * (selectedPriceIndex + 1)} for ${selectedPriceIndex + 1} hour(s). Do you want to proceed with booking?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedSlot != -1) {
                  setState(() {
                    bookedSlots[selectedSlot] = true;
                  });
                  Navigator.of(context).pop();
                  startTimer(selectedSlot);
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Slot Booking'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Select a Parking Slot',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: bookedSlots.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSlot = index; // Set the selected slot
                      });
                      showPricingOptions(); // Show pricing options for the selected slot
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: bookedSlots[index] ? Colors.red : Colors.green[300],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              bookedSlots[index] ? 'Booked' : 'Slot ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (bookedSlots[index])
                              Text(
                                'Time Left: ${countdownTimers[index]}s',
                                style: TextStyle(color: Colors.yellow),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
