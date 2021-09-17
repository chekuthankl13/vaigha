import 'package:flutter/material.dart';
import 'package:vaigha/models/functions.dart';
import 'package:vaigha/models/hooks.dart';
import 'package:vaigha/services/function_api.dart';
import 'package:vaigha/services/hook_api.dart';
import 'package:vaigha/widgets/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hookvalue = false;
  bool _functionvalue = false;
  bool _initialvalue = true;

  FetchHooks hookdata = FetchHooks();
  FetchFunctions functiondata = FetchFunctions();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('WordPress'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blue,
                )),
            child: ListTile(
              title: const Text(' Eg : admin'),
              tileColor: Colors.black12,
              trailing: const Icon(
                Icons.search,
                color: Colors.blue,
              ),
              onTap: () {
                find(context);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text('Fillter :',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black45)),
              const SizedBox(
                width: 20,
              ),
              const Text('hooks'),
              Checkbox(
                value: _hookvalue,
                onChanged: (value) => setState(() {
                  _hookvalue = value!;
                  _functionvalue = false;
                  _initialvalue = false;
                }),
              ),
              const SizedBox(
                width: 25,
              ),
              const Text('functions'),
              Checkbox(
                value: _functionvalue,
                onChanged: (value) => setState(() {
                  _functionvalue = value!;
                  _hookvalue = false;
                  _initialvalue = false;
                }),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _initialvalue
                ? FutureBuilder<Functions>(
                    future: functiondata.fetchData(null),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.definitions.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            minLeadingWidth: 1,
                            title: Text(snapshot.data!.definitions[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            subtitle:
                                Text(snapshot.data!.definitions[index].since),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ) 
                          



                : _hookvalue
                    ? FutureBuilder<Hooks>(
                        future: hookdata.fetchData(null),
                        builder: (context, snapshot) {
                          var data = snapshot.data;
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: data!.hooks.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                minLeadingWidth: 1,
                                horizontalTitleGap: 20,
                                enabled: true,
                                title: Text(
                                  data.hooks[index].name!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle:
                                    Text(data.hooks[index].doc.description),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    : FutureBuilder<Functions>(
                        future: functiondata.fetchData(null),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.definitions.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                minLeadingWidth: 1,
                                horizontalTitleGap: 20,
                                // tileColor: Colors.grey,
                                dense: true,
                                title:
                                    Text(snapshot.data!.definitions[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                subtitle: Text(
                                    snapshot.data!.definitions[index].since),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> find(BuildContext context) {
    return showSearch(
        context: context,
        delegate: Search(
            functionvalue: _functionvalue,
            hookvalue: _hookvalue,
            initialvalue: _initialvalue));
  }

  void search(String val) {
    _hookvalue ? hookdata.fetchData(val) : functiondata.fetchData(val);
  }
}
