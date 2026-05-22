import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/data/services/session_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sessionService = SessionService();
  final isLoggedIn = await sessionService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Countries App',
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}