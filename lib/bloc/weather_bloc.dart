import 'dart:async';
import 'dart:math';

import 'package:bloc_pattern_ex/bloc/weather_event.dart';
import 'package:bloc_pattern_ex/bloc/weather_state.dart';
import 'package:bloc_pattern_ex/model/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent , WeatherState>{

  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{

   if(event is GetWeather){
    yield LoadingWeatherState();

    final weatherModel = await getWeather(event.cityName);

    yield LoadedWeatherState(weatherModel);
   }

  }

  Future<WeatherModel> getWeather (String cityName) async{
   return Future.delayed(Duration(seconds: 1) , (){
     return WeatherModel(
       cityName: cityName,
       temperature: 24.0 + Random().nextInt(15)
     );
   });
}


}
