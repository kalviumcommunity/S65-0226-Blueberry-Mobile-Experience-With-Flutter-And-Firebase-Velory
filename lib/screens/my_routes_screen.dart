import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/models.dart' as models;
import '../widgets/custom_widgets.dart';

class MyRoutesScreen extends StatefulWidget {
  const MyRoutesScreen({Key? key}) : super(key: key);

  @override
  State<MyRoutesScreen> createState() => _MyRoutesScreenState();
}

class _MyRoutesScreenState extends State<MyRoutesScreen> {
  late List<models.Route> _myRoutes;

  @override
  void initState() {
    super.initState();
    _myRoutes = models.Route.getDummyRoutes();
  }

  void _deleteRoute(String routeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Route?'),
        content: const Text('Are you sure you want to delete this route?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _myRoutes.removeWhere((route) => route.id == routeId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Route deleted')),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.actionRed),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('My Routes'),
        elevation: 0,
        backgroundColor: AppColors.primaryBlue,
      ),
      body: _myRoutes.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats Section
                    Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            label: 'Routes Added',
                            value: _myRoutes.length.toString(),
                            icon: Icons.route,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatsCard(
                            label: 'Avg. Rating',
                            value: (_myRoutes.fold<double>(0, (sum, route) => sum + route.safetyRating) / _myRoutes.length).toStringAsFixed(1),
                            icon: Icons.star,
                            color: AppColors.warmOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    // Filters
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _filterChip('All', true),
                          const SizedBox(width: 8),
                          _filterChip('Running', false),
                          const SizedBox(width: 8),
                          _filterChip('Cycling', false),
                          const SizedBox(width: 8),
                          _filterChip('Easy', false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Routes List Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Routes (${_myRoutes.length})',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              child: Text('Newest First'),
                            ),
                            const PopupMenuItem(
                              child: Text('Highest Rating'),
                            ),
                            const PopupMenuItem(
                              child: Text('Longest Distance'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Routes List
                    ..._myRoutes.asMap().entries.map((entry) {
                      final index = entry.key;
                      final route = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index < _myRoutes.length - 1 ? 12 : 0,
                        ),
                        child: RouteCard(
                          routeName: route.name,
                          location: route.startLocation.name,
                          safetyRating: route.safetyRating,
                          distance: '${route.distance} km',
                          difficulty: route.difficulty,
                          onTap: () {
                            _showRouteDetails(route);
                          },
                          onDelete: () => _deleteRoute(route.id),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-route');
        },
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.route,
                size: 64,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Routes Yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first route and share it with the community',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.mediumGrey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            VeloryButton(
              label: 'Add Route',
              onPressed: () {
                Navigator.pushNamed(context, '/add-route');
              },
              backgroundColor: AppColors.primaryBlue,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label, bool isActive) {
    return FilterChip(
      label: Text(label),
      selected: isActive,
      onSelected: (selected) {},
      backgroundColor: AppColors.veryLightGrey,
      selectedColor: AppColors.primaryBlue.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isActive ? AppColors.primaryBlue : AppColors.mediumGrey,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
      ),
      side: BorderSide(
        color: isActive ? AppColors.primaryBlue : AppColors.lightGrey,
      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Created ${_formatDate(route.dateAdded)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.mediumGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Details Grid
            Row(
              children: [
                Expanded(
                  child: _statColumn(
                    context,
                    label: 'Distance',
                    value: '${route.distance} km',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statColumn(
                    context,
                    label: 'Completions',
                    value: route.completions.toString(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statColumn(
                    context,
                    label: 'Rating',
                    value: '${route.safetyRating}/5.0',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: VelorySecondaryButton(
                    label: 'Edit',
                    onPressed: () => Navigator.pop(context),
                    borderColor: AppColors.primaryBlue,
                    textColor: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: VelorySecondaryButton(
                    label: 'Delete',
                    onPressed: () {
                      Navigator.pop(context);
                      _deleteRoute(route.id);
                    },
                    borderColor: AppColors.actionRed,
                    textColor: AppColors.actionRed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statColumn(BuildContext context, {required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.veryLightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.mediumGrey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    if (difference == 0) return 'today';
    if (difference == 1) return 'yesterday';
    if (difference < 7) return '$difference days ago';
    if (difference < 30) return '${(difference / 7).floor()} weeks ago';
    return '${(difference / 30).floor()} months ago';
  }
}
