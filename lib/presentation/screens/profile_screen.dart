import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../values/colors.dart';
import '../values/fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 32),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            Iconsax.user_copy,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),

                        Text(
                          'Staff Member',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),

                        Text(
                          'Internal User',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.regular,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  _buildInfoCard(
                    icon: Iconsax.sms,
                    iconColor: Colors.blue,
                    iconBgColor: Colors.blue.withValues(alpha: 0.1),
                    title: 'Email',
                    subtitle: 'staff@company.com',
                  ),

                  SizedBox(height: 12),

                  _buildInfoCard(
                    icon: Iconsax.call,
                    iconColor: AppColors.primaryColor,
                    iconBgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                    title: 'Phone',
                    subtitle: '+1 234 567 8900',
                  ),

                  SizedBox(height: 16),

                  // Settings Card
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontFamily: AppFonts.regular,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildSettingsItem('Change Password'),
                        Divider(height: 32),
                        _buildSettingsItem('Notification Settings'),
                        Divider(height: 32),
                        _buildSettingsItem('Privacy Settings'),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.regular,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: AppFonts.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: AppFonts.bold,
            color: Colors.black87,
          ),
        ),
        Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
        ),
      ],
    );
  }
}