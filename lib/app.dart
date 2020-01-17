import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transactions.dart';
import './widgets/transactionlist.dart';

import './models/transaction.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  
                ),
                button: TextStyle(color: Colors.white,),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'New Gloves', amount: 39.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {  // where method on a list- allows to run a function on every item on the list and if the function returns true the function is kept in a newly returned list.
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      //Subtracts 7 Days from Todays 
    }).toList();
  }

  void _addNewTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newTransaction = Transaction(
        title: txtitle,
        amount: txamount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id){
      setState(() {
        _transactions.removeWhere((tx) => tx.id == id);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense',
          style: TextStyle(
            fontFamily: 'OpenSans',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
