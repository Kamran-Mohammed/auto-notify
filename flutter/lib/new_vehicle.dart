import 'dart:io';

import 'package:auto_notify/vehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewVehicle extends StatefulWidget {
  const NewVehicle({super.key});
  @override
  State<StatefulWidget> createState() {
    return _NewVehicle();
  }
}

class _NewVehicle extends State<NewVehicle> {
  final _plateNumberController = TextEditingController();
  final _nameController = TextEditingController();

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure to enter valid Title,Amount,Date and Category input."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure to enter valid Title,Amount,Date and Category input."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  void onAddVehicle(Vehicle vehicle) async {
    try {
      await http.post(
          Uri.parse("http://192.168.0.188:3000/api/v1/vehicles/register"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(vehicle));
      // var jsonResponse = jsonDecode(response.body);
    } catch (e) {
      _showDialog();
    }
  }

  void _submitVehicleData() {
    if (_nameController.text.trim().isEmpty ||
        _plateNumberController.text.trim().isEmpty) {
      _showDialog();
      return;
    }

    onAddVehicle(
      Vehicle(
          name: _nameController.text, plateNumber: _plateNumberController.text),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _plateNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _plateNumberController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("Plate Number"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _submitVehicleData,
                        child: const Text('Save Vehicle'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
