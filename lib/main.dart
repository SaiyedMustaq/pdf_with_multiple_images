import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Image to pdf'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pdfFile = '';
  var pdf = pw.Document();
  static const List<String> assetImages = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png'
  ];
  List<Uint8List> imagesUint8list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Visibility(
                  visible: pdfFile.isNotEmpty,
                  child: SfPdfViewer.file(File(pdfFile),
                      canShowScrollHead: false, canShowScrollStatus: false),
                ),
              ),
            ),
            RaisedButton(
                color: Colors.tealAccent,
                onPressed: () async {
                  await createPdfFile();
                  savePdfFile();
                },
                child: Text('Create a Pdf File')),
          ],
        ),
      ),
    );
  }

  getImageBytes(String assetImage) async {
    final ByteData bytes = await rootBundle.load(assetImage);
    final Uint8List byteList = bytes.buffer.asUint8List();
    imagesUint8list.add(byteList);
    print(imagesUint8list.length);
  }

  createPdfFile() async {
    for (String image in assetImages) await getImageBytes(image);
    final List<pw.Widget> pdfImages = imagesUint8list.map((image) {
      return pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.max,
              children: [
                pw.Text(
                    'Image'
                            ' ' +
                        (imagesUint8list
                                    .indexWhere((element) => element == image) +
                                1)
                            .toString(),
                    style: pw.TextStyle(fontSize: 22)),
                pw.SizedBox(height: 30),
                pw.Image(
                    pw.MemoryImage(
                      image,
                    ),
                    height: 300,
                    fit: pw.BoxFit.fitHeight)
              ]));
    }).toList();

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Text('Flutter Pdf File with Multiple Image',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontSize: 26)),
                  pw.Divider(),
                ]),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisSize: pw.MainAxisSize.max,
                children: pdfImages),
          ];
        }));
  }

  savePdfFile() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    String id = DateTime.now().toString();

    File file = File("$documentPath/$id.pdf");

    file.writeAsBytesSync(await pdf.save());
    setState(() {
      pdfFile = file.path;
      pdf = pw.Document();
    });
  }
  //sndjasnd
}
