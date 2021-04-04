import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName='tabs_screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int selectedIndex=0;

  void selectPage(int val){
    setState(() {
      selectedIndex = val;
    });
  }
   List <Map <String,Object>> page;
  @override
  void initState() {
    super.initState();
    Provider.of<MealProvider>(context,listen: false).getData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<LanguageProvider>(context,listen: false).getLan();
    Provider.of<MealProvider>(context,listen: false).setFilters();


  }


  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);
    page =[
      { 'page':CategoriesScreen(),'title':lan.getTexts('categories') },
      { 'page':FavoritesScreen(),'title':lan.getTexts('your_favorites') },];

    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(page[selectedIndex]['title']),),
        body: page[selectedIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: (lan.getTexts('categories')),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: (lan.getTexts('your_favorites'))
            ),
          ],
          elevation: 4,
          currentIndex: selectedIndex,
          backgroundColor:Theme.of(context).primaryColor ,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          onTap:selectPage,

        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
