import 'package:flutter/material.dart';
import 'package:post_api_app_flutter/without%20model/get_service_without_model.dart';

class GetmethodpageWithoutModel extends StatefulWidget {
  const GetmethodpageWithoutModel({super.key});

  @override
  State<GetmethodpageWithoutModel> createState() => _GetmethodpageWithoutModelState();
}

class _GetmethodpageWithoutModelState extends State<GetmethodpageWithoutModel> {
  bool isLoadin = true;
  dynamic postModelData = [];
  void getPost() {
  ApiServices().getRequestWithoutModel().then((value) {
    setState(() {
      if (value != null) {
        isLoadin = false;
        postModelData = value;
      } 
      else {
        print('Received empty data');
      }
    });
  }).catchError((error, stacktrace) {
    print('Error occurred: $error');
    print('Stack trace: $stacktrace');  });
}


  @override
  void initState(){
    getPost();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Get method without model",
            style: TextStyle(
              fontWeight: FontWeight.bold 
            ),
          ),
        ),
      
        body:isLoadin ? Center(
          child: CircularProgressIndicator(),
        ):
         ListView.builder(
          itemCount: postModelData.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
              
                  userInfo(index,"Name : ",
                  postModelData[index]['name'].toString(),
                  ),
              
                  userInfo(index,"Email : ",
                  postModelData[index]['email'].toString(),
                  ),
              
                  userInfo(index,"City : ",
                  postModelData[index]['address']['city'].toString(),
                  ),
              
                  userInfo(index,"Street : ",
                  postModelData[index]['address']['street'].toString(),
                  ),
              
                  userInfo(index,"Zipcode : ",
                  postModelData[index]['address']['zipcode'].toString(),
                  ),
              
                ],
              ),
            ),
          );
        },)
      ),
    );
  }

  Row userInfo(int index,name,value) {
    return Row(children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  ),


                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18
                  ),
                  ),
                ],
                );
  }
}