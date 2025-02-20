import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Postloginscreen extends StatefulWidget {
  const Postloginscreen({super.key});

  @override
  State<Postloginscreen> createState() => _PostloginscreenState();
}

class _PostloginscreenState extends State<Postloginscreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  registerUser(String email,String password) async{
    Uri url = Uri.parse("https://reqres.in/api/login");
    var data ={
      "email":email,
      "password":password,
    };

    try{
      var response = await http.post(url,body: data);
      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        print("Register successful");
      }
      else{
        var  error = jsonDecode(response.body);
        print("unable to register: ${error}");
      }
    } 
    catch(e){
      print("Error:$e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register Post API"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "email"),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: "password"),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  registerUser(emailController.text.toString(),
                     passwordController.text.toString());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                      ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
