import 'dart:convert';

import 'package:haker_news/src/resources/repository.dart';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';


final String _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source{

	Client client = Client();

//	Get the ids of all the top stories from the hacker news api
	Future<List<int>> fetchTopIds() async {
		final response = await client.get('$_root/topstories.json');
		final ids = json.decode(response.body);

		return ids.cast<int>();
	}

//	get the details of a story
	Future<ItemModel> fetchItem(int id) async {
		final response = await client.get('$_root/item/$id.json');
		final parsedJson = json.decode(response.body);

		return ItemModel.fromJson(parsedJson);
	}


}