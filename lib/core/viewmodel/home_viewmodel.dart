import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../services/firestore_home.dart';
import '../../model/category_model.dart';
import '../../model/product_model.dart';

class HomeViewModel extends GetxController {
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];

  List<CategoryModel> get categories => _categories;

  List<ProductModel> get products => _products;

  bool _loading = false;

  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    _getCategoriesFromFireStore();
    _getProductsFromFireStore();
  }

  _getCategoriesFromFireStore() async {
    _loading = true;
    List<QueryDocumentSnapshot> categoriesSnapshot =
        await FirestoreHome().getCategoriesFromFirestore();
    categoriesSnapshot.forEach((category) {
      _categories
          .add(CategoryModel.fromJson(category.data() as Map<String, dynamic>));
    });
    _loading = false;
    update();
  }

  _getProductsFromFireStore() async {
    _loading = true;
    List<QueryDocumentSnapshot> productsSnapshot =
        await FirestoreHome().getProductsFromFirestore();
    productsSnapshot.forEach((product) {
      _products
          .add(ProductModel.fromJson(product.data() as Map<String, dynamic>));
    });
    _loading = false;
    update();
  }
}
