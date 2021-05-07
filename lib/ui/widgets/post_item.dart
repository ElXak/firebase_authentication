import 'package:flutter/material.dart';

import '../../models/post.dart';

class PostItem extends StatelessWidget {
  final Post? post;
  final Function? onDeleteItem;

  const PostItem({Key? key, this.post, this.onDeleteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.grey[200]!, spreadRadius: 3)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(post!.title),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (onDeleteItem != null) {
                onDeleteItem!();
              }
            },
          )
        ],
      ),
    );
  }
}
