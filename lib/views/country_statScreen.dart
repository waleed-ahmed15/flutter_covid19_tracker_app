import 'dart:convert';

import 'package:covid19_tracker_app/model/countries_stats.dart';
import 'package:covid19_tracker_app/views/world_statsScreen.dart';
import 'package:flutter/material.dart';

class CountryStatScreen extends StatelessWidget {
  CountriesStatsModel data;

  CountryStatScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    print('object');
    return Scaffold(
      appBar: AppBar(title: Text(data.country.toString())),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Column(
                      children: [
                        ReuseableRow(
                            title: 'Total', value: data.cases.toString()),
                        ReuseableRow(
                            title: 'Deaths', value: data.deaths.toString()),
                        ReuseableRow(
                            title: 'Recovered',
                            value: data.recovered.toString()),
                        ReuseableRow(
                            title: 'Active', value: data.active.toString()),
                        ReuseableRow(
                            title: 'Crtical', value: data.critical.toString()),
                        ReuseableRow(
                            title: 'Today Deaths',
                            value: data.todayDeaths.toString()),
                        ReuseableRow(
                            title: 'Today Recovered',
                            value: data.todayRecovered.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                left: MediaQuery.of(context).size.width * 0.45,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(data.countryInfo!.flag.toString()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
