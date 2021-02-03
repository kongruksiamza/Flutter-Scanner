import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Scan BarCode & QRCode'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String scanresult;
  bool checkLineURL=false;
  bool checkFacebookURL = false;
  bool checkYoutubeURL = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ผลการสแกน",style: TextStyle(fontSize: 30),),
                      SizedBox(height: 20,),
                      Text(scanresult ??="ยังไม่มีข้อมูล",style: TextStyle(fontSize: 25)),
                      Spacer(),
                      checkLineURL 
                      ? SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async{
                              if(await canLaunch(scanresult)){
                                  await launch(scanresult);
                              }
                          },
                          color: Colors.green[900],
                          child: Text("ติดตามผ่าน Line",style: TextStyle(color: Colors.white),),
                          ),
                      )
                      : Container(),
                      Spacer(),
                      checkFacebookURL 
                      ? SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async{
                              if(await canLaunch(scanresult)){
                                  await launch(scanresult);
                              }
                          },
                          color: Colors.blue[900],
                          child: Text("ติดตามผ่าน Facebook",style: TextStyle(color: Colors.white),),
                          ),
                      )
                      : Container(),
                      Spacer(),
                      checkYoutubeURL
                      ? SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async{
                              if(await canLaunch(scanresult)){
                                  await launch(scanresult);
                              }
                          },
                          color: Colors.red[900],
                          child: Text("ติดตามผ่าน Youtube",style: TextStyle(color: Colors.white),),
                          ),
                      )
                      : Container()
                    ],
                  ),
                ),
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startScan,
        child: Icon(Icons.qr_code_scanner_sharp),
      ),
    );
  }

  startScan() async {
    //อ่านข้อมูลจาก barcode และ qrcode
    String cameraScanResult = await scanner.scan();
    setState(() {
      scanresult = cameraScanResult;
    });

    if(scanresult.contains("line.me")){
        checkLineURL=true;
    }else if(scanresult.contains("facebook.com")){
        checkFacebookURL=true;
    }else if(scanresult.contains("youtube.com")){
        checkYoutubeURL=true;
    }
  }
}
