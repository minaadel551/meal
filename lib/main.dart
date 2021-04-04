import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/theme_provider.dart';
import './screen/Theme_screen.dart';
import './providers/meal_provider.dart';
import 'package:provider/provider.dart';
import './screen/filters_screen.dart';
import './screen/tabs_screen.dart';
import './screen/meal_detail_screen.dart';
import './screen/category_meal_screen.dart';
import 'providers/language_provider.dart';
import 'screen/on_boarding_screen.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  Widget homeScreen =prefs.getBool('watched')?? false ? TabsScreen():OnBoardingScreen();

  runApp(
    MultiProvider(providers: [
         ChangeNotifierProvider<MealProvider>(create:(context) => MealProvider(),),
         ChangeNotifierProvider<ThemeProvider>(create:(context) => ThemeProvider()),
         ChangeNotifierProvider<LanguageProvider>(create:(context) => LanguageProvider(),),
    ],
       child: MyApp(homeScreen)),
      );
  }



class MyApp extends StatelessWidget {
final Widget mainScreen;
MyApp(this.mainScreen);
    @override
    Widget build(BuildContext context) {
      var  primaryColor= Provider.of<ThemeProvider>(context).primaryColor;
      var accentColor =  Provider.of<ThemeProvider>(context).accentColor;
      var tm =Provider.of<ThemeProvider>(context).tm;
      return MaterialApp(
       debugShowCheckedModeBanner: false,
        title: 'Meal App',
        themeMode: tm,
        darkTheme: ThemeData(
         primaryColor: primaryColor,
         accentColor: accentColor,
         unselectedWidgetColor: Colors.white60,
         buttonColor: Colors.white70,
         cardColor: Color.fromRGBO(35, 34, 39, 1),
         shadowColor: Colors.black26,
           canvasColor: Color.fromRGBO(14, 22, 33, 1),
         textTheme: ThemeData.dark().textTheme.copyWith(
           body1: TextStyle(color:Colors.white60 ),
           title: TextStyle(fontSize: 20,fontFamily:'RobotoCondensed',fontWeight: FontWeight.bold,color: Colors.white70,),
         )
       ),
         theme: ThemeData(
           shadowColor: Colors.white60,
          buttonColor: Colors.black87,
         cardColor: Colors.white,
         primaryColor: primaryColor,
         accentColor: accentColor,
         canvasColor: Color.fromRGBO(255, 254, 229, 1),
         textTheme: ThemeData.light().textTheme.copyWith(
           body1: TextStyle(color:Colors.black87 ),
           title: TextStyle(fontSize: 20,fontFamily:'RobotoCondensed',fontWeight: FontWeight.bold),
         )
       ),
       routes: {
         '/':(context)=> mainScreen,
         TabsScreen.routeName:(context)=>TabsScreen(),
         CategoryMealScreen.routeName:(context)=>CategoryMealScreen(),
         MealDetailScreen.routeName:(context)=>MealDetailScreen(),
         FiltersScreen.routeName:(context)=>FiltersScreen(),
         ThemeScreen.routeName:(context)=>ThemeScreen(),
       },
      initialRoute: '/',

      );
    }
}


