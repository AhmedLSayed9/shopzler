import 'package:get/get.dart';

import '../core/network_viewmodel.dart';
import '../core/viewmodel/auth_viewmodel.dart';
import '../core/viewmodel/cart_viewmodel.dart';
import '../core/viewmodel/home_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.put(CartViewModel());
    Get.lazyPut(() => NetworkViewModel());
  }
}
