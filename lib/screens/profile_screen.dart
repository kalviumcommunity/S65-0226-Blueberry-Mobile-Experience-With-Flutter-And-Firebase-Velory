import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/models.dart';
import '../widgets/custom_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = User.dummy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                color: AppColors.softYellow.withValues(alpha: 0.32),
                border: const Border(
                  bottom: BorderSide(color: AppColors.softYellow),
                ),
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        _user.avatar,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // User Name
                  Text(
                    _user.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // User Email
                  Text(
                    _user.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.mediumGrey,
                    ),
                  ),
                ],
              ),
            ),
            // Stats Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stats',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: StatsCard(
                          label: 'Routes Added',
                          value: _user.routesAdded.toString(),
                          icon: Icons.route,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatsCard(
                          label: 'Avg Rating',
                          value: _user.averageRating.toStringAsFixed(1),
                          icon: Icons.star,
                          color: AppColors.warmOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: StatsCard(
                          label: 'Member Since',
                          value: '${_user.joinedDate.year}',
                          icon: Icons.calendar_today,
                          color: AppColors.actionRed,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatsCard(
                          label: 'Rank',
                          value: 'Silver',
                          icon: Icons.emoji_events,
                          color: AppColors.softYellow,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  _buildMenuSectionTitle(context, 'Account'),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    context,
                    icon: Icons.person_outline,
                    label: 'Edit Profile',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.lock_outline,
                    label: 'Change Password',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.security,
                    label: 'Privacy Settings',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  _buildMenuSectionTitle(context, 'Support & Info'),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    label: 'Help & Support',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.info_outline,
                    label: 'About Velory',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.policy,
                    label: 'Privacy Policy',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  // Logout Button
                  VeloryButton(
                    label: 'Logout',
                    onPressed: () {
                      _showLogoutDialog();
                    },
                    backgroundColor: AppColors.actionRed,
                  ),
                  const SizedBox(height: 24),
                  // Version Info
                  Text(
                    'Velory v1.0.0',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.lightGrey,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSectionTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryBlue),
        title: Text(label),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.lightGrey),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout?'),
        content: const Text('Are you sure you want to logout from Velory?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.actionRed),
            ),
          ),
        ],
      ),
    );
  }
}
