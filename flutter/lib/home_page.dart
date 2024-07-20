import 'package:auto_notify/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var storage;

  @override
  void initState() {
    super.initState();
    storage = new FlutterSecureStorage();
  }

  bool validateNumberPlate(String plate) {
    // Define the regex pattern
    final pattern = RegExp(r'^[A-Z]{2}\d{2}[A-Z]{1,3}\d{4}$');

    // Test the plate against the regex pattern
    return pattern.hasMatch(plate);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'AP09BH0417', border: OutlineInputBorder()),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (!validateNumberPlate(value)) {
                  return 'Wrong format entered';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await storage.deleteAll();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
