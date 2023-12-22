import 'package:covidapp/Services/stats_services.dart';
import 'package:covidapp/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Modal/Worldstate.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateService stateService = StateService();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .08,
          ),
          FutureBuilder(
              future: stateService.fetchWorldStateRecored(),
              builder: (context, AsyncSnapshot<worldState> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                      controller: _controller,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Card(
                        color: Colors.grey[800],
                        margin: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Resuable(
                                title: "Total",
                                value: snapshot.data!.cases.toString()),
                            Resuable(
                                title: "Recovered",
                                value: snapshot.data!.recovered.toString()),
                            Resuable(
                                title: "Deaths",
                                value: snapshot.data!.deaths.toString()),
                            Resuable(
                                title: "Active",
                                value: snapshot.data!.active.toString()),
                            Resuable(
                                title: "Crtical",
                                value: snapshot.data!.critical.toString()),
                            Resuable(
                                title: "Todays Deaths",
                                value: snapshot.data!.todayDeaths.toString()),
                            Resuable(
                                title: "Todays Recovered",
                                value:
                                    snapshot.data!.todayRecovered.toString()),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountriesList()));
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Text(
                            "Track Countries",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          )),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ],
      )),
    );
  }
}

class Resuable extends StatelessWidget {
  final String title, value;
  const Resuable({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      )
    ]);
  }
}
