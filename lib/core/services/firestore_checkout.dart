import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/checkout_model.dart';

class FirestoreCheckout {
  final CollectionReference _ordersCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('orders');

  Future<List<QueryDocumentSnapshot>> getOrdersFromFirestore() async {
    var _orders =
        await _ordersCollection.orderBy('date', descending: true).get();
    return _orders.docs;
  }

  addOrderToFirestore(CheckoutModel checkoutModel) async {
    await _ordersCollection.doc().set(checkoutModel.toJson());
  }
}
