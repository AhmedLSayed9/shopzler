import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../services/firestore_checkout.dart';
import '../viewmodel/cart_viewmodel.dart';
import '../../model/checkout_model.dart';

class CheckoutViewModel extends GetxController {
  String? street, city, state, country, phone;

  List<CheckoutModel> _checkouts = [];

  List<CheckoutModel> get checkouts => _checkouts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    _getCheckoutsFromFireStore();
  }

  _getCheckoutsFromFireStore() async {
    _isLoading = true;
    _checkouts = [];
    List<QueryDocumentSnapshot> _checkoutsSnapshot =
        await FirestoreCheckout().getOrdersFromFirestore();
    _checkoutsSnapshot.forEach((order) {
      _checkouts
          .add(CheckoutModel.fromJson(order.data() as Map<String, dynamic>));
    });
    _isLoading = false;
    update();
  }

  addCheckoutToFireStore() async {
    await FirestoreCheckout().addOrderToFirestore(CheckoutModel(
      street: street!,
      city: city!,
      state: state!,
      country: country!,
      phone: phone!,
      totalPrice: Get.find<CartViewModel>().totalPrice.toString(),
      date: DateFormat.yMMMd().add_jm().format(DateTime.now()),
    ));
    Get.find<CartViewModel>().removeAllProducts();
    Get.back();
    _getCheckoutsFromFireStore();
  }
}
