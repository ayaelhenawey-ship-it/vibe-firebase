import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String title;
  final String body;
  final String userId;
  bool isLiked;
  int likeCount;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.isLiked = false,
    this.likeCount = 0,
  });

 factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userId: json['userId']?.toString() ?? '0',
      isLiked: json['isLiked'] is bool ? json['isLiked'] : false,
      likeCount: int.tryParse(json['likeCount']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'isLiked': isLiked,
      'likeCount': likeCount,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}