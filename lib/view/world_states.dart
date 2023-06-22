import 'package:covid_tracking_app/Services/states-services.dart';
import 'package:covid_tracking_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();

  }

  List<Color> cols = [Colors.red, Colors.green, Colors.blue];
  StateServices services = StateServices();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future:services.worldStatesRecord(),
            builder: (context,snapshot){
          if(snapshot.hasData){
            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                PieChart(
                  //centerText: "Case\ncarts\n",
                  chartValuesOptions: const ChartValuesOptions(
                      // chartValueBackgroundColor: Colors.grey,
                      // showChartValuesOutside: true,
                      showChartValuesInPercentage: true,
                  ),
                  //legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                    animationDuration: const Duration(seconds: 2),
                    colorList: cols,
                    chartRadius: size.width * 0.4,
                    //baseChartColor: Colors.black54,
                    // gradientList: const [
                    //   [Colors.yellow, Colors.indigo],
                    //   [Colors.red, Colors.black54],
                    //   [Colors.deepPurple, Colors.teal],
                    // ],
                    chartType: ChartType.ring,
                    dataMap:  {
                      "Active cases": double.parse(snapshot.data!.active.toString()),
                      "Recovered cases": double.parse(snapshot.data!.recovered.toString()),
                      "Deaths": double.parse(snapshot.data!.deaths.toString())
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.03, horizontal: size.width * 0.05),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children:  [
                        ReusableRow(title: "Total Cases", value: int.parse(snapshot.data!.cases.toString())),
                        ReusableRow(title: "Active cases", value:int.parse(snapshot.data!.active.toString())),
                        ReusableRow(title: "Recovered cases", value: int.parse(snapshot.data!.recovered.toString())),
                        ReusableRow(title: "Deaths", value: int.parse(snapshot.data!.deaths.toString())),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                  },
                  height: 50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.green,
                  minWidth: size.width * 0.9,
                  child: const Text("Track Countries"),
                )
              ],
            );
          }else{
            return SpinKitFadingCube(
              color: Colors.white,
              size: 50,
              controller: _controller,
            );
          }
        }),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
   ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value.toString()),
            ],
          ),
          const Divider(thickness: 1.2),
        ],
      ),
    );
  }
}
