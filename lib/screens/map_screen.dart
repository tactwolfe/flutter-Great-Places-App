//this widget will be used to show a google map

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {

  final PlaceLocation initialLocation; //to get lat and long value and set it to initalcamerapostion to show a marker
  final bool isSelecting;  //to either show a default position to user or let them select a position on map

  MapScreen({
    this.initialLocation = const PlaceLocation(latitude: 20.4625 ,longitude: 85.8830 ),
    this.isSelecting = true,
    });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng _pickedLocation;

  void _selectLocation (LatLng position) {
      setState(() {
        _pickedLocation = position;
      });
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You Map"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          if(widget.isSelecting)
          IconButton(
            icon: Icon(Icons.check), 
            onPressed: _pickedLocation == null ? null 
            : (){
              Navigator.of(context).pop(_pickedLocation);
            }
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude), //default position that will be shown in the map
          zoom: 13,
          ),
          onTap: widget.isSelecting ? _selectLocation  : null,
          markers:( _pickedLocation == null && widget.isSelecting) ? null : {Marker(
            markerId: MarkerId('m1'),
            position: _pickedLocation ?? LatLng(widget.initialLocation.latitude,widget.initialLocation.longitude)
            )},
       
        ),
    );
  }
}