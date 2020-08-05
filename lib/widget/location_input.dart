//widget that return us a map for our places


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl; //this will store a url of map preview 

  //this method returns a map image where marker is placed 
  void _showPreview(double lat , double lon) {
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude:lat ,
      longitude: lon
      );
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
  }

  //this method returns current user location
  Future<void> _getCurrentUserLocation () async {
    try{
      final locData =  await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(
        locData.latitude,
        locData.longitude
        );
    }catch(error){
      return;
    }
  }

  //this method return location user selected on a map
  Future<void> _selectOnMap () async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx)=> MapScreen(
          isSelecting: true,
        )
      ),
    );
    if(selectedLocation == null){
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(
      selectedLocation.latitude,
      selectedLocation.longitude
      );

  }


  @override
  Widget build(BuildContext context) {
    return Column( children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).accentColor
              )),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null ? Text("No location chosen!",textAlign: TextAlign.center,)
          : Image.network(
            _previewImageUrl , 
            fit: BoxFit.cover,
            width: double.infinity,
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.location_on), 
            label: Text("Current Location"),
            textColor: Theme.of(context).primaryColor,
            onPressed: _getCurrentUserLocation, 
            ),
          FlatButton.icon(             
            icon: Icon(Icons.map), 
            label: Text("Select on Map"),
            textColor: Theme.of(context).primaryColor,
            onPressed: _selectOnMap,
            )
        ],)


    ],
   );
  }
}