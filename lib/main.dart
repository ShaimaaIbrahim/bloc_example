import 'package:bloc_pattern_ex/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_event.dart';
import 'bloc/weather_state.dart';
import 'model/weather_model.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final WeatherBloc _bloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
         return _bloc;
        },
        child: Container(

          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: BlocListener(

            listener: (BuildContext context, state) {

              if(state is InitialWeatherState){
                return buildInitialInput();
              }
              else if(state is LoadedWeatherState){
                return buildColumnWithData(state.weatherModel);
              }
              else if(state is LoadingWeatherState){
                return buildLoading();
              }

            },

            child: BlocBuilder(
              bloc: _bloc,
              builder: (BuildContext context , WeatherState state){
                if(state is InitialWeatherState){
                   return buildInitialInput();
                }
                else if(state is LoadedWeatherState){
                  return buildColumnWithData(state.weatherModel);
                }
                else if(state is LoadingWeatherState){
                 return buildLoading();
                }
              },
            ),
          ),
        ),
      ),

    );


  }

  @override
  void dispose() {
   super.dispose();
   _bloc.close();
  }
}

Widget buildInitialInput(){
 return Center(
  child: TextField(),
 );
}

Widget buildLoading(){
  return Center(
   child: CircularProgressIndicator(),

  );
}


Column buildColumnWithData(WeatherModel weatherModel){

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(
         weatherModel.cityName,
      ),
      Text(
          '${weatherModel.temperature.toString()} c'
      ),
     SearchWidget(),
    ],
  );
}

class SearchWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _SearchWiget();
  }

}
class _SearchWiget extends State<SearchWidget>{

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: EdgeInsets.symmetric(vertical: 15 , horizontal: 15),
      child: TextField(
        onSubmitted: submitCityName,

        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'enter city name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
 void submitCityName(String cityName){
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(cityName: cityName));
    weatherBloc.close();

 }

}


