import 'dart:convert';

import 'package:covid_tracking_app/Model/WorldStatesModel.dart';
import 'package:http/http.dart' as http;

import '../Model/CountriesListModel.dart';
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

  Future<List<CountriesListModel>> countriesList() async{
    List<CountriesListModel> countries = [];
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      for(Map i in data){
        countries.add(CountriesListModel.fromJson(i));
      }
      //countries.addAll(CountriesListModel.fromJson(data));
      //countries.addAll(data);
      return countries;
    }else{
      return countries;
    }
  }

  Future<List<dynamic>> countriesList1() async{
   var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      data = jsonDecode(response.body);
      // for(Map i in data){
      //   countries.add(CountriesListModel.fromJson(i));
      // }
      //countries.addAll(CountriesListModel.fromJson(data));
      //countries.addAll(data);
      return data;
    }else{
      throw Exception("Error");
    }
  }
}

