import 'package:chat_app/common/values/values.dart';
import 'package:chat_app/pages/application/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildPageView() {
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlepageChanged,
        children: const [
          Center(
            child: Text('Chat'),
          ),
          Center(
            child: Text('Contact'),
          ),
          Center(
            child: Text('Profile'),
          ),
        ],
      );
    }

    Widget buildBottomNavigationBr() {
      return Obx(
        () => BottomNavigationBar(
          items: controller.bottomtabs,
          currentIndex: controller.state.page,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handleNavBarTab,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: AppColors.tabBarElement,
          unselectedItemColor: AppColors.thirdElementText,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: buildPageView(),
      bottomNavigationBar: buildBottomNavigationBr(),
    );
  }
}
