# WeatherNow: Your Pocket Weather Companion

WeatherNow is a comprehensive Flutter weather application that provides real-time and forecast weather information, along with intuitive features for managing your favorite locations. Built with a focus on user experience and reliability, WeatherNow empowers you to stay informed about the weather wherever you go.

## Features

**Essential Weather Data:**

* **Current Weather:**  Get up-to-date weather conditions, including temperature, feels-like temperature, humidity, wind speed, and weather description.
* **5-Day Forecast:**  Plan ahead with a detailed 5-day forecast that displays daily high/low temperatures, weather conditions, and precipitation probabilities.

**User-Friendly Interface:**

* **Intuitive City Search:** Effortlessly find weather information for any location by simply entering a city name.
* **Favorites List:**  Keep track of your frequently visited locations by adding them to a customizable favorites list. Easily access weather for your favorite cities with a single tap.
* **Reorderable Favorites:** Organize your favorites list to prioritize your most important locations.
* **Smooth Swipe Navigation:**  Browse through your favorite cities with a simple swipe motion. 

**Offline Access:**

* **Data Caching:** WeatherNow caches data in your device's database, ensuring you have access to recent weather information even when you're offline.  
* **Seamless Transition:** The app automatically switches between online and offline modes, providing a seamless user experience regardless of your internet connection.

## Technologies Used

* **Flutter:**  The foundation of the app, a cross-platform framework for building beautiful and performant mobile applications.
* **Riverpod:**  A powerful state management solution that simplifies data handling and makes code more maintainable.
* **OpenWeatherMap API:** Provides accurate and up-to-date weather data for locations worldwide.
* **SQLite:** A local database used to cache weather data for offline access. 
* **SharedPreferences:**  Used to store user preferences, such as the list of favorite cities.
* **Other Packages:** `http`, `sqflite`, `shared_preferences`, `cached_network_image` and others, carefully chosen to enhance the app's functionality and performance.

## Getting Started

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/your-username/weather-app-mobile.git
    ```

2. **Install Dependencies:**
    ```bash
    cd weather-app-mobile
    flutter pub get
    ```

3. **Obtain OpenWeatherMap API Key:**
    - Sign up for a free OpenWeatherMap account at [https://openweathermap.org/](https://openweathermap.org/).
    - Obtain your API key from your account settings.

4. **Set API Key:**
    - Create a file named `lib/src/api/api_keys.dart` in your project.
    - Add the following code, replacing `YOUR_API_KEY` with your actual API key:
        ```dart
        const String apiKey = 'YOUR_API_KEY';
        ```

5. **Run the App:**
    ```bash
    flutter run
    ```

## Project Structure

The project is organized using a layered architecture to promote code maintainability and scalability:

* **Data Layer:**  Responsible for fetching and parsing data from the OpenWeatherMap API.
* **Domain Layer:**  Defines business logic and models related to weather data.
* **Presentation Layer:** Handles the user interface and user interactions.

## Contributing

Contributions are welcome! If you'd like to contribute to WeatherNow, please feel free to fork the repository, make changes, and submit a pull request. 

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.