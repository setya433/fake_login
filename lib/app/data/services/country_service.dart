import 'package:dio/dio.dart';

import '../models/country_model.dart';

class CountryService {
  final Dio _dio = Dio();

  Future<List<CountryModel>> getCountries() async {
    const url =
        'https://restcountries.com/v3.1/all?fields=name,capital,currencies,flags';

    final response = await _dio.get(url);

    final List data = response.data;

    return data.map((item) {
      return CountryModel.fromJson(item);
    }).toList();
  }
}