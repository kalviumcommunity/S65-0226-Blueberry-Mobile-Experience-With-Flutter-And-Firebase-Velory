import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_widgets.dart';

class AddRouteScreen extends StatefulWidget {
  const AddRouteScreen({Key? key}) : super(key: key);

  @override
  State<AddRouteScreen> createState() => _AddRouteScreenState();
}

class _AddRouteScreenState extends State<AddRouteScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _startLocationController;
  late TextEditingController _endLocationController;
  double _safetyRating = 3.5;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _startLocationController = TextEditingController();
    _endLocationController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _startLocationController.dispose();
    _endLocationController.dispose();
    super.dispose();
  }

  void _handleAddRoute() {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _startLocationController.text.isEmpty ||
        _endLocationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Route added successfully!')),
        );
        Navigator.pushReplacementNamed(context, '/my-routes');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Add New Route'),
        elevation: 0,
        backgroundColor: AppColors.primaryBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle
              Text(
                'Share a safe route with the community',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.mediumGrey,
                    ),
              ),
              const SizedBox(height: 28),
              // Route Name
              VeloryTextField(
                label: 'Route Name',
                hint: 'e.g., Sunset Park Loop',
                controller: _nameController,
                prefixIcon: Icons.title,
              ),
              const SizedBox(height: 20),
              // Description
              VeloryTextField(
                label: 'Description',
                hint: 'Describe the route, highlights, and hazards...',
                controller: _descriptionController,
                maxLines: 4,
                minLines: 3,
                prefixIcon: Icons.description_outlined,
              ),
              const SizedBox(height: 20),
              // Start Location
              VeloryTextField(
                label: 'Start Location',
                hint: 'Where does the route begin?',
                controller: _startLocationController,
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 20),
              // End Location
              VeloryTextField(
                label: 'End Location',
                hint: 'Where does the route end?',
                controller: _endLocationController,
                prefixIcon: Icons.location_on,
              ),
              const SizedBox(height: 32),
              // Safety Rating Slider
              SafetyRatingSlider(
                initialValue: _safetyRating,
                onChanged: (value) {
                  setState(() => _safetyRating = value);
                },
              ),
              const SizedBox(height: 32),
              // Route Type Section
              Text(
                'Route Type',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _routeTypeChip('Running', Icons.directions_run),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _routeTypeChip('Cycling', Icons.directions_bike),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _routeTypeChip('Both', Icons.groups),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Lighting Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.warmOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.warmOrange),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.warmOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.info,
                        color: AppColors.white,
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
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.warmOrange,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Routes with higher safety ratings get featured!',
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
              const SizedBox(height: 32),
              // Add Route Button
              VeloryButton(
                label: 'Add Route',
                onPressed: _handleAddRoute,
                isLoading: _isLoading,
                backgroundColor: AppColors.actionRed,
              ),
              const SizedBox(height: 16),
              // Cancel Button
              VelorySecondaryButton(
                label: 'Cancel',
                onPressed: () => Navigator.pop(context),
                borderColor: AppColors.lightGrey,
                textColor: AppColors.mediumGrey,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _routeTypeChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.veryLightGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
