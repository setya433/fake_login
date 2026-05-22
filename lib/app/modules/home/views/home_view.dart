import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Negara'),
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.countries.isEmpty) {
          return const Center(
            child: Text('Data negara kosong'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Login sebagai: ${controller.username.value}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.fetchCountries,
                child: ListView.separated(
                  itemCount: controller.countries.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final country = controller.countries[index];

                    return ListTile(
                      leading: country.flagPng.isNotEmpty
                          ? Image.network(
                              country.flagPng,
                              width: 48,
                              height: 32,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return const Icon(Icons.flag);
                              },
                            )
                          : const Icon(Icons.flag),
                      title: Text(country.name),
                      subtitle: Text('Ibukota: ${country.capital}'),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}