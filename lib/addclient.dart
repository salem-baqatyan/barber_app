import 'package:barber/queue_page.dart';
import 'package:barber/sqldb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';


class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {

  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: LocaleText('bar_add',style: TextStyle(
        color: Theme.of(context).colorScheme.primaryVariant,),),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.primaryVariant,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(formstate.currentState!.validate()){
            int response = await sqlDb.insertData(
                '''
                          INSERT INTO queue (name , phone)
                          VALUES ("${name.text}" , "${phone.text}")
                          '''
            );
            name.clear();
            phone.clear();
            if(response > 0){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const QueuePage()),
                      (route) => false);
            }
          }
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.save),
      ),
      body: ListView(
        children: [
          Form(
            key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    validator: (value){
                      if(value!.isEmpty){
                        //return 'is Empty';
                        return Locales.string(context, 'validate_empty');
                      }
                      if(value.length<3){
                       // return 'is not name';
                        return Locales.string(context, 'validate_noname');
                      }
                    },
                    decoration: InputDecoration(
                      hintText: Locales.string(context, 'hint_name'),
                      icon: const Icon(Icons.person,),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      )
                    ),
                  ),
                  TextFormField(
                    maxLength: 9,
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    validator: (value){
                      if(value!.isNotEmpty && value.length<8){
                        //return 'is not number for phone';
                        return Locales.string(context, 'validate_nophone');
                      }
                    },
                    decoration: InputDecoration(
                        hintText: Locales.string(context, 'hint_phone'),
                        focusColor: Colors.white,
                        icon: const Icon(Icons.phone,),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        )
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
