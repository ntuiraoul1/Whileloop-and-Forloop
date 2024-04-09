import 'dart:convert';
import 'dart:io';

void main() {
  final apiKey =
      'YOUR_API_KEY'; // Replace 'YOUR_API_KEY' with your actual API key
  final city =
      'New York'; // Specify the city for which you want to fetch weather data

  fetchWeather(apiKey, city)
      .then((weatherData) => displayWeather(weatherData))
      .catchError((error) => print('Error: $error'));
}

Future<Map<String, dynamic>> fetchWeather(String apiKey, String city) async {
  final apiUrl =
      'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.getUrl(Uri.parse(apiUrl));
  HttpClientResponse response = await request.close();

  if (response.statusCode != HttpStatus.ok) {
    throw Exception('Failed to fetch weather data: ${response.statusCode}');
  }

  String jsonString = await response.transform(utf8.decoder).join();
  Map<String, dynamic> data = jsonDecode(jsonString);

  httpClient.close();

  return data;
}

void displayWeather(Map<String, dynamic> weatherData) {
  final cityName = weatherData['name'];
}
