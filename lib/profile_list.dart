import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ProfileListPage extends StatefulWidget {
  final List<Map<String, String>> profiles;

  const ProfileListPage({super.key, required this.profiles});

  @override
  State<ProfileListPage> createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  void _deleteProfile(int index) {
    final profileName = widget.profiles[index]['name'] ?? 'this profile';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white.withOpacity(0.92),
        title: const Text(
          'Delete Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFFE53E3E),
          ),
        ),
        content: Text(
          'Are you sure you want to delete "$profileName"?\nThis cannot be undone.',
          style: const TextStyle(color: Color(0xFF4A5568)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.profiles.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$profileName deleted'),
                  backgroundColor: const Color(0xFFE53E3E),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Color(0xFFE53E3E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editProfile(int index) {
    final p = widget.profiles[index];

    final nameCtrl = TextEditingController(text: p['name']);
    final regCtrl = TextEditingController(text: p['reg']);
    final emailCtrl = TextEditingController(text: p['email']);
    final mobileCtrl = TextEditingController(text: p['mobile']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: Colors.white.withOpacity(0.94),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF2D3748)),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogField(nameCtrl, 'Full Name', Icons.person_outline_rounded),
              _buildDialogField(regCtrl, 'Reg Number', Icons.badge_outlined),
              _buildDialogField(emailCtrl, 'Email', Icons.email_outlined),
              _buildDialogField(mobileCtrl, 'Mobile', Icons.phone_android_rounded),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF9FBAFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {
              setState(() {
                widget.profiles[index] = {
                  'name': nameCtrl.text.trim(),
                  'reg': regCtrl.text.trim(),
                  'email': emailCtrl.text.trim(),
                  'mobile': mobileCtrl.text.trim(),
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Profile updated'),
                  backgroundColor: Colors.teal.shade600,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogField(
    TextEditingController ctrl,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(color: Color(0xFF2D3748)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade700),
          prefixIcon: Icon(icon, color: const Color(0xFF6B7CFF)),
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF9FBAFF), width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.18),
            ),
          ),
        ),
        title: const Text(
          'All Profiles',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2D3748)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Chip(
              label: Text(
                '${widget.profiles.length}',
                style: const TextStyle(
                  color: Color(0xFF2D3748),
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: const Color(0xFF9FBAFF).withOpacity(0.35),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Same light gradient as AddProfilePage
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE6F0FF),
                  Color(0xFFF0E8FF),
                  Color(0xFFFAF9FF),
                ],
              ),
            ),
          ),

          widget.profiles.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline_rounded,
                        size: 100,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'No profiles yet',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Create your first profile on the previous screen',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 90, 16, 90),
                  itemCount: widget.profiles.length,
                  itemBuilder: (context, index) {
                    final p = widget.profiles[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.30),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.45),
                                width: 1.2,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              leading: CircleAvatar(
                                radius: 32,
                                backgroundColor: const Color(0xFF9FBAFF).withOpacity(0.25),
                                child: Text(
                                  (p['name']?.isNotEmpty ?? false)
                                      ? p['name']![0].toUpperCase()
                                      : '?',
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF6B7CFF),
                                  ),
                                ),
                              ),
                              title: Text(
                                p['name'] ?? 'Unnamed',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2D3748),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p['reg'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4A5568),
                                      ),
                                    ),
                                    Text(
                                      p['email'] ?? '',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Color(0xFF6B7CFF),
                                    ),
                                    onPressed: () => _editProfile(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Color(0xFFE53E3E),
                                    ),
                                    onPressed: () => _deleteProfile(index),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

          // Floating back button with glass style
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.white.withOpacity(0.45),
                      foregroundColor: const Color(0xFF2D3748),
                      elevation: 0,
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text(
                        'Back',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}