import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../view_models/create_post_view_model.dart';
import '../shared/ui_helpers.dart';
import '../widgets/input_field.dart';

class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      viewModelBuilder: () => CreatePostViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(40),
              Text(
                'Create Post',
                style: TextStyle(fontSize: 26),
              ),
              verticalSpaceMedium,
              InputField(
                controller: titleController,
                placeholder: 'Title',
              ),
              verticalSpaceMedium,
              Text('Post Image'),
              verticalSpaceSmall,
              Container(
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Tap to add post image',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          onPressed: () {
            if (!model.busy) {
              model.addPost(title: titleController.text);
            }
          },
          child: !model.busy
              ? Icon(Icons.add)
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
        ),
      ),
    );
  }
}
