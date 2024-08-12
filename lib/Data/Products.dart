
class Product {
  String? key;
  ProductData?  productData;

  Product(this.key, this.productData);
}

class ProductData {
  String? image;
  String? name;
  double? price;
  double? starRating;

  ProductData(
      this.image, this.name , this.price,this.starRating);

  ProductData.fromJson(Map<dynamic, dynamic> json){
    image = json["image"];
    name = json["name"];
    price= checkDouble(json["price"]);
    starRating = checkDouble(json["starRating"]);
  }


  double? checkDouble(price) {
    if (price is String) {
      return double.tryParse(price);
    } else if (price is double) {
      return price;
    } else if (price is int) {
      return price.toDouble();
    } else {
      return 0.0;
    }
  }

  @override
  String toString() {
    return 'ProductData{image: $image,Business Name: $name,  price: $price}';
  }


  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "name": name,
      "price": price,
      "starRating": starRating,
    };
  }





}
