import 'package:flutter/cupertino.dart';
import 'package:weather/city_screen.dart';
import 'components/weather.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  var locationdata;
  LocationScreen(this.locationdata);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? temperature;
  int? humidity;
  String? name;
  double? windspeed;
  String? weathermessage;
  String? climate;
  WeatherModel current=WeatherModel();


  void updateUI(dynamic locationdata) {
    setState(() {
      if (locationdata == null) {
        temperature = 0;
        name = '';
        windspeed=0;
        weathermessage='';
        humidity=0;
        climate='0';
        return;
      }
      double temp = locationdata['main']['temp'];
      temperature = temp.toInt();
      climate=locationdata['weather'][0]['main'];
      name = locationdata['name'];
      weathermessage=locationdata['weather'][0]['description'];
      windspeed=locationdata['wind']['speed'];
      humidity=locationdata['main']['humidity'];
    });
  }

    void initState(){
      super.initState;
      updateUI(widget.locationdata);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () async{
                        WeatherModel weathermodel = WeatherModel();
                        var currentweatherdata = await weathermodel
                            .determinelocation();
                        updateUI(currentweatherdata);
                      }
                          , icon: Icon(Icons.location_on_rounded,color: Colors.white,size: 30,)),
                      IconButton(
                          onPressed: () async{
                         var typename= await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return CityScreen();
                            }));
                         if(typename!=null) {
                           var data = await current.getLocationByCityName(
                               typename);
                           updateUI(data);
                         }
                      }
                      , icon: Icon(Icons.location_city,color: Colors.white,size: 30)),
        ],
                  ),
                  Padding
                    (padding: EdgeInsets.only(bottom: 10.0),
                    child: Text('$name',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight:
                    FontWeight.w600,
                    ),
                    ),
                  ),
                  Text('${temperature.toString()}°C',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight:
                  FontWeight.w600,
                  ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0),
                    child: Text('$climate',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight:
                    FontWeight.w600,
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded
            (
            flex:2,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.thermostat_outlined),
                  title: Text('Temperature'),
                  trailing: Text('${temperature.toString()}°C'),
                ),
                ListTile(
                  leading: Icon(Icons.cloud),
                  title: Text('Weather'),
                  trailing: Text(weathermessage!.toUpperCase()),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Humidity'),
                  trailing: Text(humidity.toString()),
                ),
                ListTile(
                  leading: Icon(Icons.air),
                  title: Text('Windspeed'),
                  trailing: Text(windspeed.toString()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



