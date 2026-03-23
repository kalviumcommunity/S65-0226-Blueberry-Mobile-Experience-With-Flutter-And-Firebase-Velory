import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'home_screen.dart';
import 'my_routes_screen.dart';
import 'add_route_screen.dart';
import 'profile_screen.dart';

class AppNavigation extends StatefulWidget {
  final int initialIndex;
  final bool showAddRoute;

  const AppNavigation({
    Key? key,
    this.initialIndex = 0,
    this.showAddRoute = false,
  }) : super(key: key);

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late int _selectedIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _selectedIndex);

    // If we need to show add route screen, push it immediately
    if (widget.showAddRoute) {
      Future.microtask(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddRouteScreen()),
        ).then((_) {
          // After add route screen closes, go to my-routes
          if (mounted) {
            setState(() => _selectedIndex = 1);
            _pageController.jumpToPage(1);
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 2) {
      // Favorites - show message (placeholder)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Favorites - Coming Soon!')),
      );
      return;
    }

    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const MyRoutesScreen(),
      _buildFavoritesPlaceholder(), // Placeholder for favorites
      const ProfileScreen(),
    ];

    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _selectedIndex != 0) {
          setState(() => _selectedIndex = 0);
          _pageController.jumpToPage(0);
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onNavTap,
          indicatorColor: AppColors.softYellow.withValues(alpha: 0.55),
          backgroundColor: AppColors.white,
          height: 74,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.route_outlined),
              selectedIcon: Icon(Icons.route),
              label: 'Routes',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesPlaceholder() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              size: 80,
              color: AppColors.actionRed.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 24),
            Text(
              'Favorites',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Your favorite routes will appear here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.mediumGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
