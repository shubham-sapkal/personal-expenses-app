import 'package:flutter/material.dart';


class NewTransaction extends StatefulWidget {
  final Function transactionController;

  NewTransaction({required this.transactionController});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 20),
              child: Text('Add transaction'),
              textColor: Colors.purple,
              onPressed: () {
                widget.transactionController(titleController.text,double.parse(amountController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
