import 'package:auto_notify/alerts.dart';
import 'package:auto_notify/home_page.dart';
import 'package:auto_notify/login_page.dart';
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
  String? token;
  var storage;

  @override
  void initState() {
    super.initState();
    storage = new FlutterSecureStorage();
    _checkUser();
  }

  int _selectedPageIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    print(token);
    Widget activePage = HomePage();
    var activePageTitle = 'Auto Notify Home';
    if (_selectedPageIndex == 1) {
      activePage = Alerts();
      activePageTitle = "Alerts";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      // drawer: MainDrawer(onSelectScreen: _selectScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_alert_sharp), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_on_rounded), label: ''),
        ],
      ),
    );
  }
}
