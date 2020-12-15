import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
class WeatherModel extends Equatable{

  final String cityName;
  final double temperature;

  WeatherModel({@required this.cityName, @required this.temperature});

  @override
  List<Object> get props => [cityName , temperature];



}