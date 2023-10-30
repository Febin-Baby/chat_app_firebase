import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/entities/user.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/pages/contact/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  Widget buildListItem(UserData item) {
    return InkWell(
      onTap: () {
        if (item.id != null) {
          controller.goChat(item);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 0.w,
              left: 15.w,
              right: 15.w,
            ),
            child: SizedBox(
              width: 54.w,
              height: 54.w,
              child: CachedNetworkImage(imageUrl: '${item.photourl}'),
            ),
          ),
          Container(
            width: 250.w,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Color(0xffe5efe5)),
              ),
            ),
            padding: EdgeInsets.only(
              top: 15.w,
              left: 0.w,
              right: 15.w,
              bottom: 0.w,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 200.w,
                  height: 42.w,
                  child: Text(
                    item.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.thirdElement,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (c, i) {
                  var item = controller.contactState.contactList[i];
                  return buildListItem(item);
                },
                childCount: controller.contactState.contactList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
