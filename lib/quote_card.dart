import 'package:flutter/material.dart';
import 'package:quotes/quote.dart';

class QuoteCard extends StatelessWidget {
  Quote quote = Quote();
  VoidCallback delete = (){};
  QuoteCard({quote, delete}){
    this.quote = quote;
    this.delete = delete;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              quote.text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6),
            Text(
              quote.author,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            TextButton.icon(
              onPressed: (){
                delete();
              },
              icon: Icon(Icons.delete),
              label: Text("Delete"),
            )
          ],
        ),
      ),
    );
  }
}
