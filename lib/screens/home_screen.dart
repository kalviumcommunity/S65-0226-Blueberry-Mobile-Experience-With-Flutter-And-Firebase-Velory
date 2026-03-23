import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/models.dart' as models;
import '../widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<models.Route> _routes;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _routes = models.Route.getDummyRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Discover Routes'),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Section
            Container(
              height: 292,
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              decoration: BoxDecoration(
                color: AppColors.softYellow.withValues(alpha: 0.28),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.softYellow),
              ),
              child: Stack(
                children: [
                  // Fake Map Background
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.white,
                          AppColors.softYellow.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.map,
                            size: 64,
                            color: AppColors.lightGrey,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Map View',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.mediumGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Route Markers
                  Positioned(
                    top: 80,
                    left: 40,
                    child: _buildMapMarker('Central Park', AppColors.actionRed),
                  ),
                  Positioned(
                    top: 120,
                    right: 50,
                    child: _buildMapMarker('Riverside', AppColors.warmOrange),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 60,
                    child: _buildMapMarker('Mountain Trail', AppColors.primaryBlue),
                  ),
                  Positioned(
                    bottom: 80,
                    right: 40,
                    child: _buildMapMarker('Downtown', AppColors.primaryBlue),
                  ),
                  // Search Bar Overlay
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: LocationSearchBar(
                      hint: 'Find safe routes...',
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Routes Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Routes',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Routes List
                  ..._routes.map((route) {
                    return RouteCard(
                      routeName: route.name,
                      location: route.startLocation.name,
                      safetyRating: route.safetyRating,
                      distance: '${route.distance} km',
                      difficulty: route.difficulty,
                      onTap: () {
                        _showRouteDetails(route);
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  // Featured Tip
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.softYellow.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.softYellow),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.softYellow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.lightbulb_outline,
                            color: AppColors.darkGrey,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pro Tip',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Always run during peak hours for better safety',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.mediumGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-route');
        },
        backgroundColor: AppColors.actionRed,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMapMarker(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.28),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.location_on,
              color: AppColors.white,
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  void _showRouteDetails(models.Route route) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  route.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Details Grid
            Row(
              children: [
                Expanded(
                  child: _detailItem(
                    context,
                    icon: Icons.route,
                    label: 'Distance',
                    value: '${route.distance} km',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _detailItem(
                    context,
                    icon: Icons.timer,
                    label: 'Est. Time',
                    value: '${route.estimatedTime} min',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _detailItem(
                    context,
                    icon: Icons.trending_up,
                    label: 'Difficulty',
                    value: route.difficulty,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Description
            Text(
              'About',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(
              route.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.mediumGrey,
              ),
            ),
            const SizedBox(height: 24),
            // Start Route Button
            VeloryButton(
              label: 'Start Route',
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Starting: ${route.name}')),
                );
              },
              backgroundColor: AppColors.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(BuildContext context, {required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryBlue, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.mediumGrey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
