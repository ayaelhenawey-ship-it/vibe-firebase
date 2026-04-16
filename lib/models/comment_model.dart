import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String postId;
  final String name;
  final String email;
  final String body;
  final DateTime? timestamp;

  CommentModel({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
    this.timestamp,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return CommentModel(
      id: docId ?? json['id']?.toString() ?? '',
      postId: json['postId']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      body: json['body'] ?? '',
      timestamp: json['timestamp'] != null && json['timestamp'] is Timestamp
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'name': name,
      'email': email,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}