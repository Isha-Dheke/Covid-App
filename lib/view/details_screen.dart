import 'package:covidapp/view/worl_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int? todayCases,
      totalDeaths,
      recovered,
      todayRecovered,
      active,
      critical,
      tests;

  DetailScreen({
    required this.name,
    required this.image,
    required this.todayCases,
    required this.totalDeaths,
    required this.recovered,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.tests,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.black,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.11,
                    ),
                    Resuable(
                        title: "Today's Cases",
                        value: widget.todayCases.toString()),
                    Resuable(
                        title: "Total Deaths",
                        value: widget.totalDeaths.toString()),
                    Resuable(
                        title: "Recovered", value: widget.recovered.toString()),
                    Resuable(
                        title: "Today's Recovered",
                        value: widget.todayRecovered.toString()),
                    Resuable(title: "Active", value: widget.active.toString()),
                    Resuable(
                        title: "Critical", value: widget.critical.toString()),
                    Resuable(title: "Tests", value: widget.tests.toString()),
                  ],
                ),
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(widget.image),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
