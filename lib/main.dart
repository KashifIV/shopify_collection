import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopify_collection/view_model.dart';
import 'package:shopify_collection/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ViewModel>(
      model: ViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Shopify Collection',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage()
      )
    );
  }
}

