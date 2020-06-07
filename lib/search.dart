import 'package:flutter/material.dart';
import 'package:newapp/progres.dart' as p;
import 'package:newapp/progress.dart' as p1;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newapp/allprops.dart';
import 'package:newapp/fadein.dart';

String capitalize(String string) {
  if (string == null) {
    throw ArgumentError("string: $string");
  }

  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  Widget _widget = Container();
  final _myController = TextEditingController();
  String searchText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            child: FadeIn(1,Row(
              children: <Widget>[
                Expanded(child:
                TextFormField(
                  autofocus: true,
                  controller: _myController,
                  style: TextStyle(
                    fontFamily: 'Acme',
                    fontSize: 20,
                    color: Colors.blueAccent,
                  ),
                ),),
                IconButton(

                  icon: Icon(Icons.search),
                  padding: EdgeInsets.symmetric(vertical: 30.00,horizontal: 20.00),
                  iconSize: 30.00,
                  onPressed: () {
                    if (_myController.text != "") {
                      String a = _myController.text;
                      String b = capitalize(_myController.text.toLowerCase());
                      String c = _myController.text.toLowerCase();
                      setState(() {
                        _widget = FutureBuilder(
                          future: Future.wait([
                            http.get(
                                'https://neelpatel05.pythonanywhere.com/element/atomicnumber?atomicnumber=$a'),
                            http.get(
                                'https://neelpatel05.pythonanywhere.com/element/atomicname?atomicname=$b'),
                            http.get(
                                'https://neelpatel05.pythonanywhere.com/element/symbol?symbol=$b'),
                            http.get(
                                'https://neelpatel05.pythonanywhere.com/element/bondingtype?bondingtype=$c'),
                            http.get(
                                'https://neelpatel05.pythonanywhere.com/element/groupblock?groupblock=$c'),
                            http.get(
                                'https://neelpatel05.pythonanywhere.com/element/state?state=$c')
                          ]),
                          builder: (context,
                              AsyncSnapshot<List<dynamic>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return SearchList(snapshot.data);
                            } else {
                              return p.Progress();
                            }
                          },
                        );
                      });
                    }
                    _myController.clear();
                  },
                ),
              ],
            )
            ),
          ),
          _widget,
        ],
      ),
    );
  }
}

class SearchList extends StatefulWidget {
  var data;

   SearchList(this.data);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<String> name = [];
  List<String> symbol = [];
  int i;
@override
  void initState() {
    // TODO: implement initState
  if(jsonDecode(widget.data[0].body)['message'] != "does not exists"){
    name.add(jsonDecode(widget.data[0].body)['name']);
    symbol.add(jsonDecode(widget.data[0].body)['symbol']);
  }
  if(jsonDecode(widget.data[1].body)['message'] != "does not exists"){
    name.add(jsonDecode(widget.data[1].body)['name']);
    symbol.add(jsonDecode(widget.data[1].body)['symbol']);
  }
  if(jsonDecode(widget.data[2].body)['message'] != "does not exists"){
    name.add(jsonDecode(widget.data[2].body)['name']);
    symbol.add(jsonDecode(widget.data[2].body)['symbol']);
  }
  if(jsonDecode(widget.data[3].body).length == 1){

    if(jsonDecode(widget.data[3].body)['message'] == null) {
      for (int i = 0; i < jsonDecode(widget.data[3].body).length; i++) {
        name.add(jsonDecode(widget.data[3].body)[i]['name']);
        symbol.add(jsonDecode(widget.data[3].body)[i]['symbol']);
      }
    }
  }
  if(jsonDecode(widget.data[3].body).length > 1){
      for (int i = 0; i < jsonDecode(widget.data[3].body).length; i++) {
        name.add(jsonDecode(widget.data[3].body)[i]['name']);
        symbol.add(jsonDecode(widget.data[3].body)[i]['symbol']);
    }
  }
  if(jsonDecode(widget.data[4].body).length == 1){
    if(jsonDecode(widget.data[4].body)['message'] == null) {
      for (int i = 0; i < jsonDecode(widget.data[4].body).length; i++) {
        name.add(jsonDecode(widget.data[4].body)[i]['name']);
        symbol.add(jsonDecode(widget.data[4].body)[i]['symbol']);
      }
    }
  }
  if(jsonDecode(widget.data[4].body).length > 1){
    for (int i = 0; i < jsonDecode(widget.data[4].body).length; i++) {
      name.add(jsonDecode(widget.data[4].body)[i]['name']);
      symbol.add(jsonDecode(widget.data[4].body)[i]['symbol']);
    }
  }
  if(jsonDecode(widget.data[5].body).length == 1){
    if(jsonDecode(widget.data[5].body)['message'] == null) {
      for (int i = 0; i < jsonDecode(widget.data[5].body).length; i++) {
        name.add(jsonDecode(widget.data[5].body)[i]['name']);
        symbol.add(jsonDecode(widget.data[5].body)[i]['symbol']);
      }
    }
  }
  if(jsonDecode(widget.data[5].body).length > 1){
    for (i = 0; i < jsonDecode(widget.data[5].body).length; i++) {
      name.add(jsonDecode(widget.data[5].body)[i]['name']);
      symbol.add(jsonDecode(widget.data[5].body)[i]['symbol']);
    }
  }
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context,index){
          String _symbol = symbol[index];
          return FlatButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
//            _getData(symbol);
                    return FutureBuilder(
                      future: http.get('https://neelpatel05.pythonanywhere.com/element/symbol?symbol=$_symbol'),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.done){
                          return AllProps(snapshot.data,index%5);
                        }else{
                          return p1.Progress();
                        }
                      },
                    );
                  }
              ),);
            },
            child: FadeIn(0.5*index,Column(
              children: <Widget>[
                Container(height: 2,
                  width: double.infinity,
                  color: Colors.black26,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          name[index].toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Acme',
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          symbol[index],
                          style: TextStyle(
                            fontFamily: 'Acme',
                            fontWeight: FontWeight.w800,
                            fontSize: 30.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),

                Container(height: 2,
                  width: double.infinity,
                  color: Colors.black26,),
              ],
          ),
          )
          );
        },
      ),
    );
  }
}
