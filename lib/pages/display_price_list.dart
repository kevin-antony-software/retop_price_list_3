import 'dart:async';

import 'package:expandable_group/expandable_group.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../controller/access_data.dart';
import '../controller/machine.dart';

class DisplayPrices extends StatefulWidget {
  const DisplayPrices(this.weldingType, {super.key});
  final String weldingType;

  @override
  State<DisplayPrices> createState() => _DisplayPricesState();
}

class _DisplayPricesState extends State<DisplayPrices> {
  _DisplayPricesState();

  late Timer timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 20), (Timer t) => addValue());
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchMachines(http.Client(), Duration(seconds: 1)),
      builder: (BuildContext context, AsyncSnapshot<List<Machine>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          final machines = <Machine>[];
          final torchSets = <Machine>[];
          final torchParts = <Machine>[];
          final consumables = <Machine>[];

          for (var item in snapshot.data!) {
            if (item.weldingType == widget.weldingType) {
              // prices.add(item);
              switch (item.productType) {
                case "Machine":
                  machines.add(item);
                  break;
                case "Torch":
                  torchSets.add(item);
                  break;
                case 'TorchParts':
                  torchParts.add(item);
                  break;
                case 'Consumables':
                  consumables.add(item);
                  break;
                default:
                  machines.add(item);
              }
            }
          }
          //print(prices.first.machineName);

          // print(prices[0].weldingtype);
          return Column(
            children: [
              ExpandableGroup(
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Machines"),
                ),
                items: _buildItems(context, machines),
              ),
              ExpandableGroup(
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Torch Sets"),
                ),
                items: _buildItems(context, torchSets),
              ),
              ExpandableGroup(
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Torch Parts"),
                ),
                items: _buildItems(context, torchParts),
              ),
              ExpandableGroup(
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Consumables"),
                ),
                items: _buildItems(context, consumables),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  List<ListTile> _buildItems(BuildContext context, List<Machine> items) => items
      .map((e) => ListTile(
            leading: Image(
              image: NetworkImage(e.imageLink),
            ),
            title: Text(e.machineName),
            trailing: Text(e.price.toString()),
          ))
      .toList();
}
