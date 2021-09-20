import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum=0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
              totalSum += recentTransactions[i].amount;
            }
      }

      // print('Weekday: '+ DateFormat.E().format(weekDay).toString());
      // print('totalSum: $totalSum');

      return {'day': DateFormat.E().format(weekDay).toString(), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
        // child: Text('CHART!'),
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[],
        ));
  }
}
