import 'package:auto_notify/alerts.dart';
import 'package:auto_notify/home_page.dart';
import 'package:auto_notify/login_page.dart';
import 'package:auto_notify/new_vehicle.dart';
import 'package:auto_notify/vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  String? token;
  var storage;

  @override
  void initState() {
    super.initState();
    storage = new FlutterSecureStorage();
    _checkUser();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _checkUser() async {
    token = await storage.read(key: 'jwt_token');
    if (token == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    // setState(() {});
  }

  void _openModalBottomSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewVehicle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomePage();
    var activePageTitle = 'Auto Notify Home';
    if (_selectedPageIndex == 1) {
      activePage = Alerts();
      activePageTitle = "Alerts";
    } else if (_selectedPageIndex == 2) {
      activePage = VehicleScreen();
      activePageTitle = "Vehicles";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_alert_sharp), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_on_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.garage), label: ''),
        ],
      ),
      floatingActionButton: _selectedPageIndex == 2
          ? FloatingActionButton.small(
              foregroundColor: Colors.white,
              backgroundColor: (Colors.black),
              onPressed: _openModalBottomSheet,
              child: const Icon(Icons.add),
            )
          : Text(""),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
