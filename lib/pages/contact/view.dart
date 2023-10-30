import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/widgets/widgets.dart';
import 'package:chat_app/pages/contact/contac_list.dart';
import 'package:chat_app/pages/contact/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.contactState.contactList.length);
    AppBar buildAppbar() {
      return transparentAppBar(
        title: Text(
          'Contact',
          style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: buildAppbar(),
      body: const ContactList(),
    );
  }
}
