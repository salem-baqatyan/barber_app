import 'package:barber/about_dev.dart';
import 'package:barber/components/drawer_tile.dart';
import 'package:barber/queue_page.dart';
import 'package:barber/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);


  @override

  Widget build(BuildContext context) {

    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children:  [
            DrawerHeader(
              padding: EdgeInsets.all(7.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,)

                      ),
                      child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/barber-logo.png')
                        //AssetImage('assets/programmer_light.jpg'),
                      )
                    ),
                    Container(
                      height: 25,
                      width: 150,
                      alignment: Alignment.center,
                      child: LocaleText('title_drawer',style: TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryVariant
                      ),),
                    ),
                    const SizedBox(height: 10,)
                  ],
                )),
            DrawerTile(
              title: Locales.string(context, 'queue_drawer'),
              leading: const Icon(Icons.wc),
              ontap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const QueuePage())
                );
              }),
            DrawerTile(
              title: Locales.string(context, 'settings_drawer'),
              leading: const Icon(Icons.settings),
              ontap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SettingsPage())
                );
              },),
            DrawerTile(
              title: Locales.string(context, 'about_drawer'),
              leading: const Icon(Icons.account_balance),
              ontap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutDev())
                );
              },),

          ],
        ),
      ),
    );
  }
}
