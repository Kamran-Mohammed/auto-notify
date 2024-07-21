import 'package:auto_notify/tabs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool _isNotValidate = false;
  var storage;

  @override
  void initState() {
    super.initState();
    storage = const FlutterSecureStorage();
  }

  void signUp() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordConfirmController.text.isNotEmpty) {
      var regBody = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "passwordConfirm": passwordConfirmController.text
      };
      var response = await http.post(
          Uri.parse("http://192.168.0.104:3000/api/v1/users/signup"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse['status']);
      if (jsonResponse['status'] == "success") {
        var myToken = jsonResponse['token'];
        print(myToken);
        await storage.write(key: 'jwt_token', value: myToken);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TabsScreen()));
      } else {
        print("SomeThing Went Wrong " + jsonResponse['message']);
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
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
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Name",
                    // errorText: _isNotValidate ? "Enter Proper Info" : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                    // errorText: _isNotValidate ? "Enter Proper Info" : null,
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
                    // errorText: _isNotValidate ? "Enter Proper Info" : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
              TextField(
                controller: passwordConfirmController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password Confirm",
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
              ElevatedButton(onPressed: signUp, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
