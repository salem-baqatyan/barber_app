import 'package:barber/components/drawer.dart';
import 'package:barber/editclient.dart';
import 'package:barber/sqldb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_locales/flutter_locales.dart';

//import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List queue = [];

  String _phone = '';

  @override
  void initState() {
    super.initState();
    readData();
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {});
    });
  }

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM queue");
    queue.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  deleteAll() async {
    await sqlDb.deleteData("DELETE FROM queue ");
    queue.clear();
    setState(() {});
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.primaryVariant,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /*
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FloatingActionButton(
                onPressed: () {
                  deleteAll();
                },
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
            ),
            */
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("addclient");
                },
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: isLoading == true
            ? const Center(
                child: LocaleText('loading_list'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: LocaleText(
                      'bar_list',
                      style: TextStyle(
                          fontSize: 48,
                          color: Theme.of(context).colorScheme.primaryVariant),
                    ),
                  ),
                  Expanded(
                    child: queue.isEmpty
                        ? const Center(
                            child: LocaleText("empty_list"),
                          )
                        : ListView(
                            children: [
                              ListView.builder(
                                itemCount: queue.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Card(
                                      child: ListTile(
                                        leading: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${i + 1}-',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                            ),
                                            queue[i]['phone'] != ""
                                                ? IconButton(
                                                    onPressed: () {
                                                      _phone =
                                                          queue[i]['phone'];
                                                      if (_phone.startsWith(
                                                              '7', i = 0) ||
                                                          _phone.startsWith(
                                                              '05', i = 0)) {
                                                            _makePhoneCall(
                                                                _phone);
                                                      } else {
                                                        showDialog<void>(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          // false = user must tap button, true = tap outside dialog
                                                          builder: (BuildContext
                                                              dialogContext) {
                                                            return AlertDialog(
                                                              title: Row(
                                                                children: const [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            5.0),
                                                                    child: Icon(
                                                                        Icons
                                                                            .warning_amber_outlined),
                                                                  ),
                                                                  LocaleText(
                                                                    'title_dialog',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              content:
                                                                  const LocaleText(
                                                                      'content_dialog'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child:
                                                                       LocaleText(
                                                                    'cancel_dialog',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context).colorScheme.primaryVariant),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            dialogContext)
                                                                        .pop(); // Dismiss alert dialog
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    icon:
                                                        const Icon(Icons.phone),
                                                    color: Colors.green)
                                                : const Padding(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: Icon(Icons.phone,
                                                        color: Colors.grey),
                                                  ),
                                          ],
                                        ),
                                        title: Text("${queue[i]['name']}"),
                                        subtitle: Text("${queue[i]['phone']}"),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditClient(
                                                                id: queue[i]
                                                                    ['id'],
                                                                name: queue[i]
                                                                    ['name'],
                                                                phone: queue[i]
                                                                    ['phone'],
                                                              )));
                                                },
                                                icon: const Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog<void>(
                                                    context: context,
                                                    barrierDismissible:
                                                    false,
                                                    // false = user must tap button, true = tap outside dialog
                                                    builder: (BuildContext
                                                    dialogContext) {
                                                      return AlertDialog(
                                                        title: Row(
                                                          children: const [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right:
                                                                  5.0),
                                                              child: Icon(
                                                                  Icons
                                                                      .warning_amber_outlined),
                                                            ),
                                                            LocaleText(
                                                              'title_dialog_d',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                        content:
                                                        const LocaleText(
                                                            'content_dialog_d'),
                                                        actions: <Widget>[

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              TextButton(
                                                                child:
                                                                LocaleText(
                                                                  'sure_dialog_d',
                                                                  style: TextStyle(
                                                                      color: Theme.of(context).colorScheme.primaryVariant),
                                                                ),
                                                                onPressed:
                                                                    () async{
                                                                  int response =
                                                                  await sqlDb.deleteData(
                                                                      "DELETE FROM queue WHERE id = ${queue[i]['id']}");
                                                                  if (response > 0) {
                                                                    queue.removeWhere(
                                                                            (element) =>
                                                                        element['id'] ==
                                                                            queue[i]['id']);
                                                                    setState(() {});
                                                                  }
                                                                  Navigator.of(
                                                                      dialogContext)
                                                                      .pop(); // Dismiss alert dialog

                                                                    },
                                                              ),

                                                              TextButton(
                                                                child:
                                                                 LocaleText(
                                                                  'cancel_dialog_d',
                                                                  style: TextStyle(
                                                                      color: Theme.of(context).colorScheme.primaryVariant),
                                                                ),
                                                                onPressed:
                                                                    () {
                                                                  Navigator.of(
                                                                      dialogContext)
                                                                      .pop(); // Dismiss alert dialog
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );


                                                },
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                ],
              ));
  }
}
