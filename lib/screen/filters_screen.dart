import 'package:flutter/material.dart';
import 'package:meal/providers/language_provider.dart';
import 'package:meal/providers/theme_provider.dart';
import 'package:meal/screen/tabs_screen.dart';
import '../providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName='filters_screen';
  final bool fromOnBoarding;
  FiltersScreen({this.fromOnBoarding= false});


  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  Widget buildSwitchTile({String title ,String subtitle ,bool val,Function change}){
    return  SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      inactiveTrackColor: Provider.of<ThemeProvider>(context).tm == ThemeMode.light?
        null : Colors.black,
      value: val,
      onChanged: change);
  }
  @override
  Widget build(BuildContext context) {
    final Map<String,bool> currentFilters=Provider.of<MealProvider>(context,listen: true).filters;
    var lan =Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body:CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: widget.fromOnBoarding? null : Text(lan.getTexts('filters_appBar_title')),
              backgroundColor:widget.fromOnBoarding? Theme.of(context).canvasColor
              : Theme.of(context).primaryColor,
              elevation:widget.fromOnBoarding? 0:5 ,
              actions: [
                if(!widget.fromOnBoarding)
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed:(){
                      Provider.of<MealProvider>(context,listen: false).setFilters();
                      Navigator.pushReplacementNamed(context, TabsScreen.routeName);
                    } ,
                  )
              ],

            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: Text(lan.getTexts('filters_screen_title'),style:  Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,),
                  padding: EdgeInsets.all(20),),

                buildSwitchTile(title: lan.getTexts('Gluten-free'),subtitle: lan.getTexts('Gluten-free-sub'),
                  val:currentFilters['isGlutenFree'], change: (val){
                    setState(() {
                      currentFilters['isGlutenFree']= val;
                    });},
                ),
                buildSwitchTile(title: lan.getTexts('Vegan'),subtitle: lan.getTexts('Vegan-sub'),
                  val:currentFilters['isVegan'], change: (val){
                    setState(() {
                      currentFilters['isVegan'] = val;
                    });},
                ),
                buildSwitchTile(title: lan.getTexts('Vegetarian'),subtitle:lan.getTexts('Vegetarian-sub'),
                  val:currentFilters['isVegetarian'], change: (val){
                    setState(() {
                      currentFilters['isVegetarian'] = val;
                    });},
                ),
                buildSwitchTile(title: lan.getTexts('Lactose-free'),subtitle:lan.getTexts('Lactose-free_sub'),
                  val: currentFilters['isLactoseFree'], change: (val){
                    setState(() {
                      currentFilters['isLactoseFree'] = val;
                    });},
                ),
                SizedBox(height: widget.fromOnBoarding?80:0,)
              ]),
            ),
          ],

        ),


        drawer: widget.fromOnBoarding
            ?null :MainDrawer()
      ),
    );
  }
}
