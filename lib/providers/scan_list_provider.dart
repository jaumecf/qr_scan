import 'package:flutter/material.dart';
import 'package:qr_scan/providers/db_provider.dart';

import '../models/scan_model.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  nouScan(String valor) async {
    final nouScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.inserScan(nouScan);
    // Assignam el ID de la BBDD al model

    nouScan.id = id;
    print('id des de provider: $id');
    if (tipusSeleccionat == nouScan.tipus) {
      this.scans.add(nouScan);
      notifyListeners();
    }
  }

  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans!];
    notifyListeners();
  }

  carregaScansPerTipus(String tipus) async {
    final scans = await DBProvider.db.getScansPerTipus(tipus);
    this.scans = [...scans!];
    this.tipusSeleccionat = tipus;
    notifyListeners();
  }

  esborrarTots() async {
    final scans = await DBProvider.db.deteleAllScans();
    this.scans = [];
    notifyListeners();
  }

  esborrarPerId(int id) async {
    final scans = await DBProvider.db.deteleScan(id);
    this.carregaScansPerTipus(this.tipusSeleccionat);
    // No realitzam un notify ja que el carregaScans... ja ho fa!
  }
}
