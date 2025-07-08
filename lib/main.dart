import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/tag_controller.dart';
import 'views/tag_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TagController(),
      child: MaterialApp(
        title: 'Tags WordPress',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TagView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}