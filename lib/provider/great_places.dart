//provider package that will provide info about the great places we stored in our app this is connected to database that will be store in our device via sqlite


import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/location_helper.dart';

import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id){
    return _items.firstWhere((item) => item.id == id);
  }


  //method to add a new place used in add place screen
  Future<void> addPlace(String pickedTitle ,File pickedImage , PlaceLocation pickedLocation) async{
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude); //get the lat and long and convert it into human redable  address using dbhelper class that have some functionality  recieve this via location_input -> add_places -> here
    final updatedLocation = PlaceLocation(latitude:pickedLocation.latitude,longitude: pickedLocation.longitude ,address: address);
    final newPlace = Place (
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation, //this contain latitude,longitude,address
    );

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places', //name of our table
      {
        'id':newPlace.id,
        'title':newPlace.title,
        'image':newPlace.image.path, //adding .path store the path to the image in the form of string as required by our database not the image itself which is in the form of file
        'loc_Lat':newPlace.location.latitude,
        'loc_lon':newPlace.location.longitude,
        'address':newPlace.location.address

      }
      );
    }

    //method to fetch data from the database and show it in places_list screen
    Future<void> fetchAndSetPlaces () async {
      final dataList = await DBHelper.getData('user_places');
       _items = dataList.map((item) => Place( //load places from db into our _items to show after restarting the app
         id: item['id'], 
         title: item['title'],  
         image: File(item['image']), //instantiate the File with path of our image in the database so it automatically can find and load the image from the device using that path
         location: PlaceLocation(
           latitude: item['loc_Lat'], 
           longitude:item['loc_lon'] ,
           address: item['address'], 
          ),
      )).toList();
      notifyListeners();
    }


}
