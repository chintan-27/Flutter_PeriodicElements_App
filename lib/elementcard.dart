import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/allprops.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/progress.dart';
//import 'dart:convert';
//
//
//var _data;
//var _realdata;
//
//void _getData(String symbol) async{
//  http.Response response = await http.get('https://neelpatel05.pythonanywhere.com/element/symbol?symbol=$symbol');
//  if(response.statusCode == 200){
//    _data = response.body;
//    _realdata = jsonDecode(_data);
//  }else{
//    print(response.statusCode);
//  }
//}

String capitalize(String string) {
  if (string == null) {
    throw ArgumentError("string: $string");
  }

  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}

class ElementCard extends StatelessWidget {
  final String atomicNumber;
  final String symbol;
  final String name;
  final String groupblock;
  final int index;
  ElementCard(this.name,this.atomicNumber,this.symbol,this.groupblock,this.index);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
//            _getData(symbol);
          return FutureBuilder(
            future: http.get('https://neelpatel05.pythonanywhere.com/element/symbol?symbol=$symbol'),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return AllProps(snapshot.data,index);
              }else{
                return Progress();
              }
            },
          );
          }
        ),);
      },
      child: Container(
            width: 335.00,
            height: 500.00,
            padding: EdgeInsets.all(40.00),
            margin: EdgeInsets.symmetric(horizontal: 40.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: 'Logo${index.toString()}',
                        child: Container(
                          width: 75.00,
                          height: 75.00,
                          child: Text(
                            symbol,
                            textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 45.00,
                            fontFamily: 'Acme',
                            color: Colors.white,
                          ),),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.00)),
                            color: Color(0x770000000),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.00,),
                      Text(
                        atomicNumber,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Acme',
                          color: Colors.white,
                          fontSize: 25.00,

                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.00,),
                  Text(
                    capitalize(groupblock),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.00,
                      fontFamily: 'Acme'
                    ),
                  ),
                  SizedBox(height: 20.00,),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.00,
                      color: Colors.white,
                      fontFamily: 'Acme',
                    ),
                  )
                ],
              ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.00),
              image: DecorationImage(
                image: AssetImage('images/$index.jpg'),
              ),
            ),
          ),
    );
  }
}
