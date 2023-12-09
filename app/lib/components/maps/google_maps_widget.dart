import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  const GoogleMapsWidget({super.key});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  GoogleMapController? mapController; // Controller for Google map
  Position? currentPosition; // Current position of the device
  bool loading = true; // Flag to check if the location is still loading
  TextEditingController placeController = TextEditingController();
  final TextEditingController _autocompleteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> countries = [
    'United States',
    'Canada',
    'India',
    'Australia',
    'United Kingdom',
    'Germany',
    // Add more countries...
  ];

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  // Function to determine the current position
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => loading = false);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => loading = false);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => loading = false);
      return Future.error(
          'Location permissions are permanently denied; we cannot request permissions.');
    }

    // When permissions are granted, get the current position
    currentPosition = await Geolocator.getCurrentPosition();
    setState(() => loading = false);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentPosition!.latitude, currentPosition!.longitude),
                  zoom: 14.0,
                ),
                myLocationEnabled: currentPosition == null ? false : true,
                myLocationButtonEnabled: true,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.7),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Form(
                  key: _formKey,
                  child: TypeAheadField<String>(
                    builder: (context, controller, focusNode) {
                      return TextField(
                        controller: _autocompleteController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _autocompleteController.clear();
                              });
                            },
                          ),
                          labelText: 'Search',
                          filled: true,
                          fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor
                                  ?.withOpacity(0.5) ??
                              Colors.deepOrange[
                                  100], // Default color if fillColor is null
                        ),
                      );
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSelected: (suggestion) {
                      // Set the text of the TextField to the selected suggestion
                      setState(() {
                        _autocompleteController.text = suggestion;
                        print('Selected country: $suggestion');
                      });
                    },
                    suggestionsCallback: (pattern) {
                      return countries
                          .where((country) => country
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                  ),
                ),
              ),

              // SearchAnchor(
              //     builder: (BuildContext context, SearchController controller) {
              //   return SearchBar(
              //     controller: controller,
              //     padding: const MaterialStatePropertyAll<EdgeInsets>(
              //         EdgeInsets.symmetric(horizontal: 16.0)),
              //     onTap: () {
              //       controller.openView();
              //     },
              //     onChanged: (_) {
              //       controller.openView();
              //     },
              //     leading: const Icon(Icons.search),
              //   );
              // }, suggestionsBuilder:
              //         (BuildContext context, SearchController controller) {
              //   return List<ListTile>.generate(5, (int index) {
              //     final String item = 'item $index';
              //     return ListTile(
              //       title: Text(item),
              //       onTap: () {
              //         setState(() {
              //           controller.closeView(item);
              //         });
              //       },
              //     );
              //   });
              // }),
            ],
          );
  }
}
