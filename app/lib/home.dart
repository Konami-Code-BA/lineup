import 'package:flutter/material.dart';
import 'package:lineup/ui/components/maps/google_maps_widget.dart';

class LineupHomePage extends StatefulWidget {
  const LineupHomePage({super.key});

  @override
  State<LineupHomePage> createState() => _LineupHomePageState();
}

class _LineupHomePageState extends State<LineupHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMapsWidget(),
    );
  }
}
