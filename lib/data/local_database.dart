import 'package:drift/drift.dart'; // core drift library. Defines Table and sql constructs like select, insert, delete. Stream
import 'package:drift_flutter/drift_flutter.dart'; // Flutter specific support for Drift. Native Database.
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart'; // Gives path to where to save the .sqlite file
import 'dart:io'; // // To create database file
import 'package:path/path.dart' as p; // library to join opaths safely across platforms. 


part 'local_database.g.dart'; // This line instructs that I am going to generate code for this file using Drift's code generator. When build_runner is run, local_database.g.dart will be generated in memory. local_database.g.dart will contain _$LocalDatabase, Task, etc.


class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()(); // integer field. Every task gets a unique ID
  TextColumn get name => text()(); // text file. Name of every task
} // By creating this table in my dart code, Drift will turn this into sql table definition that will look as follows:
/*
CREATE TABLE tasks(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);
*/


/*
The decorator @DriftDatabase will trigger code generation into the local_database.g.dart where $LocalDatabase is the generated class.
*/

@DriftDatabase(tables: [Tasks]) // This is the database. The database can have many tables in it. But this todo will have only 1 table. Local Database also manages all Drift Operations like addTask and watchAllTasks.
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection()); // Create SQ Lite file and links to it.

  @override
  int get schemaVersion => 1; // Every database has a schema version. Right now it is 1. But later as the schema is upgraded, this should change. 
  Future<int> addTask(String name) => into(tasks).insert(TasksCompanion(name: Value(name))); // method to insert a task into the table and return the created ID
  Stream<List<Task>> watchAllTasks() => select(tasks).watch(); // This function returns a reactive stream of all tasks. Anytime something changes into the tasks, This stream will emit a new list. I need to use it with StreamBuilder to update the UI in real time. 

 }

LazyDatabase _openConnection() { // Lazy connection means that it will not open until needed
    return LazyDatabase(() async{ 
	final dir = await getApplicationDocumentsDirectory();  // gets the root directory where the databse can be saved permanently
	final file = File(p.join(dir.path, 'db.sqlite')); // joins paths like os.path.join() in python
	return NativeDatabase(file); // Native databse is needed to persist data on device's storage. NativeDatabase will create a SQLLite database at the location. 
    });
}


