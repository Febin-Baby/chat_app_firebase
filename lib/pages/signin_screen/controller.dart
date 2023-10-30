import 'package:chat_app/common/entities/user.dart';
import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/store/store.dart';
import 'package:chat_app/common/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'index.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>['openid']);

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();
  final db = FirebaseFirestore.instance;
  Future<void> hndleSignInn() async {
    state.loading.value = true;
    try {
      debugPrint('Entere try');
      var user = await googleSignIn.signIn();
      if (user != null) {
        final gAuthentication = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: gAuthentication.idToken,
          accessToken: gAuthentication.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? '';
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.email = email;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);

        var userbase = await db
            .collection('users')
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, _) => userData.toFirestore(),
            )
            .where('id', isEqualTo: id)
            .get();
        if (userbase.docs.isEmpty) {
          final data = UserData(
            id: id,
            name: displayName,
            email: email,
            photourl: photoUrl,
            location: '',
            fcmtoken: '',
            addtime: Timestamp.now(),
          );
          await db
              .collection('users')
              .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userData, options) =>
                    userData.toFirestore(),
              )
              .add(data);
        }
        toastInfo(msg: 'Login sucess');
        Get.offAndToNamed(AppRoutes.Application);
        state.loading.value = false;
      }
      debugPrint('Combleted try');
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      toastInfo(msg: 'Error');
      state.loading.value = false;
    }
    @override
    void onReady() {
      super.onReady();
      FirebaseAuth.instance.authStateChanges().listen(
        (User? user) {
          if (user == null) {
            debugPrint('User is currently logged out');
          } else {
            debugPrint('User is logged in');
          }
        },
      );
    }
  }
}
