import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function transactionController;

  NewTransaction({required this.transactionController});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  late DateTime? _selectedDate = null;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'title'),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Choose!'
                          : DateFormat.yMd().format(_selectedDate!),
                    ),
                    AdaptiveFlatButton("Choose Date", _presentDatePicker)
                  ],
                ),
              ),
              !Platform.isIOS
                  ? CupertinoButton(
                      padding: EdgeInsets.all(15),
                      child: const Text('Add transaction'),
                      color: Theme.of(context).primaryColor,
                      // : Colors.white,
                      onPressed: () {
                        if (_titleController.text.isEmpty ||
                            _amountController.text.isEmpty ||
                            double.parse(_amountController.text) <= 0 ||
                            _selectedDate == null) {
                          return;
                        }

                        widget.transactionController(
                            _titleController.text,
                            double.parse(_amountController.text),
                            _selectedDate);
                        Navigator.of(context).pop();
                      },
                    )
                  : RaisedButton(
                      padding: EdgeInsets.all(20),
                      child: const Text('Add transaction'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_titleController.text.isEmpty ||
                            _amountController.text.isEmpty ||
                            double.parse(_amountController.text) <= 0 ||
                            _selectedDate == null) {
                          return;
                        }

                        widget.transactionController(
                            _titleController.text,
                            double.parse(_amountController.text),
                            _selectedDate);
                        Navigator.of(context).pop();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
