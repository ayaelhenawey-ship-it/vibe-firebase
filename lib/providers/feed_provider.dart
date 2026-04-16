import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../services/firestore_service.dart';

class FeedProvider with ChangeNotifier {
  List<PostModel> _posts = [];
  List<PostModel> _filteredPosts = [];
  bool _isLoading = false;
  Map<dynamic, List<CommentModel>> _comments = {};

  final FirestoreService _firestoreService = FirestoreService();

  List<PostModel> get posts => _filteredPosts.isEmpty ? _posts : _filteredPosts;
  bool get isLoading => _isLoading;

  List<CommentModel> getComments(dynamic postId) => _comments[postId] ?? [];

  FeedProvider() {
    _initPostsStream();
  }

  void _initPostsStream() {
    _isLoading = true;
    notifyListeners();
    _firestoreService.getPosts().listen((postData) {
      _posts = postData;
      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
      _posts = [];
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> fetchPosts() async {
  }

  Future<void> fetchComments(dynamic postId) async {
    try {
      _firestoreService.getComments(postId.toString()).listen((commentData) {
        _comments[postId] = commentData;
        notifyListeners();
      }, onError: (e) {
        _comments[postId] = [];
        notifyListeners();
      });
    } catch (e) {
      _comments[postId] = [];
      notifyListeners();
    }
  }

  Future<void> toggleLike(dynamic postId) async {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _posts[index];
      post.isLiked = !post.isLiked;
      if (post.isLiked) {
        post.likeCount++;
      } else {
        post.likeCount--;
      }
      notifyListeners();

      try {
        await _firestoreService.updatePost(post.id.toString(), {
          'isLiked': post.isLiked,
          'likeCount': post.likeCount,
        });
      } catch (e) {

      }
    }
  }

  Future<void> addPost(PostModel post) async {
    await _firestoreService.addPost(post);
  }

  Future<void> deletePost(String postId) async {
    await _firestoreService.deletePost(postId);
  }

  Future<void> searchPosts(String query) async {
    if (query.isEmpty) {
      _filteredPosts = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();
    try {
      _filteredPosts = await _firestoreService.searchPosts(query);
    } catch (e) {
      _filteredPosts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _filteredPosts = [];
    notifyListeners();
  }

Future<void> seedDummyData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final samplePosts = [
        PostModel(
          id: 'vibe_1',
          userId: '101',
          title: 'Welcome to VIBE! 🚀',
          body: 'This is the first step in our community. Let\'s share ideas and vibes!',
        ),
        PostModel(
          id: 'vibe_2',
          userId: '102',
          title: 'Flutter Web is Awesome',
          body: 'Building high-performance web apps with Flutter is just a different vibe.',
        ),
        PostModel(
          id: 'vibe_3',
          userId: '103',
          title: 'Minimalist Design',
          body: 'Clean, modern, and professional. That\'s what we aim for in VIBE.',
        ),
        PostModel(
          id: 'vibe_4',
          userId: '104',
          title: 'Tech & Community',
          body: 'Connecting ITI developers to share their graduation projects and support each other.',
        ),
        PostModel(
          id: 'vibe_5',
          userId: '105',
          title: 'Monday Motivation',
          body: 'Keep coding, keep learning, and never stop vibing with your projects!',
        ),
      ];

      for (var post in samplePosts) {
        await _firestoreService.addPost(post);
      }
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}