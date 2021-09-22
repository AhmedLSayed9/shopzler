class CartModel {
  late String name, image, price, productId;
  late int quantity;

  CartModel({
    required this.name,
    required this.image,
    required this.price,
    required this.productId,
    this.quantity = 1,
  });

  CartModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    price = map['price'];
    productId = map['productId'];
    quantity = map['quantity'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
