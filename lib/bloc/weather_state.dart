import 'package:bloc_pattern_ex/model/weather_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherState extends Equatable{
  final List props;

  WeatherState([this.props= const[]]):super();

}

 class InitialWeatherState extends WeatherState{

}

class LoadingWeatherState extends WeatherState{

}

class LoadedWeatherState extends WeatherState{

   final WeatherModel weatherModel;

   LoadedWeatherState(this.weatherModel): super([weatherModel]);
}











