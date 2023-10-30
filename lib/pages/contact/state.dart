import 'package:chat_app/common/entities/user.dart';
import 'package:get/get.dart';

class ContactState {
  RxInt count = 0.obs;
  RxList<UserData> contactList = <UserData>[].obs;
}
