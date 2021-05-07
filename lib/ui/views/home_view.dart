import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../view_models/home_view_model.dart';
import '../shared/ui_helpers.dart';
import '../widgets/post_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      // onModelReady: (model) => model.fetchPosts(),
      onModelReady: (model) => model.listenToPosts(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(35),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    child: Image.asset('assets/images/title.png'),
                  )
                ],
              ),
              Expanded(
                child: model.posts != null
                    ? ListView.builder(
                        itemCount: model.posts!.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => model.editPost(index),
                          child: PostItem(
                            post: model.posts![index],
                            onDeleteItem: () => model.deletePost(index),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
                        ),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: model.navigateToCreateView,
          child: !model.busy ? Icon(Icons.add) : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
