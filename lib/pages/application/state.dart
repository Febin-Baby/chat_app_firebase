import 'package:get/get.dart';

class ApplicationState {
  final int _page = 0.obs();
  int get page => _page.obs.value;
  set page(value) => _page.obs.value = value;
}
