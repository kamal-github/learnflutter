import 'dart:convert';
import 'package:http/http.dart'  as http;
import 'package:flutter/material.dart';
import 'package:jsonreader/model/pizza.dart';

class AddIntoMenu extends StatefulWidget {
  const AddIntoMenu({Key? key}) : super(key: key);

  @override
  State<AddIntoMenu> createState() => _AddIntoMenuState();
}

class _AddIntoMenuState extends State<AddIntoMenu> {
  final _formKey = GlobalKey<FormState>();
  Pizza pizza = Pizza();
  String statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pizza Menu"),),
      body: Center(
        child:
          Form(
            key: _formKey,
            child: Column(
              children: [
                Text(statusMessage),
                TextFormField(
                  onSaved: (value) {
                    pizza.pizzaName = value;
                  },
                ),
                ElevatedButton(onPressed: () {
                  _formKey.currentState?.save();
                  Future<void> f = _post();
                  f.then((_) {
                    setState(() {});
                  });
                  // Navigator.pop(context, pizza);
                }, child: const Text('Save'))
              ],
            ),
          ),
      ),
    );
  }

  Future<void> _post() async {
    String pizzaStr = jsonEncode(pizza.toJson());
    var authority = 'z05zg.mocklab.io';
    var uri = Uri.https(authority, '/pizzas');

    http.Response resp = await http.post(uri);

    if (resp.statusCode == 201) {
        statusMessage = 'Alles gut';
    } else {
      statusMessage = 'nicht gut';
    }
  }
}

