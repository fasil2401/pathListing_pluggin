import 'package:flutter/material.dart';
import 'package:video_sample/search_files.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textEditingController = TextEditingController();

  List<String> _pathList = [];
  @override
  void initState() {
    getFiles();
    // TODO: implement initState
    super.initState();
  }

  Future getFiles () async{
    final value = '.mp4,.mkv,.webm'
        // final value = '.mp4'
        .trim()
        .replaceAll(' ', '')
        .split(',');
    if (value.isEmpty) {
      return;
    }
    SearchFilesInStorage.searchInStorage(
      value,
      (List<String> data) {
        _pathList.clear();
        print(data);
        setState(() {
          _pathList.addAll(data);
        });
      },
      (error) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for files'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TextFormField(
            //   controller: _textEditingController,
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: '.mp4,.mkv,.wav,.pdf',
            //   ),
            // ),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     _textEditingController.text = '.mp4';
            //     final value = _textEditingController.text
            //         // final value = '.mp4'
            //         .trim()
            //         .replaceAll(' ', '')
            //         .split(',');
            //     if (value.isEmpty) {
            //       return;
            //     }
            //     SearchFilesInStorage.searchInStorage(
            //       value,
            //       (List<String> data) {
            //         _pathList.clear();
            //         setState(() {
            //           _pathList.addAll(data);
            //         });
            //       },
            //       (error) {},
            //     );
            //   },
            //   icon: const Icon(Icons.search),
            //   label: const Text('Search'),
            // ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (ctx, index) {
                  final path = _pathList[index].split('/');
                  print('path is : ${path[path.length-2]}');
                  return ListTile(
                    title: Text(_pathList[index].split('/').last),     //
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: _pathList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
