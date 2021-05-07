import '../constants/route_names.dart';
import '../locator.dart';
import '../models/post.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Post?>? _posts;

  List<Post?>? get posts => _posts;

  Future fetchPosts() async {
    setBusy(true);
    var postsResult = await _firestoreService.getPostsOnceOff();
    setBusy(false);

    if (postsResult is List<Post?>) {
      _posts = postsResult;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Posts Update Failed',
        description: postsResult,
      );
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreatePostViewRoute);
    await fetchPosts();
  }
}
