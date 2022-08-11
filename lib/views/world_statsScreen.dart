import 'dart:convert';

import 'package:covid19_tracker_app/services/stats_calculator.dart';
import 'package:covid19_tracker_app/services/utils/app_urls.dart';
import 'package:covid19_tracker_app/model/world_stats.dart';
import 'package:covid19_tracker_app/views/countriesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class WorldStatsScreen extends StatefulWidget {
  WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1));

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ]; //<Color>[]
  @override
  Widget build(BuildContext context) {
    StatsCalulator stats = new StatsCalulator();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: stats.fetchworldStats(),
          builder:
              (BuildContext context, AsyncSnapshot<WorldStatsModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 50,
                  controller: _controller,
                ),
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  PieChart(
                    colorList: colorList,
                    chartRadius: MediaQuery.of(context).size.width * 0.5,
                    ringStrokeWidth: 10,
                    dataMap: {
                      'Total': snapshot.data!.cases!.toDouble(),
                      'Death': snapshot.data!.deaths!.toDouble(),
                      'Recovered': snapshot.data!.recovered!.toDouble(),
                    },
                    chartValuesOptions:
                        ChartValuesOptions(showChartValuesInPercentage: true),
                    chartType: ChartType.ring,
                    legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left),
                    centerText: 'covid stats',
                    centerTextStyle: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                    animationDuration: const Duration(milliseconds: 1200),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          ReuseableRow(
                              title: 'Total',
                              value: snapshot.data!.cases.toString()),
                          ReuseableRow(
                              title: 'Deaths',
                              value: snapshot.data!.deaths.toString()),
                          ReuseableRow(
                              title: 'Recovered',
                              value: snapshot.data!.recovered.toString()),
                          ReuseableRow(
                              title: 'Active',
                              value: snapshot.data!.active.toString()),
                          ReuseableRow(
                              title: 'Crtical',
                              value: snapshot.data!.critical.toString()),
                          ReuseableRow(
                              title: 'Today Deaths',
                              value: snapshot.data!.todayDeaths.toString()),
                          ReuseableRow(
                              title: 'Today Recovered',
                              value: snapshot.data!.todayRecovered.toString()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CountriesScreen())),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Track Countries",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 1.7),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  const ReuseableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
