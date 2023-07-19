import 'package:flutter/material.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/views/post_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/post_controller.dart';

class PostData extends StatefulWidget {
  const PostData({Key? key, required this.post}) : super(key: key);


  final PostModel post ;


  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {

  final PostController _postController = Get.put(PostController());
  Color likePost = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.user!.name!,
            style: GoogleFonts.poppins(),
          ),
          Text(
            widget.post.user!.email!,
            style: GoogleFonts.poppins(
                fontSize: 10.0
            ),
          ),

          const SizedBox(
            height: 10.0,
          ),
          Text(
            widget.post.content!,
            style: GoogleFonts.poppins(),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async{
                    await _postController.likeAndDislike(widget.post.id);
                    _postController.getAllPosts();
                  },
                  icon: Icon(
                    Icons.thumb_up,
                    color: widget.post.liked! ? Colors.blue : Colors.black,)
              ),
              IconButton(
                  onPressed: (){
                    Get.to(() =>  PostDetails(postModel: widget.post ));
                  },
                  icon: const Icon(Icons.message)
              )
            ],
          )
        ],
      ),
    );
  }
}
