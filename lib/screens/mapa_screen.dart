import 'package:flutter/material.dart';

import '../models/scan_model.dart';

class MapaScreen extends StatelessWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: Center(child: Text('Home Screen')),
    );
  }
}
