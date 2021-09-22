import 'package:flutter/material.dart';
import 'package:shopzler/helper/hexColor_extension.dart';

class ProductModel {
  late String name, image, description, size, price, productId, category;
  late Color color;

  ProductModel({
    required this.name,
    required this.image,
    required this.description,
    required this.size,
    required this.price,
    required this.productId,
    required this.category,
    required this.color,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];
    size = map['size'];
    price = map['price'];
    productId = map['productId'];
    category = map['category'];
    color = HexColor.fromHex(map['color']);
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'size': size,
      'color': color.toString(),
      'price': price,
      'productId': productId,
      'category': category,
    };
  }
}
