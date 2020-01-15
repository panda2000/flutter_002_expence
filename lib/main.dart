import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import './models/transaction.dart';
import './widgets/new_transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
/*  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return MaterialApp (
      title: 'Personal Expenses',
      theme: ThemeData (
        primarySwatch: Colors.green,
        primaryColorDark: Colors.teal,
        accentColor:Colors.green,
        errorColor: Colors.lightGreen,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle (
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle (
            color: Colors.white,
          ),

        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle (
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  final List<Transaction> _userTransactions = [

    Transaction (
        id:'t1',
        title: "New Shoes",
        amount: 69.99,
        date: new DateTime.now()),
    Transaction (
        id:'t2',
        title: "New T-Short",
        amount: 54.39,
        date: new DateTime.now()),

  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
      print(state);
  }

  @override
  dispose(){
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
            Duration(
                days: 7
            )
        ),
      );
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransactions (String txTitle, double txAmount, DateTime chosenDate){
    final newTx = Transaction (
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString()
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction (String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction (BuildContext context) {
    showModalBottomSheet(
      context: context, builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child:  NewTransaction(_addNewTransactions),
          behavior: HitTestBehavior.opaque,
        );
      }
    );
  }


  List<Widget> _buildLandscapeContent(chart, txListWidget) {
    return [
      Row(
        children: <Widget>[
          Text ('Show Chart'),
          Switch.adaptive (
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val){
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart ? chart : txListWidget
    ];
  }

  List<Widget> _buildPortraitContetnt(MediaQueryData mediaQuery, AppBar appBar, txListWidget) {
    return [
      Container(
        height: (
            mediaQuery.size.height
                - appBar.preferredSize.height
                - mediaQuery.padding.top
        ) * 0.3,
        child: Chart(_recentTransactions)
      ), txListWidget
    ];
  }

  AppBar _buildMaterialAppBar () {
    return AppBar (
      title: Text ('Personal Expenses'),
      actions: <Widget>[
        IconButton (
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    print ('build() _MyHomePageState');

    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = _buildMaterialAppBar();

    final txListWidget = Container(
      height: (
          mediaQuery.size.height
              - appBar.preferredSize.height
              - mediaQuery.padding.top
      ) * 0.7,
      child: TransactionsList(_userTransactions, _deleteTransaction,),
    );

    final chart = Container(
      height: (
          mediaQuery.size.height
              - appBar.preferredSize.height
              - mediaQuery.padding.top
      ) * 0.7,
      child: Chart(_recentTransactions)
    );

    return Scaffold (
      appBar: appBar,
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(
                  chart,
                  txListWidget,
              ),
            if(!isLandscape)
              ..._buildPortraitContetnt(
                mediaQuery,
                appBar,
                txListWidget
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton (
        child: Icon (Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}




