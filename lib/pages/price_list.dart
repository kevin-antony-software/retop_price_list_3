import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retop_price_list_3/pages/display_price_list.dart';

class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  String ProductTypeToPass = "Machine";
  String WeldingType = "MMA";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Machine'),
              Tab(text: 'Torch'),
              Tab(text: 'Torch Parts'),
              Tab(text: 'Consumables'),
            ],
          ),
          automaticallyImplyLeading: false,
          title: const Text('RETOP PRICE LIST'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              tooltip: 'Logout',
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        //body: DisplayPrices(),
        body: TabBarView(
          children: [
            DisplayPrices("Machine"),
            DisplayPrices("Torch"),
            DisplayPrices("TorchParts"),
            DisplayPrices("Consumables"),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: 'Machine',
        //         backgroundColor: Colors.green),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.search),
        //         label: 'Torch',
        //         backgroundColor: Colors.yellow),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Torch Parts',
        //       backgroundColor: Colors.blue,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Consumables',
        //       backgroundColor: Colors.blue,
        //     ),
        //   ],
        //   type: BottomNavigationBarType.fixed,
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.black,
        //   iconSize: 40,
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }
}
