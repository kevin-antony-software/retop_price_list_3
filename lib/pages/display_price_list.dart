import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../controller/machine.dart';

List<Machine> parseMachines(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Machine>((json) => Machine.fromJson(json)).toList();
}

Stream<List<Machine>> fetchMachines(
  http.Client client,
  Duration refreshTime,
) async* {
  await Future.delayed(refreshTime);
  final response = await client
      .get(Uri.parse('https://kevin-antony.com/jsonFiles/csvjson.json'));
  yield parseMachines(response.body);
}

class DisplayPrices extends StatefulWidget {
  const DisplayPrices(String this.machineType);

  // final productTypeToPass;
  final machineType;

  @override
  State<DisplayPrices> createState() => _DisplayPricesState(machineType);
}

class _DisplayPricesState extends State<DisplayPrices> {
  late Timer timer;
  int counter = 0;

  final machineType;
  //final productTypeToPass;
  _DisplayPricesState(this.machineType);
  int _selectedIndex = 0;
  String ProductTypeToPass = "Machine";

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 300), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
      counter++;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  //@override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        ProductTypeToPass = "Machine";
        print(ProductTypeToPass);
      } else {
        ProductTypeToPass = "Torch";
        print(ProductTypeToPass);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<List<Machine>>(
    //   future: fetchMachines(http.Client()),
    //print(productTypeToPass);

    return StreamBuilder(
      stream: fetchMachines(http.Client(), Duration(seconds: 1)),
      builder: (BuildContext context, AsyncSnapshot<List<Machine>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          final prices = <Machine>[];

          for (var item in snapshot.data!) {
            if (item.Machinetype == machineType) {
              if (item.productType == ProductTypeToPass) {
                prices.add(item);
              }
            }
          }

          return Scaffold(
            body: ListView.builder(
              itemCount: prices.length,
              prototypeItem: ListTile(
                title: Text("naame of machine"),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(prices[index].machineName),
                  leading: Image(
                    image: NetworkImage(prices[index].imageLink),
                  ),
                  trailing: Text(prices[index].price.toString()),
                );
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Machine',
                    backgroundColor: Colors.green),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Torch',
                    backgroundColor: Colors.yellow),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Torch Parts',
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Consumables',
                  backgroundColor: Colors.blue,
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              iconSize: 40,
              onTap: _onItemTapped,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
