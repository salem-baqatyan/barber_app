import 'dart:ui';
import 'package:barber/components/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:barber/const/my_flutter_app_icons.dart';
import 'package:barber/theme/theme_provider.dart';
import 'package:provider/provider.dart';



class AboutDev extends StatelessWidget {
  const AboutDev({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    bool colorDark = Provider.of<ThemeProvider>(context,listen: false).isDarkMode;


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primaryVariant,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: LocaleText(
                'bar_about',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primaryVariant),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primaryVariant,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: Theme.of(context).colorScheme.primaryVariant),
                                ),

                                child: Card(

                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40),),
                                  ),
                                  color: Theme.of(context).colorScheme.primary,
                                  elevation: 10,

                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                       ListTile(
                                        title: const Center(child: LocaleText("card_name",style:
                                        TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                                        subtitle: Center(child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text('"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                            LocaleText("card_subtitle",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                            Text('"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                          ],
                                        )),
                                      ),
                                      socialButtons(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Theme.of(context).colorScheme.primaryVariant,width: 5),
                          ),

                          child: colorDark == false
                            ? const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/programmer_light.jpg')
                                //AssetImage('assets/programmer_light.jpg'),
                          )
                            : const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage('assets/programmer_dark.jpg')
                            //AssetImage('assets/programmer_light.jpg'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget socialButtons() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: (){
              final whatsappUrl = Uri.parse('https://wa.me/+967775445127');
              launchUrl(whatsappUrl,mode: LaunchMode.externalApplication);
              },
            icon: const Icon(SocialIcon.whatsapp)
        ),
        IconButton(
            onPressed: (){
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'salem.baqatyan775@gmail.com',
                query: encodeQueryParameters(<String, String>{
                  'subject': '',
                  'body': '',
                }),
              );
              launchUrl(emailLaunchUri);
            },
            icon: const Icon(SocialIcon.gmail)
        ),


        IconButton(
            onPressed: (){
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: '+967775445127',
              );
              launchUrl(launchUri);
            },
            icon: const Icon(Icons.phone)
        ),

      ],
    );
  }
}
