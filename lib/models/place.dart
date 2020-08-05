import 'dart:io'; //this gives acces to method that will help us to wirk with file and file system

import 'package:flutter/foundation.dart';


class PlaceLocation { //to create datatype for our location
  final double latitude;
  final double longitude;
  final String address;

 const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address
    });
}


class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;


  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image
    });

}