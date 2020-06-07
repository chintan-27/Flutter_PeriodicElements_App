import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:newapp/fadein.dart';

Color colorConvert(String color) {
  if (color.length == 6) {
    return Color(int.parse("0xFF"+color));
  } else if (color.length == 8) {
    return Color(int.parse("0x"+color));
  }
}
String checkNull(String text){
  if(text == ""){
    return "-";
  }else{
    return text;
  }
}

String checkType(var text){
  if(text is int || text is double){
    return text.toString();
  }else if(text is String){
    if(text == ""){
      return "-";
    }else{
      return text;
    }
  }else{
    return "-";
  }
}

TextStyle _textStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Acme',
  fontSize: 25,
);

Row _row(String label, String text) {
  return Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[
  Text(
  label,
  style: _textStyle,
  ),
  Text(
  text,
  style: _textStyle.copyWith(
  fontWeight: FontWeight.bold,
  ),
  )
  ],
  );
}

ListView _listView(String label, String text) {
  return ListView(
    scrollDirection: Axis.horizontal,
    children: <Widget>[
      Text(
        label,
        style: _textStyle,
      ),
      Text(
        text,
        style: _textStyle.copyWith(
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}


SizedBox _line =   SizedBox(
  height: 2,
  child: DecoratedBox(decoration: BoxDecoration(
      color: Colors.white
  ),
  ),
);

SizedBox _space = SizedBox(
  height: 10,
);
String g;

class AllProps extends StatelessWidget {
  var realdata;
  int index;
  AllProps(@required this.realdata,@required this.index);


  @override
  Widget build(BuildContext context) {
  var data = jsonDecode(realdata.body);
  String symbol = data['symbol'];
  var atomicMass = data['atomicMass'].toString();
  String name = data['name'];
  String atomicRadius = checkType(data['atomicRadius']);
  String atomicno = data['atomicNumber'].toString();
  String boilingPoint = checkType(data['boilingPoint']);

  if(!(atomicMass is String)){
    atomicMass = atomicMass[0];
  }


  String cpxcolor;
  var abc = data['cpkHexColor'];
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

  String bondingType = checkNull(data['bondingType']);
  String density = checkType(data['density']);
  String electronAffinity = checkType(data['electronAffinity']);
  String electronegativity = checkType(data['electronegativity']);
  String electronicConfiguration = checkType(data['electronicConfiguration']);
  String groupBlock = checkType(data['groupBlock']);
  String ionRadius = checkType(data['ionRadius']);
  String ionizationEnergy = checkType(data['ionizationEnergy']);
  String meltingPoint = checkType(data['meltingPoint']);
  String oxidationStates = checkType(data['oxidationStates']);
  String standardState = checkType(data['standardState']);
  String vanDelWaalsRadius = checkType(data['vanDelWaalsRadius']);
  String yearDiscovered = checkType(data['yearDiscovered']);





  return ShowProps(index,atomicMass,name,atomicno,
      atomicRadius,boilingPoint,cpxcolor,bondingType,density,electronAffinity,
      electronegativity,electronicConfiguration,groupBlock,ionRadius,
      ionizationEnergy,meltingPoint,oxidationStates,standardState,
      vanDelWaalsRadius,yearDiscovered,symbol);
  }
}


class ShowProps extends StatelessWidget {
  final int _index;
  final String _atomicMass;
  final String _name;
  final String _atominco;
  final String _symbol;
  final String _atomicRadius;
  final String _boilingPoint;
  final String _cpxcolor;
  final String _bondingType;
  final String _density;
  final String _electronAffinity;
  final String _electronegativity;
  final String _electronicConfiguration;
  final String _groupBlock;
  final String _ionRadius;
  final String _ionizationEnergy;
  final String _meltingPoint;
  final String _oxidationStates;
  final String _standardState;
  final String _vanDelWaalsRadius;
  final String _yearDiscovered;
  ShowProps(this._index,this._atomicMass,this._name,this._atominco,this._atomicRadius,this._boilingPoint,this._cpxcolor,this._bondingType,this._density,this._electronAffinity, this._electronegativity,this._electronicConfiguration,this._groupBlock,this._ionRadius,this._ionizationEnergy, this._meltingPoint,this._oxidationStates,this._standardState,this._vanDelWaalsRadius,this._yearDiscovered,this._symbol);
  @override
  Widget build(BuildContext context) {
    return FadeIn(0,Scaffold(
        body: SafeArea(
          child: FadeIn(0.2,Container(
              padding: EdgeInsets.all(20.00),
              child: FadeIn(1.5,Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Text(
                            _symbol,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Acme',
                              fontSize: 100.00,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50.00,
                        )
                      ],
                    ),
                Expanded(
                        child: FadeIn(
                          2,ListView(
                            children: <Widget>[
                              _line,
                              _space,
                              _row("Name :   ",_name),
                              _space,
                              _line,
                              _space,
                              _row("Atomic Mass :   ",_atomicMass),
                              _space,
                              _line,
                              _space,
                              _row("Atomic Number :   ",_atominco),
                              _space,
                              _line,
                              _space,
                              _row("Standard State :   ",_standardState),
                              _space,
                              _line,
                              _row("Atomic Radius :   ",_atomicRadius),
                              _space,
                              _line,
                              _space,
                              _row("Boiling Point :   ",_boilingPoint+" \u2103"),
                              _space,
                              _line,
                              _space,
                              Row(
                                children: <Widget>[
                                  Text(
                                    "CPK Color :   ",
                                    style: _textStyle,
                                  ),
                                  Text(
                                    _cpxcolor,
                                    style: _textStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                      color: colorConvert(_cpxcolor),
                                    ),
                                  )
                                ],
                              ),
                              _space,
                              _line,
                              _space,
                              Container(
                                height: 50.00,
                                child:_listView("Bonding Type:   ",_bondingType),
                              ),
                              _space,
                              _line,
                              _space,_row("Density :   ",_density + " Kg/L"),
                              _space,
                              _line,
                              _space,_row("Electron Affinity :   ",_electronAffinity),
                              _space,
                              _line,
                              _space,_row("Electro-negativity :   ",_electronegativity),
                              _space,
                              _line,
                              _space,
                              Container(
                                height: 50.00,
                                child:_listView("Electronic Configuration :   ",_electronicConfiguration),
                              ),
                              _space,
                              _line,
                              _space,
                              Container(
                                height: 50.00,
                                child:_listView("Group Block :   ",_groupBlock),
                              ),
                              _space,
                              _line,
                              _space,_row("Ion Radius :   ",_ionRadius),

                              _space,
                              _line,
                              _space,_row("Ionization Energy :   ",_ionizationEnergy),
                              _space,
                              _line,
                              _space,_row("Melting Point :   ",_meltingPoint+" \u2103"),
                              _space,
                              _line,
                              _space,
                              Container(
                            height: 50.00,
                            child:_listView("Oxidation States :   ",_oxidationStates),
                          ),
                              _space,
                              _line,
                              _space,_row("VanDerWaal's Radius :   ",_vanDelWaalsRadius),
                              _space,
                              _line,
                              _space,_row("Year Discovered :   ",_yearDiscovered),
                              _space,
                              _line,
                              _space,
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/$_index.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
