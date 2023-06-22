import 'package:covid_tracking_app/Model/CountriesListModel.dart';
import 'package:flutter/material.dart';

import 'widgets/reusable_row.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.model}) : super(key: key);
  final CountriesListModel model;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        title: Text(widget.model.country.toString()),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.065, horizontal: size.width * 0.03),
              child: Card(
                elevation: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    SizedBox(height: size.height*0.07,),
                    ReusableRow(title: "Total Cases", value: int.parse(widget.model.cases.toString())),
                    ReusableRow(title: "Active cases", value:int.parse(widget.model.active.toString())),
                    ReusableRow(title: "Critical cases", value:int.parse(widget.model.critical.toString())),
                    ReusableRow(title: "Recovered cases", value: int.parse(widget.model.recovered.toString())),
                    ReusableRow(title: "Deaths", value: int.parse(widget.model.deaths.toString())),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(widget.model.countryInfo!.flag.toString()),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
