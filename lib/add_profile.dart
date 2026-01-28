import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'profile_list.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key});

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final regCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  List<Map<String, String>> profiles = [];

  void _addProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        profiles.add({
          'name': nameCtrl.text.trim(),
          'reg': regCtrl.text.trim(),
          'email': emailCtrl.text.trim(),
          'mobile': mobileCtrl.text.trim(),
        });
      });
      nameCtrl.clear();
      regCtrl.clear();
      emailCtrl.clear();
      mobileCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile added successfully!'),
          backgroundColor: Colors.teal.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lighter, softer pastel gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE6F0FF), // very light blue
                  Color(0xFFF0E8FF), // soft lavender
                  Color(0xFFFAF9FF), // almost white
                ],
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),

                          // Softer glass header card
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: BackdropFilter(
                              filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.28), // lighter / more visible
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(color: Colors.white.withOpacity(0.45)),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person_add_alt_1_rounded,
                                      size: 90,
                                      color: const Color(0xFF6B7CFF), // softer blue-indigo
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Create New Profile',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2D3748),
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Add Your University Student Details',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,

                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Lighter glass form container
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: BackdropFilter(
                              filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                              child: Container(
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.32),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(color: Colors.white.withOpacity(0.50)),
                                ),
                                child: Column(
                                  children: [
                                    _buildGlassTextField(
                                      controller: nameCtrl,
                                      label: 'Full Name',
                                      icon: Icons.person_outline_rounded,
                                      validator: (v) => v?.trim().isEmpty ?? true ? 'Required' : null,
                                    ),
                                    const SizedBox(height: 20),

                                    _buildGlassTextField(
                                      controller: regCtrl,
                                      label: 'Registration Number',
                                      icon: Icons.badge_outlined,
                                      validator: (v) => v?.trim().isEmpty ?? true ? 'Required' : null,
                                    ),
                                    const SizedBox(height: 20),

                                    _buildGlassTextField(
                                      controller: emailCtrl,
                                      label: 'Email Address',
                                      icon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (v) {
                                        if (v == null || v.trim().isEmpty) return 'Required';
                                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                                          return 'Enter valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),

                                    _buildGlassTextField(
                                      controller: mobileCtrl,
                                      label: 'Mobile Number (10 digits)',
                                      icon: Icons.phone_android_rounded,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 10,
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Mobile number is required';
                                        }
                                        final cleaned = value.trim().replaceAll(RegExp(r'[^0-9]'), '');
                                        if (cleaned.length != 10) {
                                          return 'Please enter exactly 10 digits';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 48),

                          // Softer gradient button
                          Container(
                            height: 62,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  ui.Color.fromARGB(255, 71, 116, 231),
                                  ui.Color.fromARGB(255, 71, 55, 151),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF9FBAFF).withOpacity(0.45),
                                  blurRadius: 16,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: _addProfile,
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.add_rounded, color: Colors.white, size: 28),
                                      SizedBox(width: 14),
                                      Text(
                                        'Add Profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          OutlinedButton.icon(
                            icon: const Icon(Icons.list_alt_rounded, color: ui.Color.fromARGB(255, 64, 81, 204)),
                            label: const Text(
                              'View All Profiles',
                              style: TextStyle(color: Color(0xFF4A5568), fontSize: 17),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              side: const BorderSide(color: Color(0xFF9FBAFF), width: 1.8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProfileListPage(profiles: profiles),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
      style: const TextStyle(color: Color(0xFF2D3748)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        prefixIcon: Icon(icon, color: const Color(0xFF6B7CFF)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF9FBAFF), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
        counterText: "",
      ),
    );
  }
}