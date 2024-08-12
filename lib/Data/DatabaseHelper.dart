

import 'package:firebase_database/firebase_database.dart';

import 'Products.dart';
import 'User.dart';

class DatabaseHelper {

  static Future<void> updateProducteRating(String key, double starRating) {
    final dbRef = FirebaseDatabase.instance.ref().child("productsList").child(key);
    return dbRef.update({"starRating": starRating});
  }



  static void deleteProduct(String? key) {
    if (key != null) {
      final dbRef = FirebaseDatabase.instance.ref().child("productsList");
      dbRef.child(key).remove()
          .then((value) => print("Product deleted successfully!"))
          .catchError((onError) => print("Failed to delete Product: $onError"));
    }
  }

  static void addNewProduct(ProductData productData) {
    final dbRef = FirebaseDatabase.instance.ref().child("productsList");
    dbRef
        .push()
        .set(productData.toJson())
        // ignore: avoid_print
        .then((value) => print("Product added successfully!"))
        // ignore: avoid_print
        .catchError((onError) => print("Failed to add product: $onError"));
  }

  static Future<bool> authenticateUser(String username, String hashedPassword) async {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('users');
    Query userQuery = dbRef.orderByChild('username').equalTo(username);

    DatabaseEvent event = await userQuery.once();

    if (event.snapshot.exists) {
      Map<dynamic, dynamic> users = event.snapshot.value as Map<dynamic, dynamic>;
      for (var key in users.keys) {
        var userData = users[key];
        if (userData['password'] == hashedPassword) {
          return true; // Login successful
        }
      }
    }
    return false; // Login failed
    }

  static void createNewUserRecordIntoFirebase(User user) {
    final dbRef = FirebaseDatabase.instance.ref();
    dbRef
        .child("users")
        .push() // add a unique key
        .set(user.userData!.toJson()) // Convert UserData to JSON
        .then((value) => print("User record created successfully!"))
        .catchError(
            (onError) => print("Failed to create user record: $onError"));
  }

  static void readDataFromRealtimeDBFirebase(
      Function(List<Product>) productListCallback) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("productsList").onValue.listen((productDataJson) {
      if (productDataJson.snapshot.exists) {
        ProductData productData;
        Product product;
        List<Product> productList = [];
        productDataJson.snapshot.children.forEach((element) {
          //print("Element Key: ${element.key}");
          //print("Element: ${element.value}");
          productData = ProductData.fromJson(element.value as Map);
          product = Product(element.key, productData);
          productList.add(product);
        });
        productListCallback(productList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }

  static void writeMessageToFirebase() {
    final dbRef = FirebaseDatabase.instance.ref();
    dbRef
        .child("messages")
        .push()
        .set({'msg1': 'Attack at dawn', 'msg2': 'Call  now!'})
        .then((value) => print("Message written successfully!"))
        .catchError((onError) => print("Failed to write message: $onError"));
  }

  static void writeProductDataToFirebase(
      String productsListName, List<Map<String, dynamic>> productsList) {
    final dbRef = FirebaseDatabase.instance.ref(productsListName);
    if (productsList.isNotEmpty) {
      productsList.forEach((element) {
        dbRef
            .push()
            .set(element)
            .then((value) => print("productlesList saved successfully!"))
            .catchError(
                (onError) => print("Failed to save product data: $onError"));
      });
    } else {
      print("productlesList is empty!");
    }
  }}


