import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSeeder {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> seedDatabase() async {
    try {

      final posts = [
        {
          'title': 'Welcome to VIBE',
          'body': 'This is your first post on VIBE. Start sharing your thoughts and experiences with the community!',
          'userId': 1,
          'isLiked': false,
          'likeCount': 0,
        },
        {
          'title': 'Getting Started with Flutter',
          'body': 'Flutter is an amazing framework for building beautiful cross-platform applications. The widget system is incredibly powerful and flexible.',
          'userId': 2,
          'isLiked': true,
          'likeCount': 15,
        },
        {
          'title': 'Firebase Integration Tips',
          'body': 'When integrating Firebase with Flutter, always use the latest versions of the Firebase packages for the best performance and security.',
          'userId': 1,
          'isLiked': false,
          'likeCount': 8,
        },
        {
          'title': 'Mobile App Design Principles',
          'body': 'Good mobile app design focuses on simplicity, consistency, and user experience. Keep your interface clean and intuitive.',
          'userId': 3,
          'isLiked': true,
          'likeCount': 23,
        },
        {
          'title': 'State Management in Flutter',
          'body': 'Understanding state management is crucial for Flutter development. Consider using Provider, Riverpod, or Bloc depending on your app complexity.',
          'userId': 2,
          'isLiked': false,
          'likeCount': 12,
        },
      ];


      for (var postData in posts) {
        await _db.collection('posts').add(postData);
      }


      final comments = [
        {
          'postId': '1',
          'name': 'Sarah Johnson',
          'email': 'sarah@example.com',
          'body': 'Great introduction! Looking forward to more content.',
        },
        {
          'postId': '1',
          'name': 'Mike Chen',
          'email': 'mike@example.com',
          'body': 'Thanks for sharing this. Very helpful for beginners.',
        },
        {
          'postId': '2',
          'name': 'Emily Davis',
          'email': 'emily@example.com',
          'body': 'I completely agree! Flutter has revolutionized mobile development.',
        },
        {
          'postId': '2',
          'name': 'Alex Rodriguez',
          'email': 'alex@example.com',
          'body': 'The hot reload feature is a game changer for development speed.',
        },
        {
          'postId': '3',
          'name': 'Jessica Thompson',
          'email': 'jessica@example.com',
          'body': 'Security is so important. Thanks for the reminder to keep packages updated.',
        },
        {
          'postId': '4',
          'name': 'David Wilson',
          'email': 'david@example.com',
          'body': 'User experience should always be the top priority in design.',
        },
        {
          'postId': '5',
          'name': 'Lisa Anderson',
          'email': 'lisa@example.com',
          'body': 'Provider is perfect for medium-sized apps. Easy to learn and implement.',
        },
        {
          'postId': '5',
          'name': 'Tom Brown',
          'email': 'tom@example.com',
          'body': 'For complex apps, I recommend checking out Riverpod. It scales much better.',
        },
      ];


      for (var commentData in comments) {
        await _db.collection('comments').add(commentData);
      }

      print('Database seeded successfully!');
    } catch (e) {
      print('Error seeding database: $e');
      rethrow;
    }
  }
}