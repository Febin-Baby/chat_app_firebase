import 'dart:convert';
import 'package:chat_app/common/entities/entities.dart';
import 'package:chat_app/common/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'index.dart';

class ContactController extends GetxController {
  final contactState = ContactState();
  ContactController();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;
  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  goChat(UserData userData) async {
    var fromMessage = await db
        .collection('message')
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: token)
        .where('to_uid', isEqualTo: userData.id)
        .get();
    var toMessage = await db
        .collection('message')
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: userData.id)
        .where('to_uid', isEqualTo: token)
        .get();
    if (fromMessage.docs.isEmpty && toMessage.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity uData =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgData = Msg(
        from_uid: uData.accessToken,
        to_uid: userData.id,
        from_name: uData.displayName,
        to_name: userData.name,
        from_avatar: uData.photoUrl,
        last_msg: '',
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      db
          .collection('message')
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          )
          .add(msgData)
          .then((value) {
        Get.toNamed('/chat', parameters: {
          'doc_id': value.id,
          'to_uid': userData.id ?? '',
          'to_name': userData.name ?? '',
          'to_avatar': userData.photourl ?? '',
        });
      });
    } else {
      if (fromMessage.docs.isNotEmpty) {
        Get.toNamed('/chat', parameters: {
          'doc_id': fromMessage.docs.first.id,
          'to_uid': userData.id ?? '',
          'to_name': userData.name ?? '',
          'to_avatar': userData.photourl ?? '',
        });
      }
      if (toMessage.docs.isNotEmpty) {
        Get.toNamed('/chat', parameters: {
          'doc_id': toMessage.docs.first.id,
          'to_uid': userData.id ?? '',
          'to_name': userData.name ?? '',
          'to_avatar': userData.photourl ?? '',
        });
      }
    }
  }

  asyncLoadAllData() async {
    var UserBase = await db
        .collection('users')
        .where('id', isNotEqualTo: token)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .get();
    for (var doc in UserBase.docs) {
      contactState.contactList.add(doc.data());
      print(doc.toString());
    }
  }
}
