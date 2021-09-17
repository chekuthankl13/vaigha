import 'package:flutter/material.dart';
import 'package:vaigha/models/functions.dart';
import 'package:vaigha/models/hooks.dart';
import 'package:vaigha/services/function_api.dart';
import 'package:vaigha/services/hook_api.dart';

class Search extends SearchDelegate {
  bool hookvalue;
  bool functionvalue;
  bool initialvalue;

  Search({
    required this.functionvalue,
    required this.hookvalue,
    required this.initialvalue,
  });

  FetchHooks hookdata = FetchHooks();

  FetchFunctions functiondata = FetchFunctions();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        child: hookvalue
            ? FutureBuilder<Hooks>(
                future: hookdata.fetchData(query),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.hooks.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        minLeadingWidth: 1,
                        horizontalTitleGap: 20,
                        enabled: true,
                        title: Text(
                          snapshot.data!.hooks[index].name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle:
                            Text(snapshot.data!.hooks[index].doc.description),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            : functionvalue
                ? FutureBuilder<Functions>(
                    future: functiondata.fetchData(query),
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
                : FutureBuilder<Functions>(
                    future: functiondata.fetchData(query),
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
                  );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        hookvalue
            ? 'Search Hooks'
            : functionvalue
                ? 'search functions'
                : 'search  functions',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
