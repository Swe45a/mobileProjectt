import 'package:flutter/material.dart';
import '../Data/Products.dart';
import '../Data/DatabaseHelper.dart';
import 'MyHomePage.dart';

class ProductCreantionScreen extends StatefulWidget {
  const ProductCreantionScreen({super.key});

  @override
  State<ProductCreantionScreen> createState() => _ProductCreantionScreenState();
}

class _ProductCreantionScreenState extends State<ProductCreantionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  final _imageController = TextEditingController();


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ProductData prodData = ProductData(
          _imageController.text,
          _nameController.text,
          double.tryParse(_priceController.text),
          0.0
      );

       DatabaseHelper.addNewProduct(prodData);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Product',)),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Product")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product name',
                icon: Icon(Icons.fastfood),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Product name';
                }
                return null;
              },
            ),


            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                icon: Icon(Icons.image),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Product Price',
                icon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}