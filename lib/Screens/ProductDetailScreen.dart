import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ourprojecttest/Data/DatabaseHelper.dart';
import 'package:ourprojecttest/Data/Products.dart';
import 'package:ourprojecttest/Screens/MyHomePage.dart';
import 'package:ourprojecttest/Screens/PaymentScreen.dart';


class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _ProQuantity = 1;
  double _Proprice = 0, _totalCost = 0;

  @override
  Widget build(BuildContext context) {
    _Proprice = widget.product.productData?.price ?? 0.0;
    _totalCost = _ProQuantity * _Proprice;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productData?.name ?? 'Product Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Displaying the local image
            widget.product.productData?.image != null
                ? Image.asset(
                "assets/images/${widget.product.productData!.image}")
                : const SizedBox(height: 200, child: Placeholder()), // Placeholder in case there's no image
            const SizedBox(height: 10),
            Text('Bussiness Name: ${widget.product.productData?.name ?? ''}'),
            Text(' Price: ${widget.product.productData?.price?.toStringAsFixed(2) ?? ''}'),
            const SizedBox(height: 20),
            const Text('Select Product Quantity:'),
            Slider(
              value: _ProQuantity.toDouble(),
              min: 1,
              max: 10,
             divisions: 9,
              label: _ProQuantity.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _ProQuantity = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Total Cost: OMR ${_totalCost.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog();
              },
              child: const Text('Confirm product'),
            ),


             const SizedBox(height: 10),
            // Add RatingBar here
            RatingBar.builder(
              initialRating: widget.product.productData?.starRating ?? 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                // Update the rating in the database
                DatabaseHelper.updateProducteRating(widget.product.key!, rating).then((_) {
                  // Show a snackbar on successful update
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rating updated successfully')),
                  );
                }).catchError((error) {
                  // Handle errors and show a different snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update rating: ${error.toString()}')),
                  );
                });
              },
            ),


            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _deleteProduct(),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Use min size for the Row
                children: [
                  Icon(Icons.delete), // Delete icon
                  SizedBox(width: 8), // Space between icon and text
                  Text('Delete product'), // Button text
                ],
              ),
            ),

           ElevatedButton(
               onPressed:  () {
                 Navigator.push(
                     context,
                   MaterialPageRoute(
                     builder: (context) => const MyPaymentScreen(),
                   ),
                 );

               },
             child:
             const Text('payment', style: TextStyle(fontSize: 20)),

           ),


            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the main page
              },
              child: const Text('Back to Main Page'),
            ),

          ],
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
          content: Text("You have chosen to buy $_ProQuantity product for a total of OMR ${_totalCost.toStringAsFixed(2)} - Please confirm!"),
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
                  SnackBar(content: Text("Thank you for buying $_ProQuantity products for a total of OMR ${_totalCost.toStringAsFixed(2)}")),
                );
              },
            ),
          ],
        );
      },
    );
  }


  void _deleteProduct() {
    if (widget.product.key != null && widget.product.productData?.name != null) {
      String productName = widget.product.productData!.name!;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Deletion'),
            content:
            Text('Are you sure you want to delete the product $productName?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  DatabaseHelper.deleteProduct(widget.product.key);
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$productName product deleted')),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const MyHomePage(title: 'Product App')),
                        (Route<dynamic> route) => false,
                  );
                },
              ),

            ],

          );
        },
      );
    }
  }





}




