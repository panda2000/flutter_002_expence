import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {

  final Function _addNewTransactionsHandler;

  NewTransaction(this._addNewTransactionsHandler){
    print("Constructor NewTransaction");
  }

  @override
  _NewTransactionState createState(){
    print ('createState() NewTransaction');
    return _NewTransactionState();
  }

}

class _NewTransactionState extends State<NewTransaction>{
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState () {
    print("Constructor _NewTransactionState");
  }

  @override
  void initState() {
    print("initState() NewTransactionState");
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print("didUpdateWidget() NewTransactionState");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("dispose() NewTransactionState");
    super.dispose();
  }

  void _submitData () {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

//    print(enteredTitle);
//    print(enteredAmount);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      return;
    }

    widget._addNewTransactionsHandler(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker () {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now()
    ).then((pickedData){
      if(pickedData == null){
        return;
      }
      setState(() {
        _selectedDate = pickedData;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    print("build() NewTransactionState");

    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView (
       child: Card (
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 5,
            left: 5,
            right: 5,
            bottom: mediaQuery.viewInsets.bottom +10 ,
          ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField (
                decoration: InputDecoration (
                    labelText: "Title"
                ),
                controller: _titleController,
                /*onChanged: (val) {
                        titleInput = val;
                       },*/
              ),
              TextField (
                decoration: InputDecoration (
                    labelText: "Amount"
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                // onChanged: (val) => amountInput = val,
                onSubmitted: (_)=> _submitData(),
              ),
              Container (
                height: 70,
                child:Row(
                  children: <Widget>[
                    Expanded(
                      child:Text(
                          _selectedDate == null
                          ? 'No date Chose!'
                          : 'Picked Date ${DateFormat.yMd().format(_selectedDate)}'
                      ),
                    ),
                    AdaptiveFlatButton('Chose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton (
                child: Text ("Add Transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
