import 'package:flutter/material.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/views/widgets/input_widget.dart';
import 'package:forumapp/views/widgets/post_data.dart';
import 'package:get/get.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({Key? key, required this.postModel}) : super(key: key);

  final PostModel postModel;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {

  final TextEditingController _commentController = TextEditingController();
  final PostController _postController =  Get.put(PostController());


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.postModel.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.postModel.user!.name!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostData(post: widget.postModel),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                height: 410,
                child: Obx(() {
                    return _postController.isLoading.value?
                        const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _postController.comments.value.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(_postController.comments.value[index].user!.name!),
                            subtitle: Text(_postController.comments.value[index]!.body!),
                          );
                        }
                    );
                  }
                ),
              ),
              InputWidget(
                  hintText: 'Write a comment...',
                  controller: _commentController,
                  obscureText: false
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10
                    )
                  ),
                  onPressed: ()async{
                    await _postController.createComment(
                        widget.postModel.id,
                        body: _commentController.text.trim()
                    );
                    _commentController.clear();
                    _postController.getComments(widget.postModel.id);
                  },
                  child: const Text('Comment')
              )
            ],
          ),
        ),
      ),
    );
  }
}
