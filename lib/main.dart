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
  // Controller che permette i cambiamenti, simile a setState
  final Completer<GoogleMapController> googleMapController = Completer();

  // Metodo chiamato dal Button che cambia le coordinate della Mappa
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
        // Tipo di Mappa utilizzata, hybrid mostra Satellite e Indicazioni
        mapType: MapType.hybrid,
        // Disabilitati i tasti di Zoom (+ -)
        zoomControlsEnabled: false,
        // Disabilitato il tasto che trova la Mia Posizione
        myLocationButtonEnabled: false,
        // Posizione iniziale della Mappa
        initialCameraPosition: const CameraPosition(
          target: LatLng(42, 13),
          zoom: 5,
        ),
        onMapCreated: (controller) async {
          // Tempo trascorso fra il click e la nuova Mappa
          await Future.delayed(const Duration(seconds: 3));
          googleMapController.complete(controller);
        },
      ),
      // Pulsante che permette il cambio di Coordinate
      floatingActionButton: FloatingActionButton.extended(
        onPressed: torreDiPisa,
        label: const Text('Torre di Pisa'),
      ),
    );
  }
}
