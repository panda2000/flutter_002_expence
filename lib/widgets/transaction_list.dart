
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransactionHandler;

  TransactionsList (this.transactions, this._deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {

    print ('build() TransactionsList');

    final mediaQuery = MediaQuery.of(context);

    return transactions.isEmpty ? LayoutBuilder (builder: (context, constraint) {
      return Column(
        children: <Widget>[
          Text(
            'No transactions Added yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.70,
            child : Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    },): ListView(
          children: transactions.map(
              (tx) => TransactionItem(
                key: ValueKey(tx.id),
                transaction : tx,
                deleteTransactionHandler: _deleteTransactionHandler
              )
          ).toList(),
    );
  }
}
