import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gap/gap.dart';
import 'package:ourprojecttest/Screens/MyHomePage.dart';


class MyPaymentScreen extends StatefulWidget {
  const MyPaymentScreen({super.key});

  @override
  State<MyPaymentScreen> createState() => _MyPaymentScreenState();
}

class _MyPaymentScreenState extends State<MyPaymentScreen> {
  var flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Icon(
              Icons.credit_card_rounded,
              size: 40,
            ),
            const Gap(40),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Name On Card',
              ),
            ),
            const Gap(20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Card Number',
              ),
            ),
            const Gap(20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Expiry Date',
              ),
            ),
            const Gap(20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'CVC',
              ),
            ),
            const Gap(30),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog();
              },
              child: const Text('Confirm'),
            )
          ]),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Purchase"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Your Order Has Been Confirmed")),
                );
                _showNotification();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "Hadhana"),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Payment Confirmation',
        'Thank you for choosing Hadhana Application', platformChannelSpecifics,
        payload: 'item x');
  }
}
