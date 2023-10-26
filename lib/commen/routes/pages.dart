import 'package:chat_app/commen/routes/names.dart';
import 'package:chat_app/pages/welcome/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAl;
  static const Application = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAl,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
  ];
}
