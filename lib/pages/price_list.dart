import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../my_arc_icons_icons.dart';
import 'display_price_list.dart';

class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  String WeldingTypeToPass = "MMA";
  int _selectedIndex = 0;
  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        WeldingTypeToPass = "MMA";
      } else if (index == 1) {
        WeldingTypeToPass = "MIG";
      } else if (index == 2) {
        WeldingTypeToPass = "TIG";
      } else {
        WeldingTypeToPass = "PLASMA";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("RETOP PRICE LIST"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text(
                "Log out",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: DisplayPrices(WeldingTypeToPass),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(MyArcIcons.arcicon),
              label: 'MMA',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(MyArcIcons.migicon),
              label: 'MIG',
              backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
              icon: Icon(MyArcIcons.tigicon),
              label: 'TIG',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(MyArcIcons.plasmaicon),
            label: 'PLASMA',
            //backgroundColor: Colors.blue,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        elevation: 20,
        selectedItemColor: Colors.amber[800],
        iconSize: 30,
        onTap: _onItemTapped,
      ),
    );
  }
}
