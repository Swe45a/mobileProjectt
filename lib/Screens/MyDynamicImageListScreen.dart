import 'package:flutter/material.dart';
import 'package:ourprojecttest/Data/Products.dart';
import 'package:ourprojecttest/ReuseableCode/MyRoundedProductInfo.dart';
import '../Data/DatabaseHelper.dart';
import 'package:gap/gap.dart';
import 'LoginPage.dart';

class MyDynamicImageListScreen extends StatefulWidget {
  const MyDynamicImageListScreen({Key? key}) : super(key: key);

  @override
  _MyDynamicImageListScreenState createState() =>
      _MyDynamicImageListScreenState();
}

class _MyDynamicImageListScreenState extends State<MyDynamicImageListScreen> {
  List<Product> productsList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.readDataFromRealtimeDBFirebase((List<Product> productList) {
      setState(() {
        this.productsList = productList;
        print(this.productsList.first.productData?.name);
        print(this.productsList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Gap(20),
                  for (int i = 0; i < productsList.length; i++) ...{
                    MyRoundedProductInfo(product: productsList[i]),
                    const Gap(20),
                  }
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
