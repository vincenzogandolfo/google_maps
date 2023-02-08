import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  final Completer<GoogleMapController> googleMapController = Completer();

  void torreDiPisa() async {
    final controller = await googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(43.722952, 10.3944083),
          zoom: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Google Maps'),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: LatLng(42, 13),
          zoom: 5,
        ),
        onMapCreated: (controller) async {
          await Future.delayed(const Duration(seconds: 3));
          googleMapController.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: torreDiPisa,
        label: const Text('Torre di Pisa'),
      ),
    );
  }
}
