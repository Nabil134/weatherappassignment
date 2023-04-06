class AppUrl {
  // this is our base url
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=karachi&appid=205102d0bcad9cb763cd854449d30c7a';

  // fetch world covid states
  static const String worldStatesApi = baseUrl + 'all';
  static const String countriesList = baseUrl + 'countries';
}
