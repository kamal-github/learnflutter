import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jsonreader/model/pizza.dart';
import 'add_pizza.dart';
import 'package:http/http.dart'  as http;

void main() => runApp(const JSONReader());

class JSONReader extends StatelessWidget {
  const JSONReader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity
            .adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pizzaList = <Pizza>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pizza Menu"),),
      body: FutureBuilder(
        future: _getPizzaList(),
        builder: (context, pizzas) {
          if (pizzas.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: pizzas.data == null ? 0: pizzas.data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                      title: Text(pizzas.data[i].pizzaName),
                      subtitle: Text(pizzas.data[i].description +' - € ' + pizzas.data[i].price.toString())
                  );
                },
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Add into Menu"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddIntoMenu()));
                  },
                ),
              )
            ],
          );
        },
      )
    );
  }

  Future _getPizzaList() async {
    // String p = await DefaultAssetBundle.of(context).loadString('assets/pizzalist.json');
    var authority = 'z05zg.mocklab.io';
    var uri = Uri.https(authority, '/pizzas');

    http.Response resp = await http.get(uri);

    if (resp.statusCode == 200) {
      List decodedJSON = jsonDecode(resp.body);
      List pizzas = [];

      for (var item in decodedJSON) {
        pizzas.add(Pizza.fromJson(item));
      }

      return pizzas;
    }
  }
}

