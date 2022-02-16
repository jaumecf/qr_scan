import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancel·lar', false, ScanMode.QR);
        //final barcodeScanRes = 'https://paucasesnovescifp.cat/';
        final barcodeScanRes = 'geo:39.726113,2.913285';
        if (barcodeScanRes == '-1') {
          return;
        }

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        //scanListProvider.nouScan(barcodeScanRes);
        final nouScan = await scanListProvider.nouScan(barcodeScanRes);

        launchURL(context, nouScan);
      },
    );
  }
}
