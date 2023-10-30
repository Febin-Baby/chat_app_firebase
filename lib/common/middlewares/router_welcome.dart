import 'package:flutter/material.dart';
import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/store/store.dart';

import 'package:get/get.dart';

class RouteWelcomeMiddleware extends GetMiddleware {
  // priority
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    print(ConfigStore.to.isFirstOpen);
    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return const RouteSettings(name: AppRoutes.Application);
    } else {
      return const RouteSettings(name: AppRoutes.SIGN_IN);
    }
  }
}
