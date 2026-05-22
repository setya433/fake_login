import 'package:get/get.dart';

import '../modules/login/views/login_view.dart';
import '../modules/login/controllers/login_controller.dart';

import '../modules/home/views/home_view.dart';
import '../modules/home/controllers/home_controller.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
  ];
}