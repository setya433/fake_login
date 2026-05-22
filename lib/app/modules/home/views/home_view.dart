import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color primaryBlue = Color(0xFF1636B8);
  static const Color softBlue = Color(0xFFEFF3FF);
  static const Color textDark = Color(0xFF1E1E2D);
  static const Color textGrey = Color(0xFF9A9AAF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softBlue,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryBlue,
              ),
            );
          }

          return Column(
            children: [
              _Header(controller: controller),
              Expanded(
                child: controller.countries.isEmpty
                    ? const _EmptyState()
                    : RefreshIndicator(
                        color: primaryBlue,
                        onRefresh: controller.fetchCountries,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                          itemCount: controller.countries.length,
                          itemBuilder: (context, index) {
                            final country = controller.countries[index];

                            return _CountryCard(
                              name: country.name,
                              capital: country.capital,
                              flagUrl: country.flagPng,
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final HomeController controller;

  const _Header({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 14),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: HomeView.primaryBlue,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: HomeView.primaryBlue.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.public_rounded,
                  color: HomeView.primaryBlue,
                  size: 28,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: controller.logout,
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'List Negara',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            return Text(
              controller.username.value.isEmpty
                  ? 'Welcome back!'
                  : 'Welcome back, ${controller.username.value}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Obx(() {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.flag_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${controller.countries.length} countries loaded',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CountryCard extends StatelessWidget {
  final String name;
  final String capital;
  final String flagUrl;

  const _CountryCard({
    required this.name,
    required this.capital,
    required this.flagUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: HomeView.primaryBlue.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          _FlagImage(flagUrl: flagUrl),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: HomeView.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_city_rounded,
                      size: 16,
                      color: HomeView.textGrey,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        capital == '-' ? 'Ibukota tidak tersedia' : capital,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: HomeView.textGrey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right_rounded,
            color: HomeView.textGrey,
          ),
        ],
      ),
    );
  }
}

class _FlagImage extends StatelessWidget {
  final String flagUrl;

  const _FlagImage({
    required this.flagUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: HomeView.softBlue,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: flagUrl.isNotEmpty
            ? Image.network(
                flagUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.flag_rounded,
                    color: HomeView.primaryBlue,
                  );
                },
              )
            : const Icon(
                Icons.flag_rounded,
                color: HomeView.primaryBlue,
              ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Data negara kosong',
        style: TextStyle(
          color: HomeView.textGrey,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}