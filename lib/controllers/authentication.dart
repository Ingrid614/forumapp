import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


import '../constants/constant.dart';
import '../views/home_page.dart';

class AuthenticationController extends GetxController{

  final isLoading = false.obs ;
  final token = ''.obs;

  final box = GetStorage();

   Future register ({
     required String name,
     required String username,
     required String email,
     required String password
      }) async {
     try{
       isLoading(true);
       isLoading.value = true ;
       var data = {
         'name': name,
         'username': username,
         'email': email,
         'password': password
       };

       var response = await http.post(
           Uri.parse(url+'register'),
           headers: {
             'Accept': 'application/json'
           },
           body: data);

       if(response.statusCode == 201){
         isLoading.value = false ;
         token.value = json.decode(response.body)['token'];
         box.write('token', token.value);

         debugPrint(json.decode(response.body).toString());
         Get.offAll(() => const HomePage());
       }else{
         isLoading.value = false ;
         Get.snackbar(
           'error',
           json.decode(response.body)['message'],
           snackPosition: SnackPosition.BOTTOM,
           backgroundColor: Colors.red,
           colorText: Colors.white
         );
         debugPrint(json.decode(response.body).toString());
       }
     }catch(e){
       isLoading.value = false ;
       print(e.toString());
     }
   }
  Future login({
    required String username,
    required String password
  }) async {
    try{
      isLoading(true);
      isLoading.value = true ;
      var data = {
        'username': username,
        'password': password
      };

      var response = await http.post(
          Uri.parse(url +'login'),
          headers: {
            'Accept': 'application/json'
          },
          body: data);

      if(response.statusCode == 200){
        isLoading.value = false ;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.snackbar(
          'Logged In',
          'GO to home page',
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP
        );

        print(json.decode(response.body).toString());
        Get.offAll(() => const HomePage());
      }else{
        isLoading.value = false ;
        Get.snackbar(
            'error',
            json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
        print(json.decode(response.body).toString());
      }
    }catch(e){
      isLoading.value = false ;
      print(e.toString());
    }
  }

}