//we use this class to store our database related methods 


import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;


class DBHelper {


  //method to create or get access to the database
  static Future<sql.Database> database () async {

    final dbPath = await sql.getDatabasesPath(); //getdatabasepath gives us the path where our db will be created/stored on device note: this is the folder where database is stored not the actual database
      
    //this opens/finds a database in the path we created with the name of the database if such database exist or create a new database if it is not there before in that path with the given name
    return sql.openDatabase(
        path.join(dbPath,"places.db"),//called the join method of path to point exactly where database is stored along with its name so (Database folder name + name of the database)
        onCreate:(db,version){ //this is a method that will execute when the opendatabase try to find a database but coudnt find any file  so this oncreate function will go on to create some files to initialize this database
        return db.execute('CREATE TABLE user_places (id TEXT PRIMARY KEY , title TEXT , image TEXT ,loc_Lat REAL , loc_lon REAL , address TEXT )');
       },
      version: 1 //we can change the version of the database to overwrite the present value with new ones this version argument specifies which version of our database we want to access
     ); 
    
  }


 //method to insert data into sqlite
  static Future<void> insert (String table , Map<String,Object> data ) async {  
    
    final db = await DBHelper.database();//want to use class name because database is a static method

    db.insert(  
       table, 
       data ,
       conflictAlgorithm: sql.ConflictAlgorithm.replace //this makes sure if we try to inser a data for a id which already have some value that we replace the existing value
       );
      
  } 

 //method that will fetch data from the database
  static Future<List<Map<String,dynamic>>> getData(String table) async {

    final db = await DBHelper.database();

    return db.query(table);

  }

}