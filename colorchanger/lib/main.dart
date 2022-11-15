import 'package:flutter/material.dart';

void main() {
  runApp(const ColorChanger());
}

class ColorChanger extends StatelessWidget {
  const ColorChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen()
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  MaterialColor color = Colors.grey;

  Future _navigateAndWaitForColor(BuildContext context) async {
    color = await showDialog(barrierDismissible: false, context: context, builder: (context) {
      return const DialogScreen();
    });

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(title: const Text("First Screen"),),
      body: Center(
        child: ElevatedButton(
          child: const Text("Change Background"),
          onPressed: () {
           var c = _navigateAndWaitForColor(context);
           c.then((value) => setState(() {
             color = value;
           }));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {
          color = Colors.red;
          Navigator.pop(context, color);
        }, child: const Text("RED")),
        ElevatedButton(onPressed: () {
          color = Colors.green;
          Navigator.pop(context, color);
        }, child: const Text("GREEN")),
        ElevatedButton(onPressed: () {
          color = Colors.blue;
          Navigator.pop(context, color);
        }, child: const Text("BLUE")),
      ],
    );
  }
}

class DialogScreen extends StatelessWidget {
  const DialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose one color"),
      content: Text("On click, bg color will change"),
      actions: [
        TextButton(
          child: Text("RED"),
          onPressed: () {
            Navigator.pop(context, Colors.red);
          },
        ),
        TextButton(
          child: Text("GREEN"),
          onPressed: () {
            Navigator.pop(context, Colors.green);
          },
        ),
        TextButton(
          child: Text("PINK"),
          onPressed: () {
            Navigator.pop(context, Colors.pink);
          },
        ),
      ],
    );
  }
}



