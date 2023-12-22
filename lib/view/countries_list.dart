import 'package:covidapp/Services/stats_services.dart';
import 'package:covidapp/view/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StateService stateService = StateService();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  label: const Text(
                    "Search Countries",
                    style: TextStyle(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: stateService.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.grey,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 10,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 10,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ));
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                name: snapshot
                                                    .data![index]!['country'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                todayCases: snapshot
                                                    .data![index]['cases'],
                                                totalDeaths:
                                                    snapshot.data![index]
                                                        ['totalDeaths'],
                                                recovered: snapshot.data![index]
                                                    ['recovered'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                tests: snapshot.data![index]
                                                    ['tests'],
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                      height: 50.0,
                                      width: 50.0,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              ),
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            name: snapshot
                                                .data![index]!['country'],
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            todayCases: snapshot.data![index]
                                                ['cases'],
                                            totalDeaths: snapshot.data![index]
                                                ['totalDeaths'],
                                            recovered: snapshot.data![index]
                                                ['recovered'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                            tests: snapshot.data![index]
                                                ['tests'],
                                          )));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                      height: 50.0,
                                      width: 50.0,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
