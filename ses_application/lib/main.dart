import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SES',
      initialRoute: '/homepage',
      debugShowCheckedModeBanner: false,
      routes: {
        '/homepage': (context) => EngineeringSchoolHomepage(),
        // Define other routes for your application
      },
    );
  }
}
