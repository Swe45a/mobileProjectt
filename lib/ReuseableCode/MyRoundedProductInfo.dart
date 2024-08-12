import 'package:flutter/material.dart';
import 'package:ourprojecttest/Data/Products.dart';
import 'package:ourprojecttest/ReuseableCode/AppStyles.dart';
import 'package:ourprojecttest/Screens/ProductDetailScreen.dart';



class MyRoundedProductInfo extends StatelessWidget {
  final Product? product;



  const MyRoundedProductInfo({super.key, required this.product});

 @override

 Widget build(BuildContext context) {
   return GestureDetector(

     onTap: () {
       if (product != null) {
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (context) => ProductDetailScreen(product: product!),
           ),
         );
       }
     },
     child :Padding(
       padding:const EdgeInsets.all(12.0),
       child: Container(
         height: 475,
         width: 0.75 * MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
           color: Colors.purple,
           borderRadius: BorderRadius.circular(15),
         ),
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Container(
                 height: 250,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: Colors.lightGreenAccent,
                     image: DecorationImage(
                       fit: BoxFit.cover,
                       image: AssetImage(
                           "assets/images/${product?.productData?.image}"),
                     )),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 20, right: 20),
               child: Stack(
                 children: [
                   Container(
                     height: 160,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: Colors.lightGreen,
                     ),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(
                           vertical: 15, horizontal: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "Business Name:",

                                 style: AppStyles.headlineStyle1,
                               ),
                               Text(
                                 "price:",
                                 style: AppStyles.headlineStyle1,
                               ),

                             ],
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                              Text(
                                 product!.productData!.name.toString(),
                                 style: AppStyles.headlineStyle1,
                               ),
                               Text(
                                 "${product!.productData!.price.toString()} ",
                                 style: AppStyles.headlineStyle1,
                               ),


                             ],

                           ),
                         ],
                       ),
                     ),
                   ),

                 ],
               ),
             ),

           ],
         ),
       ),
     ),
   );
 }
}
