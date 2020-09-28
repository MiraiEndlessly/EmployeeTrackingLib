import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'camera.dart';

/*void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )
  );
}*/

class MyMapApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

testprint() async {
  try {
    print("Send some shit to firebase");
  } catch (e) {
    print(e);
  }
}

/*camerapopout(BuildContext context) {
  return showDialog(context: context,builder: (context){
    return AlertDialog (
      title: Text("Send My Location Now ?"),
      actions: <Widget>[
        MaterialButton(
            elevation: 5.0,
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        MaterialButton(
          elevation: 5.0,
          child: Text('Yes'),
          onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CameraApp())); }

        ),
      ],
    );
  });
}*/

class _MyAppState extends State<MyMapApp> {
  GoogleMapController mapController;
  LocationData currentLocation;
  final databaseReference = FirebaseDatabase.instance.reference();
  double lastlat;
  double lastlong;

  final LatLng _center = const LatLng(13.7650836, 100.5379664);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }

  void updateData(){
    databaseReference.child("users").child("้hom").set({
      'firstName': 'Air',
      'lastName': 'Kuylek',
      'latitude': (lastlat),
      'longitude': (lastlong),
    });
    databaseReference.child("users").child("ninebraver").set({
      'firstName': 'Nine-tan',
      'lastName': 'Nahee',
      'latitude': (lastlat),
      'longitude': (lastlong),
    });
  }

  void createData(){
    databaseReference.child("users").child("้hom").set({
      'firstName': 'Air',
      'lastName': 'Kuylek'
    });
    databaseReference.child("users").child("ninebraver").set({
      'firstName': 'Nine-tan',
      'lastName': 'Nahee'
    });
  }

  _openOnGoogleMapApp(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      // Could not open the map.
    }
  }

  Future _goToMe() async {
    final GoogleMapController controller = await mapController;
    currentLocation = await getCurrentLocation();
    //print('Lat = ${currentLocation.latitude} , Lat = ${currentLocation.longitude}');
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              currentLocation.latitude,
              currentLocation.longitude),
          zoom: 16,
        )));
    lastlat = currentLocation.latitude;
    lastlong = currentLocation.longitude;

    print(lastlat); print(lastlong);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          onMapCreated: _onMapCreated,

          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
        ),

        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: _goToMe,
                label: Text('My location'),
                icon: Icon(Icons.near_me),
              ),
              FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: () { /*_goToMe;*/ updateData(); testprint(); Navigator.push(context, MaterialPageRoute(builder: (context) => CameraApp())); },
                label: Text('Send location'),
                icon: Icon(Icons.near_me),
              )
            ],
          ),
        )
      ),
    );
  }
}