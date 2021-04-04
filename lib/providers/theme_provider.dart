import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier{

var  primaryColor= Colors.pink;  // علشان اغير اللون الاساسي
var accentColor =  Colors.amber; // علشان اغير اللون الثانوي
var tm =ThemeMode.system;        // علشان احدد انه ثيم فاتح او غامق او حسب النظام
String themeText = 'system';     // علشان احفظ القيمة بتاعت الثيم في الموبايل

// ميثود علشان بتاخد اللون من color_Picker
  // هتستقبل اللون اللي اختاره المستخدم و رقم يدل انه اللون الاساسي او الثانوي وععلي اساسه هتغيره
// وهتحفظ الالوان دي في الهاتف
  void onChanged (color ,n)async{
    /**  لو كان واحد يدل علي اللون الاساسي وهيغيره
     * هيبعته لميثود تغير اللكود بتاع اللون علشان مينفعش في الللون الاساسي والثانوي يكون الكود فيه شفافية */
  n == 1 ? primaryColor=setMaterialColor(color.hashCode) :
  accentColor= setMaterialColor(color.hashCode);
  notifyListeners();

/** هحفظ الالوان في الهاتف علي هيئة int فلازم بعد اللون .value */
  SharedPreferences prefs =await SharedPreferences.getInstance();
  prefs.setInt('primaryColor', primaryColor.value);
  prefs.setInt('accentColor', accentColor.value);
}

// ميثود بتغير الكود اللي بيجي من ال color_picker علشان اقدر استخدمه مع اللون الاساسي والثانوي
 MaterialColor setMaterialColor(colorVal){
   /** الكود دا انا جبته منيين ؟؟؟
    * هدوس علي اي اللون "Colors.pink " هيجبلي اسمه وبيساوي الماتيريال كولار
    * هزود بس return  وهحط اللون اللي هيتحول في الاول وجنب ال 500 */
   return MaterialColor(
    colorVal,
    <int, Color>{
      50: Color(0xFFFCE4EC),
      100: Color(0xFFF8BBD0),
      200: Color(0xFFF48FB1),
      300: Color(0xFFF06292),
      400: Color(0xFFEC407A),
      500: Color(colorVal),
      600: Color(0xFFD81B60),
      700: Color(0xFFC2185B),
      800: Color(0xFFAD1457),
      900: Color(0xFF880E4F),},
  );
}

// ميثود بتغير الثيم (فاتح - غامق)
  //وبتستقبل قيمة من نوع themeMode
// وبتحفظ الثيم في الهاتف
 void themeModChange(newThemeVal)async{
  tm = newThemeVal;
  /** بعد ما اخد القيمة و غيرت بيها الثيم هدي القيمة بتاعد الثيم الحالي للميثود علشان تحفظها في الهاتف*/
  getThemeText(tm);
  notifyListeners();
  /** بحفظها علي شكل نص*/
  SharedPreferences prefs =await SharedPreferences.getInstance();
  prefs.setString('themeText', themeText);
}

// ميثود بتاخد قيمة الثيم لما بختاره وبتحولها لنص علشان اقدر احفظه في الهاتف
 void getThemeText(ThemeMode tm){
    if(tm == ThemeMode.dark)
      themeText='dark';
    else if(tm == ThemeMode.light)
      themeText='light';
    else if(tm == ThemeMode.system)
      themeText='system';
}

// ميثود بتجلبلي الثيم المحفوظ و اللون الاساسي و الثانوي المخزنيين
void getThemeMode()async{
  SharedPreferences prefs =await SharedPreferences.getInstance();

  /** هجلب قيمة الثيم ولو null يعني اول مره هديلو قيمو من عندي اللي هي حسب النظام*/
   themeText = prefs.getString('themeText')?? 'system';
   if(themeText =='system') tm=ThemeMode.system;
   else if(themeText =='dark') tm=ThemeMode.dark;
   else if(themeText =='light') tm=ThemeMode.light;
  /** هجلب قيمة اللون الاساسي والثانوي ولو  null هديله قيم الالوان الافتراضيه من فوق ازااااي؟؟؟
   * هدوس علي اللون وانا دايس Ctrl
   * "Colors.pink " وهلاقي قيمة اللون
   * وعملت كدا علشان انا حافظ القيمة علي هيئه int فلازم احولها للون وطبعا بداله التحويل */

  primaryColor = setMaterialColor(prefs.getInt('primaryColor') ??0xFFE91E63);
      accentColor= setMaterialColor( prefs.getInt('accentColor') ?? 0xFFFFC107 )  ;
   notifyListeners();
}



}
