import 'dart:convert';

import 'package:post_api_app_flutter/model/updatemodel.dart';
import 'package:http/http.dart' as http;

class Updateservice {
  Future<UpdateModel?> updatedata(String name, String job) async {
    var url = Uri.parse("https://reqres.in/api/users/2");
    var response = await http.put(url, body: {"name": name, "job": job});

    try {
      if(response.statusCode == 200){
        UpdateModel updatemodel = UpdateModel.fromJson(jsonDecode(response.body),);
        print(response.body);
        print("data updated successfully");
        return updatemodel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
