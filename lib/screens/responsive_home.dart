import 'package:flutter/material.dart';

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get device dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    
    // Determine device type
    final isTablet = screenWidth > 600;
    final isLargeTablet = screenWidth > 920;
    
    return Scaffold(
      appBar: _buildAppBar(isTablet),
      body: isLargeTablet
          ? _buildLargeTabletLayout()
          : isTablet
              ? _buildTabletLayout(isPortrait)
              : _buildPhoneLayout(isPortrait),
      bottomNavigationBar: isTablet
          ? null
          : _buildBottomNavBar(),
      drawer: isTablet ? _buildDrawer() : null,
    );
  }

  // ============ App Bar ============
  PreferredSizeWidget _buildAppBar(bool isTablet) {
    return AppBar(
      title: const Text('Velory'),
      centerTitle: !isTablet,
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      elevation: 2,
      actions: isTablet
          ? [
              TextButton.icon(
                onPressed: () => _showSnackBar('Home'),
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text('Home', style: TextStyle(color: Colors.white)),
              ),
              TextButton.icon(
                onPressed: () => _showSnackBar('Routes'),
                icon: const Icon(Icons.route, color: Colors.white),
                label: const Text('Routes', style: TextStyle(color: Colors.white)),
              ),
              TextButton.icon(
                onPressed: () => _showSnackBar('Settings'),
                icon: const Icon(Icons.settings, color: Colors.white),
                label: const Text('Settings', style: TextStyle(color: Colors.white)),
              ),
            ]
          : null,
    );
  }

  // ============ Large Tablet Layout (920+ width) ============
  Widget _buildLargeTabletLayout() {
    return Row(
      children: [
        // Sidebar
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: 280,
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Navigation',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _buildDrawerTile(Icons.home, 'Home', 0, () {
                        setState(() => _selectedIndex = 0);
                        _showSnackBar('Home');
                      }),
                      _buildDrawerTile(Icons.route, 'Routes', 1, () {
                        setState(() => _selectedIndex = 1);
                        _showSnackBar('Routes');
                      }),
                      _buildDrawerTile(Icons.favorite, 'Favorites', 2, () {
                        setState(() => _selectedIndex = 2);
                        _showSnackBar('Favorites');
                      }),
                      _buildDrawerTile(Icons.settings, 'Settings', 3, () {
                        setState(() => _selectedIndex = 3);
                        _showSnackBar('Settings');
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Main Content
        Expanded(
          child: _buildMainContent(),
        ),
      ],
    );
  }

  // ============ Tablet Layout (600-920 width) ============
  Widget _buildTabletLayout(bool isPortrait) {
    if (isPortrait) {
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: _buildMainContent(),
          ),
          Expanded(
            child: _buildFooterSection(),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildMainContent(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _buildFooterSection(),
            ),
          ),
        ],
      );
    }
  }

  // ============ Phone Layout (<600 width) ============
  Widget _buildPhoneLayout(bool isPortrait) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMainContent(),
          const SizedBox(height: 32),
          _buildFooterSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ============ Main Content Area ============
  Widget _buildMainContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isMobile = screenWidth < 600;

    // Responsive padding
    final horizontalPadding = isMobile ? 16.0 : isTablet ? 32.0 : 48.0;
    final verticalPadding = isMobile ? 20.0 : isTablet ? 32.0 : 40.0;

    // Responsive font sizes
    final titleFontSize = isMobile ? 28.0 : isTablet ? 32.0 : 40.0;
    final subtitleFontSize = isMobile ? 16.0 : isTablet ? 18.0 : 20.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeroIcon(isMobile),
                  SizedBox(height: isMobile ? 24 : 32),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Welcome to Velory',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  Text(
                    'Your intelligent route planning companion',
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 28 : 40),
                  _buildFeatureCards(screenWidth, isMobile, isTablet),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============ Hero Icon with Responsive Size ============
  Widget _buildHeroIcon(bool isMobile) {
    final iconSize = isMobile ? 100.0 : 140.0;
    
    return Container(
      width: iconSize + 20,
      height: iconSize + 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.route,
          size: iconSize,
          color: Colors.white,
        ),
      ),
    );
  }

  // ============ Feature Cards (Responsive Grid) ============
  Widget _buildFeatureCards(double screenWidth, bool isMobile, bool isTablet) {
    // Determine grid layout based on screen width
    final crossAxisCount = screenWidth > 900 ? 3 : isTablet ? 2 : 1;
    final cardWidth = isMobile
        ? double.infinity
        : (screenWidth - (isMobile ? 64 : isTablet ? 96 : 128)) / crossAxisCount;

    final features = [
      {
        'icon': Icons.location_on,
        'title': 'Smart Routes',
        'description': 'AI-powered route optimization',
      },
      {
        'icon': Icons.safety_check,
        'title': 'Safe Passages',
        'description': 'Real-time safety alerts',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Analytics',
        'description': 'Track your journey stats',
      },
    ];

    if (isMobile || (isTablet && screenWidth < 800)) {
      // Single column for mobile and small tablets
      return Column(
        children: features.map((feature) => _buildFeatureCard(feature)).toList(),
      );
    } else if (screenWidth < 900) {
      // Two column grid for medium tablets
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
        children: features.map((feature) => _buildFeatureCard(feature)).toList(),
      );
    } else {
      // Three column grid for large screens
      return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 0.85,
        children: features.map((feature) => _buildFeatureCard(feature)).toList(),
      );
    }
  }

  // ============ Individual Feature Card ============
  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                feature['icon'] as IconData,
                size: 32,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              feature['title'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              feature['description'] as String,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ============ Footer/Action Section ============
  Widget _buildFooterSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final buttonWidth = isMobile ? double.infinity : 200.0;

    return Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.all(isMobile ? 18.0 : 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ready to Get Started?',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: buttonWidth,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => _showSnackBar('Starting journey...'),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Start Journey'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          SizedBox(
            width: buttonWidth,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => _showSnackBar('Showing features...'),
              icon: const Icon(Icons.info_outline),
              label: const Text('Learn More'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepPurple,
                side: const BorderSide(color: Colors.deepPurple, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============ Drawer ============
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.route,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Velory',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerTile(Icons.home, 'Home', 0, () {
            setState(() => _selectedIndex = 0);
            _showSnackBar('Home');
          }),
          _buildDrawerTile(Icons.route, 'Routes', 1, () {
            setState(() => _selectedIndex = 1);
            _showSnackBar('Routes');
          }),
          _buildDrawerTile(Icons.favorite, 'Favorites', 2, () {
            setState(() => _selectedIndex = 2);
            _showSnackBar('Favorites');
          }),
          _buildDrawerTile(Icons.settings, 'Settings', 3, () {
            setState(() => _selectedIndex = 3);
            _showSnackBar('Settings');
          }),
        ],
      ),
    );
  }

  // ============ Drawer Tile ============
  ListTile _buildDrawerTile(
    IconData icon,
    String title,
    int index,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: _selectedIndex == index ? Colors.deepPurple : null),
      title: Text(title),
      selected: _selectedIndex == index,
      selectedTileColor: Colors.deepPurple.shade100,
      onTap: onTap,
    );
  }

  // ============ Bottom Navigation Bar ============
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() => _selectedIndex = index);
        final labels = ['Home', 'Routes', 'Favorites', 'Settings'];
        _showSnackBar(labels[index]);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Routes'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }

  // ============ Helper Methods ============
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
