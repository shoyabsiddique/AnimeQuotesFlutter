import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes/quote.dart';
import 'package:quotes/quote_card.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MaterialApp(
    home: QuoteList()
  ));
}
class QuoteList extends StatefulWidget {
  const QuoteList({Key? key}) : super(key: key);

  @override
  State<QuoteList> createState() => _QuoteListState();
}
class _QuoteListState extends State<QuoteList> {
  String query = "";
  Future<void> getQuotes() async{
    Response response = await get(Uri.parse("https://animechan.vercel.app/api/quotes/"));
    List data = jsonDecode(response.body);
    quotes = [];
    setState(() {
      for(Map i in data){
        quotes.add(Quote(text: i['quote'], author: i['character']));
      }
    });
  }
  Future<void> searchQuotes(String query) async{
    this.query = query;
    Response response = await get(Uri.parse("https://animechan.vercel.app/api/quotes/anime?title=${query}"));
    List data = jsonDecode(response.body);
    quotes = [];
    setState(() {
      for(Map i in data){
        quotes.add(Quote(text: i['quote'], author: i['character']));
      }
    });
  }
  @override
  void initState() {
    getQuotes();
    super.initState();
  }
  List quotes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Quote List"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: (data){
                    searchQuotes(data);
                  },
                  decoration: InputDecoration(
                    labelText: "Search Anime",
                    suffix: Icon(Icons.search_rounded)
                  ),
                ),
              ),
              IconButton(
                  onPressed: (){
                    getQuotes();
                  },
                  icon: Icon(Icons.refresh)
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index){
                  return QuoteCard(
                    quote: quotes[index],
                    delete: (){
                      setState(() {
                        quotes.remove(quotes[index]);
                      });
                    },
                  );
                },
              itemCount: quotes.length,
            ),
          ),
        ],
      )
    );
  }
}