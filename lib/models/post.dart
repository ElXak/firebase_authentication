class Post {
  final String title;
  final String? imageUrl;
  final String userId;

  Post({
    required this.title,
    this.imageUrl,
    required this.userId,
  });

  static Post? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return Post(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }
}
