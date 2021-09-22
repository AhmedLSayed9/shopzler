import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../services/local_storage_user.dart';
import '../services/firestore_user.dart';
import '../../model/user_model.dart';
import '../../view/control_view.dart';

class AuthViewModel extends GetxController {
  String? email, password, name;

  Rxn<User>? _user = Rxn<User>();

  String? get user => _user?.value?.email;

  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _user!.bindStream(_auth.authStateChanges());
  }

  void signUpWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) {
        saveUser(user);
      });
      Get.offAll(ControlView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithEmailAndPassword() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((user) {
        FirestoreUser().getUserFromFirestore(user.user!.uid).then((doc) {
          saveUserLocal(
              UserModel.fromJson(doc.data() as Map<dynamic, dynamic>));
        });
      });
      Get.offAll(ControlView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithGoogleAccount() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication _googleSignInAuthentication =
          await _googleUser!.authentication;
      final _googleAuthCredential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );

      await _auth.signInWithCredential(_googleAuthCredential).then((user) {
        saveUser(user);
      });
      Get.offAll(ControlView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithFacebookAccount() async {
    try {
      final _facebookSignIn = await FacebookAuth.instance.login();

      final _facebookAuthCredential =
          FacebookAuthProvider.credential(_facebookSignIn.accessToken!.token);

      await _auth.signInWithCredential(_facebookAuthCredential).then((user) {
        saveUser(user);
      });
      Get.offAll(ControlView());
    } catch (error) {
      Get.snackbar(
        'Failed to login..',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      LocalStorageUser.clearUserData();
    } catch (error) {
      print(error);
    }
  }

  void saveUser(UserCredential userCredential) async {
    UserModel _userModel = UserModel(
      userId: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: name == null ? userCredential.user!.displayName! : this.name!,
      pic: userCredential.user!.photoURL == null
          ? 'default'
          : userCredential.user!.photoURL! + "?width=400",
    );
    FirestoreUser().addUserToFirestore(_userModel);
    saveUserLocal(_userModel);
  }

  void saveUserLocal(UserModel userModel) async {
    LocalStorageUser.setUserData(userModel);
  }
}
