import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:shop_app/widgets/grocery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 32, 108, 100),
            surface: const Color.fromARGB(255, 32, 108, 100)),
        // scaffoldBackgroundColor: Color.fromARGB(255, 159, 134, 44),
        useMaterial3: true,
      ),
      home: const GroceryList(),
    );
  }
}
