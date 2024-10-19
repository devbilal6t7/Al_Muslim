import 'package:al_muslim/providers/category_provider.dart';
import 'package:al_muslim/providers/favorites_provider.dart';
import 'package:al_muslim/providers/names_provider.dart';
import 'package:al_muslim/screens/navigation/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NameProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child:  const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainNavigationScreen(),
      ),
    );
  }
}

