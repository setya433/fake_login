class CountryModel {
  final String name;
  final String capital;
  final String flagPng;

  CountryModel({
    required this.name,
    required this.capital,
    required this.flagPng,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final nameData = json['name'];
    final capitalData = json['capital'];
    final flagsData = json['flags'];

    return CountryModel(
      name: nameData?['common'] ?? '-',
      capital: capitalData is List && capitalData.isNotEmpty
          ? capitalData.first.toString()
          : '-',
      flagPng: flagsData?['png'] ?? '',
    );
  }
}