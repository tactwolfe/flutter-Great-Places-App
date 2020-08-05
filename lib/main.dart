

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/great_places.dart';
import './screens/places_list.dart';
import './screens/add_places_screen.dart';
import './screens/place_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx)=>GreatPlaces(), 
        child: MaterialApp(
        title: "Great Places",
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName : (ctx) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName : (ctx) => PlaceDetailsScreen(),
        }, 
      ),
    );
  }
}