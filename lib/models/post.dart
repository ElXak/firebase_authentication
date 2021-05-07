class Post {
  final String title;
  final String? imageUrl;
  final String userId;
  final String? id;

  Post({
    required this.title,
    this.imageUrl,
    required this.userId,
    this.id,
  });

  static Post? fromMap(Map<String, dynamic>? map, String id) {
    if (map == null) return null;

    return Post(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      id: id,
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
