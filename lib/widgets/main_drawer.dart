import 'package:flutter/material.dart';
import 'package:meal/providers/language_provider.dart';
import 'package:meal/screen/tabs_screen.dart';
import 'package:provider/provider.dart';
import '../screen/Theme_screen.dart';
import '../screen/filters_screen.dart';
class MainDrawer extends StatelessWidget {

  Widget buildListTile ({Function tap,IconData icon,String text,BuildContext ctx}){
    return  ListTile(
      leading: Icon(icon,color: Theme.of(ctx).buttonColor,),
      title: Text(text,style:TextStyle(
        color: Theme.of(ctx).textTheme.bodyText2.color,
          fontFamily: 'RobotoCondensed',fontWeight: FontWeight.bold,
          fontSize: 24),),
      onTap: tap,
    );
  }
  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child:
        CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    Container(
                      alignment:lan.isEn? Alignment.centerLeft:Alignment.centerRight,
                      height: 150,
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      child: Text(lan.getTexts('drawer_name'),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 26,fontWeight: FontWeight.w900),),
                    ),
                    SizedBox(height: 20,),

                    buildListTile(icon:Icons.restaurant,text:lan.getTexts('drawer_item1'),tap:()=>
                        Navigator.pushReplacementNamed(context, TabsScreen.routeName),ctx: context),

                    buildListTile(icon:Icons.settings,text:lan.getTexts('drawer_item2'),tap:()=>
                        Navigator.pushReplacementNamed(context, FiltersScreen.routeName),ctx: context),

                    buildListTile(icon:Icons.color_lens,text:lan.getTexts('drawer_item3'),tap:()=>
                        Navigator.pushReplacementNamed(context, ThemeScreen.routeName),ctx: context),

                    Divider(
                      height: 10,
                      color: Colors.black54,
                    ),
                    Container(
                      alignment: lan.isEn? Alignment.centerLeft:Alignment.centerRight,
                      padding: EdgeInsets.only(top: 20,right: 22),
                      child: Text(lan.getTexts('drawer_switch_title'),style: Theme.of(context).textTheme.headline6,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(lan.getTexts('drawer_switch_item2'),style: Theme.of(context).textTheme.headline6,),
                        Switch(
                          value: Provider.of<LanguageProvider>(context).isEn,
                          onChanged: (newVal){
                            Provider.of<LanguageProvider>(context,listen: false).changeLan(newVal);
                            Navigator.of(context).pop();
                          },
                          //  inactiveTrackColor: Provider.of<ThemeProvider>(context).tm ,
                        ),
                        Text(lan.getTexts('drawer_switch_item1'),style: Theme.of(context).textTheme.headline6,),
                      ],
                    ),
                    Divider(
                      height: 10,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
