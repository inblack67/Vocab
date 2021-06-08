import 'package:flutter/material.dart';
import './random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    // const var
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red[600]),
      home: RandomWords()
    );
  }
}
