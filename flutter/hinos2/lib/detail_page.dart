import 'dart:io';
import 'dart:typed_data';

import 'package:beautiful_list/model/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.lesson}) : super(key: key);
  final Lesson lesson;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<String> prepareTestPdf() async {
    final ByteData bytes =
        await DefaultAssetBundle.of(context).load('PDFs/01.pdf');
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/PDFs/01.pdf';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        SizedBox(height: 10.0),
        Text(
          widget.lesson.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("bg.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      widget.lesson.content,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          // onPressed: () => {},
          onPressed: () {
            print('asdf');
            prepareTestPdf().then((path) {
              print(path);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullPdfViewerScreen(path)),
              );
            });
          },
          // onPressed: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
          // ),
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("Música", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}

class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
        ),
        path: pdfPath);
  }
}
