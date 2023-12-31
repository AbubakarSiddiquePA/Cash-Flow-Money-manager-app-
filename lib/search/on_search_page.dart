import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';

import 'package:cash_flow/models/category/category_model.dart';
import 'package:cash_flow/screens/home/screen_home.dart';
import 'package:cash_flow/search/view_all_card.dart';
import 'package:cash_flow/searchnew/search_root.dart';
import '../db/categorydb/category_db.dart';
import '../db/transactionsdb/transaction_db.dart';
import '../models/transactions/transaction_model.dart';

ValueNotifier<List<TransactionModel>> allList = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> showList = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> allTransactions = ValueNotifier([]);
ValueNotifier<String> transactiontype = ValueNotifier('All Transactions');
ValueNotifier<List<TransactionModel>> listToDisplay =
    ValueNotifier(TransactionDb.instance.transactionListNotifier.value);

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> allTransactions = ['All Transactions', 'Income', 'Expense'];
  // Variables for date range
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenHome()),
              );
            },
            icon: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: (() async {
                  allList.value =
                      await TransactionDb.instance.getAllTransactions();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const CustomSearch()));
                  // showSearch(context: context, delegate: CustomSearch());
                }),
                icon: const Icon(Icons.search)),
            //date range selection
            IconButton(
                onPressed: () {
                  showCustomDateRangePicker(
                    context,
                    dismissible: true,
                    minimumDate: DateTime(2010),
                    maximumDate: DateTime.now(),
                    endDate: _endDate,
                    startDate: _startDate,
                    onApplyClick: (start, end) {
                      setState(() {
                        // Your state change code here
                        _endDate = end;
                        _startDate = start;
                      });
                    },
                    onCancelClick: () {
                      setState(() {
                        // Your state change code here
                        _startDate = null;
                        _endDate = null;
                      });
                    },
                    backgroundColor: Colors.white,
                    primaryColor: Colors.black,
                  );
                },
                icon: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.white, Colors.grey]),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.blue,
                    ))),
            const SizedBox(width: 20),

            //testing for back button

            Row(
              children: [
                DropdownButton(
                  ////initially transaction type consists all , when we select items , then all transaction values in map (e )will iterate
                  ///on selected and all transactions becomes selected items hence in down condition transaction type
                  ///will be equal to all transaction if index [0],[1],[2] cz transaction type will be selected type
                  value: transactiontype.value,
                  items: allTransactions.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      transactiontype.value = newValue!;
                      transactiontype.notifyListeners();
                    });
                  },
                )
              ],
            )
          ],
          backgroundColor: const Color.fromARGB(255, 17, 163, 176),
        ),

        //incomeexpense filter plus daterange conditions
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: transactiontype,
                      //  without selecting date
                      builder: (context, value, _) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          if (_startDate == null || _endDate == null) {
                            if (transactiontype.value == allTransactions[0]) {
                              showList.value = listToDisplay.value;
                            } else if (transactiontype.value ==
                                allTransactions[1]) {
                              showList.value = listToDisplay.value
                                  .where((element) =>
                                      element.type == CategoryType.income)
                                  .toList();
                            } else {
                              showList.value = listToDisplay.value
                                  .where((element) =>
                                      element.type == CategoryType.expense)
                                  .toList();
                            }

                            //stratdate and end date is not null
                            //and include all dys
                          } else {
                            if (transactiontype.value == allTransactions[0]) {
                              showList.value = listToDisplay.value
                                  .where((element) =>
                                      element.date.isBefore(_endDate!
                                          .add(const Duration(days: 1))) &&
                                      element.date.isAfter(_startDate!
                                          .subtract(const Duration(days: 1))))
                                  .toList();
                            } else if (transactiontype.value ==
                                allTransactions[1]) {
                              showList.value = listToDisplay.value
                                  .where((element) =>
                                      element.type == CategoryType.income)
                                  .where((element) =>
                                      element.date.isBefore(_endDate!
                                          .add(const Duration(days: 1))) &&
                                      element.date.isAfter(_startDate!
                                          .subtract(const Duration(days: 1))))
                                  .toList();
                            } else {
                              showList.value = listToDisplay.value
                                  .where((element) =>
                                      element.type == CategoryType.expense)
                                  .where((element) =>
                                      element.date.isBefore(_endDate!
                                          .add(const Duration(days: 1))) &&
                                      element.date.isAfter(_startDate!
                                          .subtract(const Duration(days: 1))))
                                  .toList();
                            }
                          }
                        });

                        // return Container(child: TransactonTiles());

                        if (showList.value.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: SizedBox(
                              height: 200,
                              width: 250,
                              child: Center(
                                  child: Text(
                                'No results!',
                                style: TextStyle(color: Colors.red),
                              )),
                            ),
                          );
                        } else {
                          return ValueListenableBuilder(
                            valueListenable: showList,
                            builder: (context, transactionList, _) {
                              return viewAll(context, transactionList, _);
                            },
                          );
                        }
                      }))
            ])));
  }
}
