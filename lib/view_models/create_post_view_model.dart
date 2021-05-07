import '../locator.dart';
import '../models/post.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Post? _postToEdit;

  bool get _editting => _postToEdit != null;

  Future addPost({required String title}) async {
    setBusy(true);
    var result;

    if (!_editting) {
      result = await _firestoreService
          .addPost(Post(title: title, userId: currentUser.id!));
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _postToEdit!.userId,
        id: _postToEdit!.id,
      ));
    }

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

  void setPostToEdit(Post? postToEdit) {
    _postToEdit = postToEdit;
  }
}
