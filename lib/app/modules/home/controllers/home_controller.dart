import 'package:get/get.dart';

import '../../../data/models/country_model.dart';
import '../../../data/services/country_service.dart';
import '../../../data/services/session_service.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  final countries = <CountryModel>[].obs;
  final isLoading = false.obs;
  final username = ''.obs;

  final CountryService _countryService = CountryService();
  final SessionService _sessionService = SessionService();

  @override
  void onInit() {
    super.onInit();
    loadUser();
    fetchCountries();
  }

  Future<void> loadUser() async {
    username.value = await _sessionService.getUsername();
  }

  Future<void> fetchCountries() async {
    try {
      isLoading.value = true;

      final result = await _countryService.getCountries();
      result.sort((a, b) => a.name.compareTo(b.name));

      countries.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data negara',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _sessionService.logout();
    Get.offAllNamed(AppRoutes.login);
  }
}