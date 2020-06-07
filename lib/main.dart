import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/elementcard.dart';
import 'package:newapp/properties.dart';
import 'package:newapp/progress.dart';
import 'dart:convert';
import 'package:newapp/fadein.dart';
import 'package:newapp/search.dart';


var data;
var realData;
ScrollController _scrollController;
String cpxcolor ;
String atomicno;
String symbol;
String year;
double opacity = 1;



void main() {
  runApp(MyApp());
}

void getData() async{
  http.Response response = await http.get('https://neelpatel05.pythonanywhere.com/');
  if(response.statusCode == 200){
   data = response.body;
   realData = jsonDecode(data);
  }else{
    print(response.statusCode);
  }
}

  Widget getListItem(int index, var data){
      Widget listItem;
      if(data != null) {
        listItem = ElementCard(
          data[index]['name'],
          data[index]['atomicNumber'].toString(),
          data[index]['symbol'],
          data[index]['groupBlock'],
          index % 5,
        );
      }else{
        listItem = ElementCard(
          "Hydrogen",
          "1",
          "H",
          "Nonmetal",
          index % 5,
        );
      }
      return listItem;
  }

    class MyApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
      future: http.get('https://neelpatel05.pythonanywhere.com/'),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          data = snapshot.data.body;
          realData = jsonDecode(data);
          return NewApp(realData);
        }else{
          return Progress();
        }
      },
    ),
    );
  }
}






class NewApp extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }
  List<String> names = ['gas','solid','liquid','metallic','covalent network','atomic','diatomic','metal','nonmetal','noble gas','metalloid','halogen','alkali metal','alkaline earth metal','transition metal','lanthanoid','actinoid','post-transition metal'];
  List<String> type = ['state','state','state','bondingtype','bondingtype','bondingtype','bondingtype','groupblock','groupblock','groupblock','groupblock','groupblock','groupblock','groupblock','groupblock','groupblock','groupblock','groupblock'];
  var _realdata;
  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  NewApp(this._realdata);

  @override
  _NewAppState createState() => _NewAppState();
}

class _NewAppState extends State<NewApp> with TickerProviderStateMixin{

  _scrollListener(){
    for(int i = 0;i<widget._realdata.length;i++){

      if(_scrollController.position.pixels >= (_scrollController.position.maxScrollExtent/widget._realdata.length)*i && _scrollController.position.pixels < (_scrollController.position.maxScrollExtent/widget._realdata.length)*(i+1)) {
        setState(() {
          if(widget._realdata != null) {
            atomicno = widget._realdata[i]['atomicNumber'].toString();
            dynamic abc = widget._realdata[i]['cpkHexColor'];
            if (abc is int && abc != 0) {
              cpxcolor = abc.toString();
            } else if (abc is double) {
              cpxcolor = abc.toString();
            } else if (abc is String && abc != "") {
              cpxcolor = abc;
            } else if (abc == "" && abc == 0) {
              cpxcolor = "ff9eaf";
            } else {
              cpxcolor = "00FF00";
            }
            symbol = widget._realdata[i]['symbol'];
            year = widget._realdata[i]['yearDiscovered'].toString();
          }else{
            atomicno = "1";
            symbol = "H";
            cpxcolor = "FFFFFF";
            year = "1766";
          }
        });
      }
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    cpxcolor = widget._realdata[0]['cpkHexColor'];
    atomicno = widget._realdata[0]['atomicNumber'].toString();
    symbol = widget._realdata[0]['symbol'];
    year = widget._realdata[0]['yearDiscovered'].toString();

    return MaterialApp(
        home: Scaffold(
          key: widget._scaffoldKey,
            backgroundColor: Colors.white,
            body:SafeArea(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  FadeIn(1,Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(

                        icon: Icon(Icons.search),
                        padding: EdgeInsets.symmetric(vertical: 30.00,horizontal: 20.00),
                        iconSize: 30.00,
                        onPressed: (){

                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return Search();
                              }
                          ));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.subject),
                        padding: EdgeInsets.symmetric(vertical: 30.00,horizontal: 20.00),
                        iconSize: 30.00,
                        onPressed: (){
                          widget._openEndDrawer();
                        },
                      )
                    ],
                  ),),
                  FadeIn(2,Container(
                      height: 570.00,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemCount: widget._realdata.length,
                        itemBuilder: (context,index){
                          return getListItem(index,widget._realdata);
                        },
                      ),
                    ),
                  ),
                  FadeIn(3, Properties(
                      cpxcolor=cpxcolor,
                      atomicno =atomicno,
                      symbol=symbol,
                      year =year,
                      opacity =opacity,
                    ),
                  )
                ],
              ),
            ),
          endDrawer: Drawer(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.blueAccent,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Elements',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Acme',
                            color: Colors.white,
                            fontSize: 50
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                      itemCount: widget.names.length,
                      itemBuilder: (context,index){
                        String name = widget.capitalize(widget.names[index]);
                        String name1 = widget.names[index];
                        String types = widget.type[index];
                        if(widget.type[index] == 'bondingtype'){
                          name = name + 'Bonding';
                        }
                        return FadeIn(0.5*index, FlatButton(
                            child: Container(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                      Text(
                                        name,
                                        style: TextStyle(
                                          fontFamily: 'Acme',
                                          color: Colors.black,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
//            _getData(symbol);
                                    return FutureBuilder(
                                      future: http.get('https://neelpatel05.pythonanywhere.com/element/$types?$types=$name1'),
                                      builder: (context,snapshot){
                                        if(snapshot.connectionState == ConnectionState.done){
                                          var realdata = jsonDecode(snapshot.data.body);
                                          return NewApp(realdata);
                                        }else{
                                          return Progress();
                                        }
                                      },
                                    );
                                  }
                              ),);
                            },
                          ),
                        );
                      },
                    ),
                ),
              ],
            ),
          ),
        )
    );
  }
}




