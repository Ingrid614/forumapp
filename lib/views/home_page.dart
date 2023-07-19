import 'package:flutter/material.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/views/widgets/post_data.dart';
import 'package:forumapp/views/widgets/post_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final TextEditingController _textController = TextEditingController();
  final PostController _postController = Get.put(PostController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FORUM APP',style: GoogleFonts.poppins()),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             PostField(
               hintText: 'What do you want to ask?',
               controller: _textController,
             ),
             ElevatedButton(
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.black,
                 elevation: 0,
                 padding: const EdgeInsets.symmetric(
                   horizontal: 50.0,
                   vertical: 10.0
                 )
               ),
                 onPressed: ()async{
                  await _postController.createPost(content: _textController.text.trim());
                  _textController.clear();
                  _postController.getAllPosts();
                 },
                 child: Obx(() {
                     return _postController.isLoading.value?
                     const CircularProgressIndicator()
                     :Text('Post',style: GoogleFonts.poppins());
                   }
                 )
             ),
              const SizedBox(
                height: 30.0,
              ),
              Text('Posts', style: GoogleFonts.poppins()),
              const SizedBox(
                height: 20.0,
              ),
              Obx(() {
                  return _postController.isLoading.value?
                    const Center(child:  CircularProgressIndicator())
                  : ListView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _postController.posts.value.length,
                      itemBuilder: (context,index){
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            PostData(post: _postController.posts.value[index]),
                          ],
                        );
                      }
                  );
                }
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _postController.getAllPosts();
    super.initState();
  }
}
