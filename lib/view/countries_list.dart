import 'package:covid_tracking_app/Model/CountriesListModel.dart';
import 'package:covid_tracking_app/Services/states-services.dart';
import 'package:covid_tracking_app/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Search Country",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              onChanged: (val) {
                setState(() {});
              },
            ),
            Expanded(
                child: FutureBuilder(
                    future: StateServices().countriesList(),
                    builder: (context,
                        AsyncSnapshot<List<CountriesListModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name =
                                  snapshot.data![index].country.toString();
                              if (searchController.text.isEmpty) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                model: snapshot.data![index])));
                                  },
                                  leading: Image(
                                    image: NetworkImage(snapshot
                                        .data![index].countryInfo!.flag
                                        .toString()),
                                    width: 50,
                                    height: 50,
                                  ),
                                  title: Text(
                                      snapshot.data![index].country.toString()),
                                  subtitle: Text(
                                      snapshot.data![index].cases.toString()),
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                model: snapshot.data![index])));
                                  },
                                  leading: Image(
                                    image: NetworkImage(snapshot
                                        .data![index].countryInfo!.flag
                                        .toString()),
                                    width: 50,
                                    height: 50,
                                  ),
                                  title: Text(
                                      snapshot.data![index].country.toString()),
                                  subtitle: Text(
                                      snapshot.data![index].cases.toString()),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.blueGrey,
                                  highlightColor: Colors.white,
                                  child: ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.green,
                                    ),
                                    title: Container(
                                      height: 15,
                                      width: double.infinity,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 15,
                                      width: double.infinity,
                                      color: Colors.white,
                                    ),
                                  ));
                            });
                      }
                    }))
          ],
        ),
      )),
    );
  }
}
