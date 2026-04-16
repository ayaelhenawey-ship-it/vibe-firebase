import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _userData;
  List<dynamic> _userPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;
    
    if (user != null) {
      try {
        _userData = user;
        _userPosts = [
          {
            'title': 'Welcome Post',
            'body': 'This is your first post on VIBE!',
            'date': '2 hours ago',
          },
          {
            'title': 'Getting Started',
            'body': 'Explore the app and connect with others.',
            'date': 'Yesterday',
          },
        ];
        
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B3E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'PROFILE',
          style: TextStyle(color: Color(0xFFC9A96E), letterSpacing: 4, fontWeight: FontWeight.w300),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Color(0xFFC9A96E)),
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();
              if (mounted) Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Color(0xFFC9A96E)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFC9A96E)))
          : _userData == null
              ? const Center(child: Text('Failed to load profile', style: TextStyle(color: Colors.white70)))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFC9A96E).withValues(alpha: 0.3), width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: const Color(0xFFC9A96E),
                            child: Text(
                              _userData!.firstName.isNotEmpty ? _userData!.firstName[0].toUpperCase() : 'U',
                              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF0D1B3E)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _userData!.fullName,
                        style: const TextStyle(color: Color(0xFFE8D5A3), fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '@${_userData!.username}',
                        style: TextStyle(color: const Color(0xFFC9A96E).withValues(alpha: 0.7), fontSize: 16),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn('Posts', _userPosts.length.toString()),
                          _buildStatDivider(),
                          _buildStatColumn('Followers', '1.2k'),
                          _buildStatDivider(),
                          _buildStatColumn('Following', '850'),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RECENT ACTIVITY',
                          style: TextStyle(color: const Color(0xFFC9A96E).withValues(alpha: 0.8), letterSpacing: 2, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 15),
                      if (_userPosts.isEmpty)
                        const Padding(padding: EdgeInsets.all(40), child: Text('No activity yet', style: TextStyle(color: Colors.white54)))
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _userPosts.length,
                          itemBuilder: (context, index) {
                            final post = _userPosts[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A2A4E),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                title: Text(
                                  post['title'] ?? 'Untitled',
                                  style: const TextStyle(color: Color(0xFFE8D5A3), fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    post['body'] ?? '',
                                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFC9A96E), size: 16),
                              ),
                            );
                          },
                        ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(height: 30, width: 1, color: Colors.white10);
  }
}