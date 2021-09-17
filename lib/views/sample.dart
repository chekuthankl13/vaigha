// import 'package:flutter/material.dart';
// import 'package:vaigha/models/hooks.dart';
// import 'package:vaigha/services/hook_api.dart';

// class Sample extends StatefulWidget {
//   const Sample({ Key? key }) : super(key: key);

//   @override
//   _SampleState createState() => _SampleState();
// }

// class _SampleState extends State<Sample> {
//   late Future<Hooks> data;

//   @override
//   void initState() {
//    data = FetchHooks().fetchData();
//   //  print('data--$data');
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     body: FutureBuilder<Hooks>(
//       future: data,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//                   return ListView.builder(
//                     itemCount:snapshot.data!.hooks.length,
//                     itemBuilder: (context, index) => ListTile(
//                       title: Text(snapshot.data!.hooks[index].name),
//                       subtitle: Text(snapshot.data!.hooks[index].doc.description),
//                     ),
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//       },
//       ),
      
//     );
//   }
// }