import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/values/values.dart';
import 'package:chat_app/pages/chat/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 176, 106, 231),
              Color.fromARGB(255, 166, 112, 231),
              Color.fromARGB(255, 131, 112, 231),
              Color.fromARGB(255, 104, 132, 231),
            ],
            transform: GradientRotation(90),
          ),
        ),
      ),
      title: SizedBox(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
              child: InkWell(
                child: SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: CachedNetworkImage(
                    imageUrl: controller.state.to_avatar.value,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 44.w,
                        width: 44.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(44.w),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) => const Image(
                      image: AssetImage('assets/images/feature-1.png'),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 180.w,
              padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 180.w,
                    height: 44.w,
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.state.to_name.value,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBackground,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.w,
                          ),
                          Text(
                            'Unknow location',
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryBackground,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              Positioned(
                bottom: 0.h,
                height: 50.h,
                child: Container(
                  width: 350.w,
                  height: 50.h,
                  color: AppColors.primaryBackground,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          width: 217.w,
                          height: 50.h,
                          child: TextField(
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            focusNode: controller.focusNode,
                            controller: controller.textController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: 'Send message...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: GestureDetector(
                          child: Icon(
                            Icons.photo_outlined,
                            size: 35.w,
                            color: Colors.blue,
                          ),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10.w,
                          top: 5.h,
                        ),
                        width: 65.w,
                        height: 37.h,
                        child: FloatingActionButton(
                          onPressed: () {
                            controller.sendMessage();
                          },
                          child: const Icon(Icons.send),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
