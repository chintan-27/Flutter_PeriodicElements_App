import 'package:flutter/material.dart';
import 'package:newapp/fadein.dart';

Color colorConvert(String color) {
  if (color.length == 6) {
    return Color(int.parse("0xFF"+color));
  } else if (color.length == 8) {
    return Color(int.parse("0x"+color));
  }
}

class Properties extends StatefulWidget {
  final String cpxcolor;
  final String atomicno;
  final String symbol;
  final String year;
  final double opacity;

  Properties(this.cpxcolor,this.atomicno,this.symbol,this.year,this.opacity);

  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {

   final BoxDecoration _boxDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
        colors: [const Color(0xFFFFFFFF), const Color(0xFFF3F3F3)],
      ),

      boxShadow: [
        BoxShadow(offset: Offset(7, 7),color: Color(0xFFd9d9d90),blurRadius: 10),
        BoxShadow(offset: Offset(-7, -7),color: Color(0xFFFFFFFF),blurRadius: 10)
      ],
      borderRadius: BorderRadius.all(Radius.circular(30.00))
  );

   final TextStyle _textStyle1 = TextStyle(
       fontSize: 40.00,
       fontFamily: 'Acme',
       color: Color(0xFFD92027)
   );

   final TextStyle _textStyle2 = TextStyle(
       fontSize: 15.00,
       fontFamily: 'Acme',
       color: Color(0xFFD92027)
   );

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Column(
            children: <Widget>[
                Container(
                  height: 100.00,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                  width: 100.00,
                  decoration:_boxDecoration,
                  child: Text(
                    widget.atomicno.toString(),
                    textAlign: TextAlign.center,
                    style: _textStyle1,
                  ),
                ),
              Container(
                width: 100.00,
                margin: EdgeInsets.all(10),
                child: Text(
                  "Atomic Number",
                  textAlign: TextAlign.center,
                  style: _textStyle2,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: 100.00,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                width: 100.00,
                decoration:BoxDecoration(
                    color: colorConvert(widget.cpxcolor),
                    boxShadow: [
                      BoxShadow(offset: Offset(7, 7),color: Color(0xFFd9d9d9),blurRadius: 10),
                      BoxShadow(offset: Offset(-7, -7),color: Color(0xFFFFFFFF),blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(30.00))
                ),
              ),
              Container(
                width: 100.00,
                margin: EdgeInsets.all(10),
                child: Text(
                  "CPK COLOR",
                  textAlign: TextAlign.center,
                  style: _textStyle2,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: 100.00,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                width: 100.00,
                decoration:_boxDecoration,
                child: Text(
                  widget.symbol,
                  textAlign: TextAlign.center,
                  style: _textStyle1,
                ),
              ),
              Container(
                width: 100.00,
                margin: EdgeInsets.all(10),
                child: Text(
                  "Symbol",
                  textAlign: TextAlign.center,
                  style: _textStyle2,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: 100.00,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 35,horizontal: 15),
                width: 100.00,
                decoration:_boxDecoration,
                child: Text(
                  widget.year.toString(),
                  textAlign: TextAlign.center,
                  style: _textStyle1.copyWith(
                    fontSize: 18.00

                  ),
                ),
              ),
              Container(
                width: 100.00,
                margin: EdgeInsets.all(10),
                child: Text(
                  "Discovered",
                  textAlign: TextAlign.center,
                  style: _textStyle2,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


