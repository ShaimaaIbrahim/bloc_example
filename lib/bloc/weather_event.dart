import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


//used to make all instances from this class is final
@immutable
abstract class WeatherEvent implements Equatable{

  final List props ;

  WeatherEvent([this.props= const[]]): super();

}

 class GetWeather extends WeatherEvent{

  final String cityName;

  GetWeather({this.cityName}):super([cityName]);

  @override
  // TODO: implement stringify
  bool get stringify => throw UnimplementedError();
}


