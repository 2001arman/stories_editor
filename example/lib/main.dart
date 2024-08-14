import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stories_editor/stories_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter stories editor Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<void> checkPermission() async {
    var status = await Permission.manageExternalStorage.status;
    var statusMedia = await Permission.accessMediaLocation.status;
    var statusPhoto = await Permission.accessMediaLocation.status;
    if (status.isDenied) {
      Permission.manageExternalStorage.request();
    }
    if (statusMedia.isDenied) {
      Permission.accessMediaLocation.request();
    }
    if (statusPhoto.isDenied) {
      Permission.photos.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoriesEditor(
                            giphyKey: '5oLNtn7015Z9BaVyorSmuCtVGEzLU03P',
                            //fontFamilyList: const ['Shizuru', 'Aladin'],
                            galleryThumbnailQuality: 300,
                            //isCustomFontList: true,
                            onDone: (uri) {
                              debugPrint(uri);
                              Share.shareFiles([uri]);
                            },
                          )));
            },
            child: const Text('Open Stories Editor'),
          ),
        ));
  }
}
