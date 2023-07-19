import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/constant.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

class PostController extends GetxController{
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<Comment>> comments = Rx<List<Comment>>([]);
  final isLoading = false.obs;
  final box = GetStorage();


  // @override
  // void onInit() {
  //   getAllPosts();
  //   super.onInit();
  // }

  Future getAllPosts() async {
    try{
      posts.value.clear();
      isLoading.value = true ;
      var response = await http.get(
          Uri.parse('${url}feeds'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        }
      );
      if(response.statusCode == 200){
        isLoading.value = false ;
        for (var item in json.decode(response.body)['feeds']){
          posts.value.add(PostModel.fromJson(item));
        }
      }else{
        isLoading.value = false ;
        print(json.decode(response.body));
      }
      }catch(e){
      isLoading.value = false ;
      print(e.toString());
    }
  }

  Future createPost(
      {
        required String content,
      }
  ) async{

  try {
    isLoading.value = true;
    var data = {
      'content': content
    };
  var response = await http.post(
      Uri.parse('${url}feed/store'),
      headers:{
        'Accept':'application/json',
        'Authorization' : 'Bearer ${box.read('token')}'
    },
      body: data);
  if(response.statusCode == 201){
      isLoading.value = false ;
      print(json.decode(response.body));

  }else{
      isLoading.value = false ;
      Get.snackbar(
        'Error',
        json.decode(response.body)['message'],
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP

      );
  }
    }catch(e){
      print(e.toString());
    }
  }

  Future getComments(id) async{
    try{
      isLoading.value = true;
      comments.value.clear();
      var response = await http.get(
          Uri.parse('${url}feed/comments/$id'),
          headers: {
            'Accept' : 'application/json',
            'Authorization' : 'Bearer ${box.read('token')}'
          }
      );
      if(response.statusCode == 200){
        isLoading.value = false;
        for(var item in json.decode(response.body)['comments']){
          comments.value.add(Comment.fromJson(item));
        }
      }else{
        isLoading.value = false;
        print(json.decode(response.body));
      }
    }catch(e){
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createComment(id,{required String body}) async {
    try{
      isLoading.value = true;
      var data = {
        'body' : body
      };
      var response = await http.post(
          Uri.parse('${url}feed/comment/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          }
          ,
          body: data
      );
      if(response.statusCode == 201){
        isLoading.value = false;
        print(json.decode(response.body));
      }else{
        isLoading.value = false;
        print(json.decode(response.body));
      }
    }catch(e){
        isLoading.value = false;
      print(e.toString());
    }

  }

  Future likeAndDislike(id) async {
    try{
      isLoading.value = true ;
      var response = await http.post(
        Uri.parse('${url}feed/like/$id'),
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer ${box.read('token')}'
        }
      );
      if(response.statusCode == 200 || json.decode(response.body)['message'] == 'liked'){
        isLoading.value = false;
        print(json.decode(response.body));
      }else if(response.statusCode == 200 || json.decode(response.body)['message'] == 'unliked'){
        isLoading.value = false;
        print(json.decode(response.body));
      }else{
        isLoading.value = false;
        print(json.decode(response.body));
        }
    }catch(e){
      print(e.toString());
    }
  }

}