import 'package:haker_news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache{
	Database db;

	NewsDbProvider(){
		init();
	}

	void init() async {
		Directory documentsDirectory = await getApplicationDocumentsDirectory();
		final path = join(documentsDirectory.path, "items.db");
		db = await openDatabase(
			path,
			version: 1,
			onCreate: (Database newDb, int version) {
				newDb.execute("""
				    CREATE TABLE Items
					    (
					      id INTEGER PRIMARY KEY,
					      type TEXT,
					      by TEXT,
					      time INTEGER,
					      text TEXT,
					      parent INTEGER,
					      kids BLOB,
					      dead INTEGER,
					      deleted INTEGER, 
					      url TEXT,
					      score TEXT,
					      title TEXT,
					      descendants INTEGER
					    )
			    """);
			},
		);
	}

	Future<ItemModel> fetchItem(int id) async {
		final maps = await db.query(
			"Items",
			columns: null,
			where: "id = ?",
			whereArgs: [id],
		);

		if (maps.length > 0) {
			return ItemModel.fromDb(maps.first);
		}
		return null;
	}
	
	Future<int> addItem(ItemModel item) {
		return db.insert("Items", item.toMapForDb());
	}


  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    return null;
  }

}

final newsDbProvider = NewsDbProvider();