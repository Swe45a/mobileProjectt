//import 'package:ourprojecttest/Screens/MyStaticImageScreen.dart';
import 'package:flutter/material.dart';
import 'package:ourprojecttest/Data/DatabaseHelper.dart';
import 'package:ourprojecttest/Screens/PaymentScreen.dart';
import 'package:ourprojecttest/Screens/ProductCreantionScreen.dart';
//import 'package:ourprojecttest/Data/ProductList.dart';
import 'package:ourprojecttest/Data/Products.dart';

import '../Data/Products.dart';
import 'MyDynamicImageListScreen.dart';



class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle textStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  late final List<Widget> _widgetOptions = <Widget>[
   // const Text("Home" , style: textStyle,),
    //const Text("Remote Product", style: textStyle,),
    const MyDynamicImageListScreen(),
   // const MystaticImageList(),
   // const ProductCreantionScreen(),

  ];

   List<Product> productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.readDataFromRealtimeDBFirebase((productList){
      setState(() {
        this.productList= productList;
        print(this.productList.first.productData?.name);
        print(this.productList);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), /*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is my home page!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // ElevatedButton(
            //  onPressed: onPressedProcess, child: const Text("Process"))
          ],
        ),*/
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapPressed,
        selectedItemColor: Colors.lightGreen,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: "Payment"
          ),

        ],

      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  void onTapPressed(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}

