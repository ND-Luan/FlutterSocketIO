import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String src = "https://source.unsplash.com/user/c_v_r";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              Image.network(
                src,
                width: 500,
                height: 500,
              ),
              button("Accepct", () {
                print("Accpect!");
              }),
              button("Cancel", () {
                print("Cancel!");
              }),
            ]),
      ),
    );
  }

  Widget button(String title, onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      
      child: Container(
      
        height: 200,
        width: 150,
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: Colors.black),
        )),
      ),
    );
  }
}
