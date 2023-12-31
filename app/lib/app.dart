import 'package:flutter/material.dart';
import 'package:lineup/home.dart';
import 'package:lineup/ui/pages/login_page.dart';

class LineupApp extends StatelessWidget {
  const LineupApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) {
          return LoginPage();
        },
        '/': (context) => const LineupHomePage()
      },
      // home: const LineupHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
