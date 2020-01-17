import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }

    widget.addTx(
      //widget. - Allows the properties of the widget class to be used in the state class
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              //onChanged: (val) => title= val;
              controller: _titlecontroller,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              //onChanged: (val) => amount = val;
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) =>
                  _submitData(), //(_) '_' underscore indicatess that we get an argument but we don't want to use it
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                                      child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed: _submitData,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
