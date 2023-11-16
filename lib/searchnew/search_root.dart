import 'package:flutter/material.dart';
import 'package:cash_flow/models/transactions/transaction_model.dart';
import 'package:cash_flow/searchnew/search_.dart';
import 'package:cash_flow/searchnew/searchtile.dart';

ValueNotifier<List<TransactionModel>> searchResult = ValueNotifier([]);

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            searchfield(),
            Expanded(
              child: SearchTiles(),
            ),
          ],
        ),
      ),
    );
  }
}
