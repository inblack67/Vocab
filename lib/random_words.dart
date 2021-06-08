import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{

  final _randomWordPairs = <WordPair>[]; // list of word pairs
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if(item.isOdd) return Divider();
        final index = item ~/ 2;
        if(index >= _randomWordPairs.length){
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_randomWordPairs[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair){
    final saved = _savedWordPairs.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
      trailing: Icon(saved ? Icons.favorite : Icons.favorite_border, color: saved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (saved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
          return ListTile(
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0))
          );
        });
        final List<Widget> divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

        return Scaffold(
          appBar: AppBar(title: Text('Vocab Close To Heart',),),
          body: ListView(children: divided,),
        );

      })
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Vocab'),
          actions: <Widget>[
            IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
          ],
        ),
        body: _buildList()
      );
  }
}
