import 'package:firebase_authentication/models/post.dart';

import '../locator.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future addPost({required String title}) async {
    setBusy(true);
    var result = await _firestoreService
        .addPost(Post(title: title, userId: currentUser.id!));
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }
}
