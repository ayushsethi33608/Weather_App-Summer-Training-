import 'package:flutter/material.dart';
class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  String? cityname;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Enter city name',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      icon:Icon( Icons.location_city,),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0)),)
                  ),
                  onChanged: (value){
                    cityname=value;
                  },
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red)),
                onPressed: () {
                  Navigator.pop(context,cityname);
                },
                child: Text(
                  'Get Weather',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
