import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {

  const TransactionItem ({
    Key key,
    @required this.transaction,
    @required this.deleteTransactionHandler,
  }) : super (key : key);

  final Transaction transaction;
  final Function deleteTransactionHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple
    ];

    _bgColor = availableColors[Random().nextInt(availableColors.length)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card (
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child:ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
            radius: 30,
            child: Padding (
                padding: EdgeInsets.all(10),
                child:FittedBox(
                  child: Text('\$${widget.transaction.amount}'),
                )
            )
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMM().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460 ?
        FlatButton.icon (
          icon: Icon(Icons.delete),
          textColor: Theme.of(context).errorColor,
          label: Text ('Delete'),
          onPressed: () => widget.deleteTransactionHandler (widget.transaction.id) ,
        )
            : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: ()=> widget.deleteTransactionHandler(widget.transaction.id),
        ),
      ),
    );
  }
}

