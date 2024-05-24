import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_mobile/src/features/weather/application/manage_cache_provider.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/weather_page.dart';

class AddCityScreen extends ConsumerStatefulWidget {
  const AddCityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends ConsumerState<AddCityScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cityController = TextEditingController();
    final favoriteCities = ref.watch(favoriteCitiesProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dawn_sky.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add City',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City Name',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.location_city, color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city name';
                  } else if (value.length < 3) {
                    return 'City name must be at least 3 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    String city = cityController.text.trim();
                    ref
                        .read(favoriteCitiesProvider.notifier)
                        .addFavoriteCity(city);
                    cityController.clear(); // Clear the input field
                  }
                },
                child: const Text('Add City'),
              ),
              const SizedBox(height: 20),
              // Display the added cities (Optional)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Favorite Cities:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tooltip(
                      message: 'Swipe left on a city to delete it.',
                      preferBelow: false,
                      verticalOffset: 20,
                      enableFeedback: true,
                      showDuration: const Duration(seconds: 3),
                      child: Icon(Icons.help_outline, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: favoriteCities.length,
                  onReorder: (oldIndex, newIndex) {
                    ref
                        .read(favoriteCitiesProvider.notifier)
                        .reorder(oldIndex, newIndex);
                  },
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(favoriteCities[index]),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        ref
                            .read(favoriteCitiesProvider.notifier)
                            .deleteFavoriteCity(index);
                      },
                      child: ListTile(
                        title: Text(favoriteCities[index],
                            style: const TextStyle(color: Colors.white)),
                        onTap: () {
                          // Navigate to WeatherPage with the selected city
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherPage(
                                city: favoriteCities[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              // Add this button to navigate to the weather data screen
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WeatherPage(city: cityController.text.trim());
                      },
                    ),
                  );
                },
                child: const Text('Go to Weather Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
