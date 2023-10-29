import 'package:chat_app/common/values/values.dart';
import 'package:chat_app/common/widgets/widgets.dart';
import 'package:chat_app/pages/signin_screen/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildLogo() {
      return Container(
        width: 110.w,
        margin: EdgeInsets.only(top: 84.h),
        child: Column(
          children: [
            Container(
              width: 89.w,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 76.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        boxShadow: const [Shadows.primaryShadow],
                        borderRadius: BorderRadius.all(
                          Radius.circular(35.w),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 76.h,
                    child: Image.asset(
                      'assets/images/ic_launcher.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
              child: Text(
                'Lets chat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.thirdElement,
                  fontSize: 18.sp,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildThirdPartyLogo() {
      return SizedBox(
        width: 295.w,
        child: Column(
          children: [
            Text(
              'Sign in with social network',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                height: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30.h,
                left: 50.h,
                right: 50.w,
              ),
              child: Obx(
                () => btnFlatButtonWidget(
                  onPressed: () {
                    controller.hndleSignInn();
                  },
                  width: 200.w,
                  height: 55.h,
                  title: controller.state.loading.obs.value == true
                      ? 'Please wait'
                      : 'Google Login',
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            buildLogo(),
            const Spacer(),
            buildThirdPartyLogo(),
          ],
        ),
      ),
    );
  }
}
