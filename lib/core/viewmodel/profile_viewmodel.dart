import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/firestore_user.dart';
import '../services/local_storage_user.dart';
import '../../model/user_model.dart';

class ProfileViewModel extends GetxController {
  UserModel? _currentUser;
  String? name, email, password, picUrl;

  UserModel? get currentUser => _currentUser;

  bool _loading = false;

  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  getCurrentUser() async {
    _loading = true;
    _currentUser = await LocalStorageUser.getUserData();
    _loading = false;
    update();
  }

  updateCurrentUser() async {
    try {
      UserModel _userModel = UserModel(
        userId: _currentUser!.userId,
        email: email!,
        name: name!,
        pic: picUrl == null ? _currentUser!.pic : picUrl!,
      );
      await FirebaseAuth.instance.currentUser!.updateEmail(email!);
      await FirebaseAuth.instance.currentUser!.updatePassword(password!);
      FirestoreUser().addUserToFirestore(_userModel);
      await LocalStorageUser.setUserData(_userModel);
      getCurrentUser();
      Get.back();
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to update..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
