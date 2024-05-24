# Flutter Weather App

This is a simple Flutter weather app that fetches and displays weather information from the OpenWeatherMap API.

## Features

- **Current Weather:** Displays the current temperature, condition, and other relevant weather data for a given city.
- **5-Day Forecast:** Provides a 5-day forecast with daily high/low temperatures and weather conditions.
- **City Search:** Allows users to search for weather information by entering a city name.
- **Favorites:** Users can add their favorite cities to a list for quick access.

## Screenshots

<img src="https://github.com/bizz84/rockweatherapp/blob/main/.github/images/weather-forecast.png?raw=true" alt="Flutter Weather App Preview" width=50% height=50%>

## Getting Started

1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/flutter-weather-app.git
    ```

2. **Install dependencies:**
    ```bash
    cd flutter-weather-app
    flutter pub get
    ```

3. **Get an OpenWeatherMap API key:**
    - Sign up for a free account at [https://openweathermap.org/](https://openweathermap.org/).
    - Obtain your API key from your account settings.

4. **Set the API key:**
    - Create a file named `lib/src/api/api_keys.dart`.
    - Add the following code, replacing `YOUR_API_KEY` with your actual API key:
        ```dart
        const String apiKey = 'YOUR_API_KEY';
        ```

5. **Run the app:**
    ```bash
    flutter run
    ```

## Project Structure

The project follows a layered architecture, separating concerns into different layers:

- **Data Layer:** Handles data fetching and parsing from the OpenWeatherMap API.
- **Domain Layer:** Defines business logic and models for weather data.
- **Presentation Layer:** Manages UI and user interactions.

## Libraries

- **riverpod:** State management
- **freezed:** Code generation
- **http:** Networking
- **cached_network_image:** Image caching
- **mocktail:** Testing

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.