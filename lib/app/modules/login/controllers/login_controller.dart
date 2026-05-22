import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/session_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  final SessionService _sessionService = SessionService();

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Username dan password wajib diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 500));

    await _sessionService.saveLogin(
      username: username,
      password: password,
    );

    isLoading.value = false;

    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}