import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  static const Color primaryBlue = Color(0xFF1636B8);
  static const Color softBlue = Color(0xFFEFF3FF);
  static const Color textDark = Color(0xFF1E1E2D);
  static const Color textGrey = Color(0xFF9A9AAF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softBlue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 36,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.public_rounded,
                    size: 58,
                    color: primaryBlue,
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Login to your Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Welcome back! Please enter your details.',
                    style: TextStyle(
                      fontSize: 14,
                      color: textGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),

                  _CustomInput(
                    controller: controller.usernameController,
                    hintText: 'Username',
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 18),

                  _CustomInput(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline_rounded,
                    obscureText: true,
                  ),
                  const SizedBox(height: 14),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.snackbar(
                          'Info',
                          'Fake login tidak menggunakan reset password',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed:
                            controller.isLoading.value ? null : controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          foregroundColor: Colors.white,
                          elevation: 10,
                          shadowColor: primaryBlue.withOpacity(0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const _CustomInput({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: LoginView.textGrey,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          icon,
          color: LoginView.textGrey,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE4E6F0),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: LoginView.primaryBlue,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}