import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './new_transactions.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {


  @override
  Widget build(BuildContext context) {
    return Column (
      children: <Widget>[
        //NewTransaction(_addNewTransactions),
        //TransactionsList(_userTransactions),
      ],
    );
  }
}
