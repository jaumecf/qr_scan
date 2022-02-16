import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    // Canviar per a anar canviant entre pantalles
    final currentIndex = uiProvider.selectedMenuOpt;

    // Empram el Provider de la BBDD
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    final PageController _pageController =
        PageController(initialPage: currentIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .esborrarTots();
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (nouIndex) {
          uiProvider.selectedMenuOpt = nouIndex;
          if (nouIndex == 0) {
            scanListProvider.carregaScansPerTipus('geo');
          } else {
            scanListProvider.carregaScansPerTipus('http');
          }
        },
        children: [
          MapasScreen(),
          DireccionsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int i) => _pageController.animateToPage(i,
            duration: Duration(milliseconds: 300), curve: Curves.ease),
        elevation: 0,
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Direccions',
          )
        ],
      ),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    // Canviar per a anar canviant entre pantalles
    final currentIndex = uiProvider.selectedMenuOpt;

    // Empram el Provider de la BBDD
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

/* Proves BBDD
    final tempScan = new ScanModel(valor: 'https://paucasesnovescifp.cat/');
    DBProvider.db.nuevoScan(tempScan);
    DBProvider.db.getScanById(19).then((value) {
      print(value!.valor);
    });
    DBProvider.db.getTodosLosScan().then(print);
 */
    final PageController _pageController =
        PageController(initialPage: currentIndex);
    return PageView(
      controller: _pageController,
      onPageChanged: (nouIndex) {
        uiProvider.selectedMenuOpt = nouIndex;
        if (nouIndex == 0) {
          scanListProvider.carregaScansPerTipus('geo');
        } else {
          scanListProvider.carregaScansPerTipus('http');
        }
      },
      children: [
        MapasScreen(),
        DireccionsScreen(),
      ],
    );
  }
}
