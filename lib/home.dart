import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map advice = {};
  bool isLoading = true;
  Future getAdvice() async {
    isLoading = true;
    var response =
        await http.get(Uri.parse('https://api.adviceslip.com/advice'));
    advice = jsonDecode(response.body);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdvice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getAdvice();
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: Text('Life Tips'),
      ),
      body: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Card(
              color: Colors.greenAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tip of the day',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  isLoading == true
                      ? const CircularProgressIndicator()
                      : Card(child: Text(advice['slip']['advice'])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
