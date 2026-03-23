class User {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final int routesAdded;
  final double averageRating;
  final DateTime joinedDate;

  User({
    String? id,
    required this.name,
    required this.email,
    this.avatar = '👤',
    this.routesAdded = 0,
    this.averageRating = 0.0,
    DateTime? joinedDate,
  })  : id = id ?? 'user_${DateTime.now().millisecondsSinceEpoch}',
        joinedDate = joinedDate ?? DateTime.now();

  factory User.dummy() {
    return User(
      id: '1',
      name: 'Rohithraj K A',
      email: 'rohithraj@velory.app',
      avatar: '👤',
      routesAdded: 12,
      averageRating: 4.5,
      joinedDate: DateTime(2024, 1, 15),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;
  final String name;

  Location({
    required this.latitude,
    required this.longitude,
    required this.name,
  });
}

class Route {
  final String id;
  final String name;
  final String description;
  final Location startLocation;
  final Location endLocation;
  final double safetyRating;
  final DateTime dateAdded;
  final double distance;
  final int estimatedTime;
  final String difficulty;
  final int completions;

  Route({
    String? id,
    required this.name,
    required this.description,
    required this.startLocation,
    required this.endLocation,
    required this.safetyRating,
    DateTime? dateAdded,
    required this.distance,
    required this.estimatedTime,
    required this.difficulty,
    this.completions = 0,
  })  : id = id ?? 'route_${DateTime.now().millisecondsSinceEpoch}',
        dateAdded = dateAdded ?? DateTime.now();

  factory Route.dummy1() {
    return Route(
      id: '1',
      name: 'Sunrise Park Circuit',
      description: 'Beautiful loop around Central Park with excellent lighting and community presence.',
      startLocation: Location(latitude: 40.7829, longitude: -73.9654, name: 'Central Park North'),
      endLocation: Location(latitude: 40.7829, longitude: -73.9654, name: 'Central Park North'),
      safetyRating: 4.8,
      dateAdded: DateTime.now().subtract(const Duration(days: 5)),
      distance: 6.5,
      estimatedTime: 45,
      difficulty: 'Easy',
      completions: 234,
    );
  }

  factory Route.dummy2() {
    return Route(
      id: '2',
      name: 'Riverside Trail Explorer',
      description: 'Scenic riverside path with well-maintained road. Popular among cyclists and runners.',
      startLocation: Location(latitude: 40.7505, longitude: -73.9972, name: 'Hudson River Park'),
      endLocation: Location(latitude: 40.7614, longitude: -73.9776, name: 'Pier 96'),
      safetyRating: 4.3,
      dateAdded: DateTime.now().subtract(const Duration(days: 12)),
      distance: 8.2,
      estimatedTime: 55,
      difficulty: 'Medium',
      completions: 156,
    );
  }

  factory Route.dummy3() {
    return Route(
      id: '3',
      name: 'Mountain Peak Challenge',
      description: 'Challenging mountain route with breathtaking views. Well-marked with safety barriers.',
      startLocation: Location(latitude: 40.8448, longitude: -73.8648, name: 'Bronx Park'),
      endLocation: Location(latitude: 40.8530, longitude: -73.8719, name: 'Mountain Top'),
      safetyRating: 3.9,
      dateAdded: DateTime.now().subtract(const Duration(days: 20)),
      distance: 12.1,
      estimatedTime: 90,
      difficulty: 'Hard',
      completions: 89,
    );
  }

  factory Route.dummy4() {
    return Route(
      id: '4',
      name: 'Urban Explorer\'s Path',
      description: 'Modern urban route through downtown with cafes, shops, and rest points.',
      startLocation: Location(latitude: 40.7128, longitude: -74.0060, name: 'Times Square'),
      endLocation: Location(latitude: 40.7489, longitude: -73.9680, name: 'Grand Central'),
      safetyRating: 4.6,
      dateAdded: DateTime.now().subtract(const Duration(days: 8)),
      distance: 4.3,
      estimatedTime: 30,
      difficulty: 'Easy',
      completions: 412,
    );
  }

  static List<Route> getDummyRoutes() {
    return [
      Route.dummy1(),
      Route.dummy2(),
      Route.dummy3(),
      Route.dummy4(),
    ];
  }
}
