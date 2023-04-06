import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weatherappassignment/ViewModel/weather_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var date = DateFormat('yMMMMd').format(DateTime.now());
  TextEditingController searchcontroller = TextEditingController();
  WeatherViewModel newsListViewModel = WeatherViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          date,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          /*textfield portion start here*/
          TextField(
            controller: searchcontroller,
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                color: Colors.black,
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.document_scanner_outlined),
              ),
            ),
          ),
          /*textfield portion end here*/
          Expanded(
            child: FutureBuilder(
                future:
                    newsListViewModel.fetchWorldRecords(searchcontroller.text),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Column(children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          );
                        });
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          /*second portion start here*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'images/01d.png',
                                height: 80,
                                width: 80,
                                scale: 1,
                              ),
                              FittedBox(
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: snapshot.data.main.temp.toString(),
                                    style: TextStyle(
                                      fontSize: 45,
                                      fontFamily: 'poppins',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: snapshot.data.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'poppins',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ])),
                              ),
                            ],
                          ),
                          /*second portion end here*/
                          /*third portion start here*/

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 200,
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  padding: EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Scattered Weather In',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          /*third portion end here*/
                          SizedBox(
                            height: 10,
                          ),
                          /*forth portion start here*/
                          Row(
                            children: [
                              ReuseableContainer(
                                  txt: 'Clouds',
                                  img: 'clouds.png',
                                  data:
                                      '${snapshot.data.clouds.all.toString()} %'),
                              ReuseableContainer(
                                  txt: 'Humdity',
                                  img: 'humidity.png',
                                  data:
                                      '${snapshot.data.main.humidity.toString()} %'),
                              ReuseableContainer(
                                  txt: 'WindSpeed',
                                  img: 'windspeed.png',
                                  data:
                                      '${snapshot.data.wind.speed.toString()} /hm/h'),
                            ],
                          ),
                          /*forth portion end here*/
                          SizedBox(
                            height: 10,
                          ),
                          /*fifth portion start here*/
                          Row(
                            children: [
                              ReuseableContainer(
                                  txt: 'Pressure',
                                  img: 'pressure.jpg',
                                  data:
                                      '${snapshot.data.main.pressure.toString()} pa'),
                              ReuseableContainer(
                                  txt: 'Temp Max',
                                  img: 'temp.jpg',
                                  data:
                                      '${snapshot.data!.main.tempMax.toString()} C'),
                              ReuseableContainer(
                                  txt: 'Temp Min',
                                  img: 'temp.jpg',
                                  data:
                                      '${snapshot.data!.main.tempMin.toString()} C'),
                            ],
                          ),
                          /*fifth portion end here*/
                        ],
                      ),
                    );
                  }
                }),
          ),
        ]),
      ),
    );
  }
}

class ReuseableContainer extends StatelessWidget {
  String txt, img, data;
  ReuseableContainer(
      {super.key, required this.txt, required this.img, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(14),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            txt,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            'images/$img',
            height: 60,
            width: 60,
          ),
          Text(
            '$data ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );

    /*third portion end here*/
  }
}
