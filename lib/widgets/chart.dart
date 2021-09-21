import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      // print('Weekday: '+ DateFormat.E().format(weekDay).toString());
      // print('totalSum: $totalSum');

      return {
        'day': DateFormat.E().format(weekDay).toString(),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + double.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
      // child: Text('CHART!'),
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            // print('Spending amount 1 : ${double.parse(data['amount'].toString())/totalSpending} ');
            // print('Spending amount condition 1 : ${double.parse(data['amount'].toString())/totalSpending == null ? 0 : 1} ');
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'].toString(),
                spendingAmount: double.parse(data['amount'].toString()),
                spendingPercentTotal: totalSpending == 0.0? 0.0 : double.parse(data['amount'].toString())/totalSpending 
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
