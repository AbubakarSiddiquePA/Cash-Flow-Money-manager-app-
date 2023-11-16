import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cash_flow/Menu/menu.dart';
import 'package:cash_flow/screens/addtransaction/screen_add_transaction.dart';
import 'package:cash_flow/screens/category/category_add_popup.dart';
import 'package:cash_flow/screens/category/screen_category.dart';
import 'package:cash_flow/screens/home/main_home.dart';

import '../../widgets/bottom_nav.dart';

ValueNotifier<bool> listTransitions = ValueNotifier(false);
ValueNotifier<bool> listCategory = ValueNotifier(false);

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    BalanceCard(),
    const ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      backgroundColor: const Color.fromARGB(255, 78, 76, 76),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: const Color.fromARGB(255, 17, 163, 176),
        // title: Text('Wealth Manager'),
        title: Row(
          children: <Widget>[
            Text(
              'Cash Flow',
              style: GoogleFonts.acme(),
            ),
            Image.asset(
              'lib/assets/images/image icon.png',
              fit: BoxFit.cover,
              width: 30,
              height: 40,
            ),
          ],
        ),

        centerTitle: true,
        actions: [
          ValueListenableBuilder(
            valueListenable: homeicon,
            builder: (context, icon, child) => icon
                //listgridview
                ? ValueListenableBuilder<bool>(
                    valueListenable: listTransitions,
                    builder: (context, value, child) {
                      if (value) {
                        return IconButton(
                            onPressed: () {
                              listTransitions.value = !listTransitions.value;
                            },
                            icon: Container(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [Colors.white, Colors.grey]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(
                                  Icons.grid_view,
                                  color: Colors.black,
                                )));
                      } else {
                        return IconButton(
                            onPressed: () {
                              listTransitions.value = !listTransitions.value;
                            },
                            icon: Container(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [Colors.white, Colors.grey]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(
                                  Icons.list,
                                  color: Colors.black,
                                )));
                      }
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: ScreenHome.selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (ScreenHome.selectedIndexNotifier.value == 0) {
            // ignore: avoid_print
            print('Add transaction');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routName);
          } else {
            // ignore: avoid_print
            print("Add category");
            showCategoryAddPopup(context);
          }
        },
        backgroundColor: const Color.fromARGB(255, 17, 163, 176),
        child: const Icon(Icons.add),
      ),
    );
  }
}
