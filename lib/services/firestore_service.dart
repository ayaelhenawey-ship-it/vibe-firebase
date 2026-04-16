import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _postsCollection = 'posts';
  final String _commentsCollection = 'comments';


  Future<void> addPost(PostModel post) async {
    try {
      await _db.collection(_postsCollection).add(post.toJson());
    } catch (e) {
      rethrow;
    }
  }


  Stream<List<PostModel>> getPosts() {
    return _db.collection(_postsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostModel.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }


  Future<void> updatePost(String id, Map<String, dynamic> data) async {
    try {
      await _db.collection(_postsCollection).doc(id).update(data);
    } catch (e) {
      rethrow;
    }
  }


  Future<void> deletePost(String id) async {
    try {
      await _db.collection(_postsCollection).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }


  Future<List<PostModel>> searchPosts(String query) async {
    try {
      final snapshot = await _db.collection(_postsCollection)
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      return snapshot.docs
          .map((doc) => PostModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }


  Future<void> addComment(CommentModel comment) async {
    try {
      await _db.collection(_commentsCollection).add(comment.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<CommentModel>> getComments(String postId) {
    return _db.collection(_commentsCollection)
        .where('postId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommentModel.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Future<void> updateComment(String id, Map<String, dynamic> data) async {
    try {
      await _db.collection(_commentsCollection).doc(id).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteComment(String id) async {
    try {
      await _db.collection(_commentsCollection).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
