import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

import '../providers/scan_list_provider.dart';

class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'http');
  }
}
