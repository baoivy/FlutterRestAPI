import 'package:flutter/foundation.dart';
import 'package:restapitest/post.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String url = 'https://jsonplaceholder.typicode.com/albums?fbclid=IwAR0j7g7Tlz0Ziig5eid_fjdoF1W6uHOz5zBztnV61qFB0S2Dg3CBgvTiNbA';
    
List<description> parse(String response) {
    List<dynamic> list = json.decode(response);
    return list.map((model) => description.fromJson(model)).toList();
}

Future<List<description>> fetch({int page = 1}) async {
    final respone = await http.get(Uri.parse(url));
    if(respone.statusCode == 200){
        return compute(parse, respone.body);
    }
    else{
        throw Exception('Cannot fetch');
    }
} 
