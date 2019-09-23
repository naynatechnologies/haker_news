import 'package:haker_news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';


void main() {
	test('fetchTopIds-------------- ', () async {
		final newsAPIs = NewsApiProvider();
		newsAPIs.client = MockClient((request) async{
			return Response(json.encode([1,2,3,4,5,6]), 200);
		});

		final ids = await newsAPIs.fetchTopIds();

		expect(ids, [1,2,3,4,5,6]);

	});
	test('fetchItem---------------', () async{
		final newsAPI = NewsApiProvider();
		newsAPI.client = MockClient((request) async{
			final jsonMap = {'id':14};
			return Response(json.encode(jsonMap), 200);
		});

		final item = await newsAPI.fetchItem(123);

		expect(item.id, 14);
	});
}