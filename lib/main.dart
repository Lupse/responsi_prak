import 'package:flutter/material.dart';
import 'package:responsi_124220137/screen/main_screen.dart';
import 'package:responsi_124220137/services/favorit_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: const MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
