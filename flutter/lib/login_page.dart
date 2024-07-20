import 'package:auto_notify/sign_up_page.dart';
import 'package:auto_notify/tabs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  var storage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storage = const FlutterSecureStorage();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      try {
        var response = await http.post(
            Uri.parse("http://192.168.0.188:3000/api/v1/users/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(reqBody));
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == "success") {
          var myToken = jsonResponse['token'];
          // print(myToken);
          await storage.write(key: 'jwt_token', value: myToken);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TabsScreen()));
        } else {
          print('Something went wrong ' + jsonResponse['message']);
        }
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password",
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
              ElevatedButton(onPressed: loginUser, child: Text("Submit")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}
