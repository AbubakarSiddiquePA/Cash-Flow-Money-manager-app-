import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:cash_flow/models/transactions/transaction_model.dart';
import 'package:cash_flow/search/on_search_page.dart';
import 'package:cash_flow/searchnew/search_.dart';
import 'package:cash_flow/searchnew/search_root.dart';

const transactiondbName = 'transaction-Db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future deleteTransaction(String id);
  Future<void> editTransaction(TransactionModel obj);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactiondbName);
    await db.put(obj.id, obj);
  }

  Future refresh() async {
    final list = await getAllTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
    showList.notifyListeners();
    allList.notifyListeners();

    searchResult.notifyListeners();
    // transactionListNotifier.value.add(_list.);
    overViewListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(transactiondbName);

    return db.values.toList();
  }

  @override
  Future deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(transactiondbName);
    await db.delete(id);
    await refresh();

    searchQueryController.clear();
    overViewListNotifier.notifyListeners();

    listToDisplay.notifyListeners();
  }

  @override
  Future<void> editTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactiondbName);

    await db.put(obj.id, obj);

    await refresh();
    await getAllTransactions();

    listToDisplay.notifyListeners();
    overViewListNotifier.notifyListeners();
  }
}
