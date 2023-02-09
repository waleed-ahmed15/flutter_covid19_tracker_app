import 'dart:convert';
import 'dart:math';

import 'package:covid19_tracker_app/model/countries_stats.dart';

import 'utils/app_urls.dart';
import '../model/world_stats.dart';
import 'package:http/http.dart' as http;

class StatsCalulator {
  late WorldStatsModel worldstats;
  late List<CountriesStatsModel> countriesStatsList = [];
  Future<WorldStatsModel> fetchworldStats() async {
    final response = await http
        .get(Uri.parse("${App_url.baseUrl}/${App_url.worldStatesApi}"));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      worldstats = WorldStatsModel.fromJson(data);
      print(worldstats.cases);
      print(worldstats.recovered);
      print(worldstats.deaths);
      return worldstats;
    } else {
      print("some error occured fetching the APi");
      return worldstats;
    }
  }

  Future<List<CountriesStatsModel>> fetchCountriesStats() async {
    final response =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map element in data) {
        print(element);
        countriesStatsList.add(CountriesStatsModel.fromJson(element));
      }
      // return data;
      return countriesStatsList;
    } else {
      // return data;
      print("some error occured fetching the APi");
      return countriesStatsList;
      // return countriesStatsList;
    }
  }
}
