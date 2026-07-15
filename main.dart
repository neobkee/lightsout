import 'dart:convert';
import 'package:flutter/material.dart';
import 'models.dart';
import 'tray_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(const MaterialApp(home: TrayScreen()));
}

class TrayScreen extends StatefulWidget {
  const TrayScreen({Key? key}) : super(key: key);

  @override
  _TrayScreenState createState() => _TrayScreenState();
}

class _TrayScreenState extends State<TrayScreen> {

  @override
  void initState() {
    super.initState();
    loadTrayDataStat(); //testing using static data
  }

  Map<String, dynamic>  jsData = new Map();

  Future<http.Response> fetchColor(String url) {
    return http.get(Uri.parse(url));
  }

  convert2JSON(http.Response response) {
    if (response.statusCode == 200) {
      setState(() {
        jsData = jsonDecode(response.body);
        print("from convert2JSON: ${jsData}");
      });
    }
  }


  Future<void> loadTrayData() async {
    try {
      print("************** Read loadTrayData");
      var response = await fetchColor('http://192.168.0.101:8080/');
      //var response = await fetchColor('http://127.0.0.1:8080');
      //var response = await fetchColor('https://api.data.gov.sg/v1/environment/air-temperature');

      if (response.statusCode == 200) {
        setState(() {
          jsData = jsonDecode(response.body);
          print("set jsData: {$jsData}");
        });
      }
      else {
        print('HTTP error: ${response.statusCode}');
      }
    }
    catch (e, st) {
      print('Fetch failed: $e');
      debugPrintStack(stackTrace: st);
    }
  }


/*
  loadTrayData() {
    fetchColor('http://192.168.0.107:8080/') //update the API call to cell 3
        .then((response) => {convert2JSON(response)});
  }
 */

  loadTrayDataStat() {
    //from static data (localhost)
    jsData = {
      "metadata":{
        "line":"3rd cell",
        "description":
        "Tray color detection",
        "timestamp":"2026-06-17 18:00:00"
      },
      "trays":[
        {"trayId":"T001",
          "location":"Station A",
          "boxes":{
          "positions":[
            {"position":1,"color":3},
            {"position":2,"color":3},
            {"position":3,"color":1},
            {"position":4,"color":1},
            {"position":5,"color":2},
            {"position":6,"color":3}]},
          "summary":{"red":2,"green":1,"blue":3,"empty":0},
          "status":"ok"}
      ]
    };
  }


  @override
  Widget build(BuildContext context) {

    var data = TrayResponse.fromJson(jsData);

    return Scaffold(
      appBar: AppBar(title: const Text("Tray Monitoring")),
      body: Column(
        children:[
          ElevatedButton(
            onPressed: () {
              setState(() {
                loadTrayData();
                print("from button press: ${jsData}");
              });
            },
            child: const Text('Read Tray'),
          ),
          Expanded(
            child:
            ListView.builder(
              itemCount: data.trays.length,
              itemBuilder: (context, index) {
                return TrayWidget(tray: data.trays[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}