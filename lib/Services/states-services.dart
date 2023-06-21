import 'dart:convert';

import 'package:covid_tracking_app/Model/WorldStatesModel.dart';
import 'package:http/http.dart' as http;

import 'Utilities/app_url.dart';

class StateServices{
  Future<WorldStatesModel> worldStatesRecord()async{
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    var data = jsonDecode(response.body);
    if(response.statusCode==200){
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Error Accord");
    }
  }
}