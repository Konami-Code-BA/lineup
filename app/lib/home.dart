import 'package:flutter/material.dart';
import 'package:lineup/components/maps/google_maps_widget.dart';

class LineupHomePage extends StatefulWidget {
  const LineupHomePage({super.key, required this.title});

  final String title;

  @override
  State<LineupHomePage> createState() => _LineupHomePageState();
}

class _LineupHomePageState extends State<LineupHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GoogleMapsWidget(),
    );
  }
}
