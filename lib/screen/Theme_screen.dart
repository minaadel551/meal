import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal/providers/language_provider.dart';
import 'package:meal/providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';

var lan;
class ThemeScreen extends StatelessWidget {
  static const routeName='theme_screen';
  final bool fromOnBoarding;
  ThemeScreen({this.fromOnBoarding= false});

  Widget buildRadioListTile({ThemeMode themeVal, String title, IconData icon, BuildContext ctx}){
    return RadioListTile(
      secondary: Icon(icon,color: Theme.of(ctx).buttonColor,),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx).tm,
      onChanged: (newThemeVal)=>
      Provider.of<ThemeProvider>(ctx,listen: false).themeModChange(newThemeVal),
      title: Text(title),

    );

  }

  ListTile buildListTile({BuildContext ctx,String title}){
    var  primaryColor= Provider.of<ThemeProvider>(ctx).primaryColor;
    var accentColor =  Provider.of<ThemeProvider>(ctx).accentColor;
    return ListTile(
      title: Text(title ,style: Theme.of(ctx).textTheme.headline6,),
      trailing: CircleAvatar(
        backgroundColor: title ==lan.getTexts('primary')? primaryColor:accentColor ,),
        onTap: (){
        showDialog(context: ctx,builder: (BuildContext context ){
          return AlertDialog(
            elevation: 4,
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: title == lan.getTexts('primary')?
                Provider.of<ThemeProvider>(ctx).primaryColor :
                Provider.of<ThemeProvider>(ctx).accentColor ,
                onColorChanged: (newColor){
                  Provider.of<ThemeProvider>(ctx,listen: false).onChanged(newColor,
                      title == lan.getTexts('primary')?1:2);
                },
                colorPickerWidth: 300,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
                showLabel: false,
              ),
            ),
          );
        });
      },

    );
  }

  @override
  Widget build(BuildContext context) {
     lan =Provider.of<LanguageProvider>(context,listen: true);
    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: fromOnBoarding? null : Text(lan.getTexts('theme_appBar_title')),
              backgroundColor:fromOnBoarding? Theme.of(context).canvasColor
                  : Theme.of(context).primaryColor,
                   elevation:fromOnBoarding? 0:5 ,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(lan.getTexts('theme_screen_title'),style: Theme.of(context).textTheme.headline6,),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(lan.getTexts('theme_mode_title'),style: Theme.of(context).textTheme.headline6,),
                    ),
                    buildRadioListTile(ctx: context,title:lan.getTexts('System_default_theme'),
                        icon:null,themeVal: ThemeMode.system ),
                    buildRadioListTile(ctx: context,title:lan.getTexts('light_theme'),
                        icon:Icons.wb_sunny_outlined,themeVal: ThemeMode.light ),
                    buildRadioListTile(ctx: context,title:lan.getTexts('dark_theme'),
                        icon:Icons.nights_stay,themeVal: ThemeMode.dark ),

                    buildListTile(title:lan.getTexts('primary'),ctx: context),
                    buildListTile(title:lan.getTexts('accent'),ctx: context),
                    SizedBox(height:fromOnBoarding?80:0,),
                  ],
                ),
              ]),
            ),
          ],

        ),


        drawer:fromOnBoarding
            ?null :MainDrawer()
      ),
    );
  }
}
