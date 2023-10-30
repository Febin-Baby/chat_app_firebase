import 'package:chat_app/common/entities/entities.dart';
import 'package:chat_app/common/store/user.dart';
import 'package:chat_app/pages/chat/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final state = ChatInState();
  ChatController();
  var doc_id;
  final textController = TextEditingController();
  ScrollController mesgScrolling = ScrollController();
  FocusNode focusNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    doc_id = data['doc_id'];
    state.to_uid.value = data['to_uid'] ?? '';
    state.to_name.value = data['to_name'] ?? '';
    state.to_avatar.value = data['to_avatar'] ?? '';
  }

  sendMessage() async {
    String sendContent = textController.text;
    final content = Msgcontent(
      uid: user_id,
      content: sendContent,
      type: 'text',
      addtime: Timestamp.now(),
    );
    db
        .collection('message')
        .doc(doc_id)
        .collection('msglist')
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgContent, options) =>
              msgContent.toFirestore(),
        )
        .add(content)
        .then(
      (DocumentReference doc) {
        debugPrint('DOcument snapshot added with id,  $doc_id');
        textController.clear();
        Get.focusScope?.unfocus();
      },
    );
    await db.collection('message').doc(doc_id).update({
      'last_msg': sendContent,
      'last_item': Timestamp.now(),
    });
  }
}
