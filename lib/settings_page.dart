import 'package:barber/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primaryVariant,
        backgroundColor: Colors.transparent,),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12)
            ),
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
            margin: const EdgeInsets.only(left: 25,right: 25,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LocaleText('dark_mode',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.5,
                ),),
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
                  onChanged: (value)=>
                      Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
                ),
              ],),
          ),
          
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12)
            ),
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
            margin: const EdgeInsets.only(left: 25,right: 25,top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LocaleText('language',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.5,
                ),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: MaterialButton(onPressed: (){
                        context.changeLocale('en');
                          Navigator.pop(context);

                        setState(() {});

                      },
                      child: const LocaleText('english'),
                      ),
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: MaterialButton(onPressed: (){
                        context.changeLocale('ar');
                          Navigator.pop(context);

                        setState(() {});
                      },
                        child: const LocaleText('arabic'),
                      ),
                    ),


                  ],),
                /*
                RadioListTile(
                    activeColor: Theme.of(context).colorScheme.primaryVariant,
                    title: const LocaleText('english'),
                    value: "en",
                    groupValue: sex,
                    onChanged: (val){
                      setState(() {
                        sex = val as String?;
                        context.changeLocale(val!);
                      });
                    }),
                RadioListTile(
                    activeColor: Theme.of(context).colorScheme.primaryVariant,
                    title: const LocaleText('arabic'),
                    value: "ar",
                    groupValue: lang,
                    onChanged: (val){
                      setState(() {
                        lang = val as String?;
                        context.changeLocale(val!);
                      });
                    }),*/

              ],),
          ),

        ],),
    );
  }
}



