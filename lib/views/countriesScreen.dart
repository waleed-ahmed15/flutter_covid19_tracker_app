import 'package:covid19_tracker_app/model/countries_stats.dart';
import 'package:covid19_tracker_app/services/stats_calculator.dart';
import 'package:covid19_tracker_app/views/country_statScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  CountriesScreen({Key? key}) : super(key: key);

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsCalulator countriesStats = new StatsCalulator();
    print('hererer');
    print(33.4.runtimeType.toString());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    fillColor: Colors.white10,
                    filled: true,
                    hintText: "Search",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: countriesStats.fetchCountriesStats(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CountriesStatsModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) {
                          return Shimmer.fromColors(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                  ) // ListTile
                                ],
                              ),
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.grey.shade700);
                        },
                      ),
                    );
                  } else {
                    print(snapshot.data!.length);
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          String name =
                              snapshot.data![index].country.toString();
                          if (_controller.text.isEmpty) {
                            return ListTile(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountryStatScreen(
                                      data: snapshot.data![index]),
                                ),
                              ),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data![index].countryInfo!.flag
                                      .toString())),
                              title: Text(
                                  snapshot.data![index].country.toString()),
                              subtitle: Text("Effected:" +
                                  snapshot.data![index].cases.toString()),
                            );
                          } else if (name.toLowerCase().contains(
                              _controller.text.toLowerCase().toString())) {
                            return ListTile(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountryStatScreen(
                                      data: snapshot.data![index]),
                                ),
                              ),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data![index].countryInfo!.flag
                                      .toString())),
                              title: Text(
                                  snapshot.data![index].country.toString()),
                              subtitle: Text("Effected:" +
                                  snapshot.data![index].cases.toString()),
                            );
                          } else {
                            return Container();
                          }

                          // snapshot.data![index].country.toString();
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
