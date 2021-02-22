import 'dart:collection';

import 'package:flutter/material.dart';
import './numbercontrol.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: Home(), routes: {
      "home1": (context) => Home(),
    });
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

var data = <Map>[];

class Data {
  Map fetched_data = {
    "data": [
      {"id": 1, "name": "Player-Sangrin", "score": 4, "position": 0},
      {"id": 2, "name": "Player-Amber", "score": 3, "position": 0},
      {"id": 3, "name": "Player-Kaeya", "score": 2, "position": 0},
      {"id": 4, "name": "Player-Lisa", "score": 1, "position": 0},
      {"id": 5, "name": "Player-Jean", "score": 1, "position": 0},
    ],
    "final": data
  };

  List _data;
  List _result;
  final int high = 4;
  final int low = 0;
//function to fetch the data
  Data() {
    _data = fetched_data["data"];
    _result = fetched_data["final"];
  }
  void increment(int index, int value) {
    ///print(_data[index]["score"]);
    _data[index]["score"] = value;
    //return _data[index]["score"];
  }

  void leaderupdate() {
    // print(_data);
    // print(_data[1].runtimeType);
    // print(_data[1]);
    var range = [0, 1, 2, 3, 4];
    List<int> temp = [0, 0, 0, 0, 0];
    // print(temp);

    for (var i in range) {
      temp[i] = _data[i]["score"];
    }
    temp.sort();
    // print(temp.runtimeType);
    // print(temp);
    int high_score;

    for (var i in range) {
      high_score = temp[high - i];
      for (var j in range) {
        if (high_score == _data[j]["score"]) {
          _data[j]["position"] = (high - i);
        }
        ;
      }
      ;
    }

    data.clear();
    for (var i in range) {
      for (var j in range) {
        if (_data[j]["position"] == i) {
          data.add(_data[j]);
          //_result.add(_data[1]);
          // /
          print(data);
        }
      }
    }
    Map newdata1 = {"newdata": data};
    print(newdata1["data"]);
    _result = newdata1["newdata"];
    print(_result);
    // print(_result);
    // print(_result.runtimeType);
    // print(_data.runtimeType);
    // //_result[i - 1] = _data[j];
    // print(_data[1]["position"].runtimeType);
    // print(_result);
    // print(_data);
    //List _result = quickSort(_data, low, high);
  }

  int decrement(int index, int value) {
    //print(_data[index]["score"]);
    _data[index]["score"] = value;
  }

  int getId(int index) {
    return 4 - _result[index]["position"] + 1;
  }

  String getName(int index) {
    return _result[index]["name"];
  }

  int getScore(int index) {
    return _result[index]["score"];
  }

  int getLength() {
    return _data.length;
  }
}

class _HomeState extends State<Home> {
  Data _data = new Data();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                  padding: EdgeInsets.all(30),
                  height: 100,
                  width: 500,
                  child: Text(
                    "LeaderBoard",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  )),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(5.5),
                itemCount: _data.getLength(),
                itemBuilder: _itemBuilder,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5.5),
                itemCount: _data.getLength(),
                itemBuilder: _controlboard,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Card(
        child: Center(
          child: Row(children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: 60,
              width: 70,
              child: Text(
                "   ${_data.getId(index)})",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 60,
              width: 200,
              child: Text(
                "${_data.getName(index)}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              "${_data.getScore(index)} ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _controlboard(BuildContext context, int index) {
    return InkWell(
      child: Card(
        child: Center(
          child: Row(children: <Widget>[
            Container(
              height: 60,
              width: 200,
              padding: EdgeInsets.all(20),
              child: Text(
                "${_data.getName(index)}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 60,
              width: 100,
              child: new NumberInputWithIncrementDecrement(
                controller: new TextEditingController(),
                initialValue: _data.getScore(index),
                min: 1,
                max: 20,
                onIncrement: (value) {
                  // print(index);
                  _data.increment(index, value);
                  _data.leaderupdate();
                  setState(() {});
                },
                onDecrement: (value) {
                  _data.decrement(index, value);
                  _data.leaderupdate();

                  setState(() {});
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
