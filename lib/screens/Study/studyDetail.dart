import 'package:book_club/provider/StudyProvider.dart';
import 'package:book_club/shared/button.dart';
import 'package:book_club/shared/constants.dart';
import 'package:book_club/shared/customtext.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:provider/provider.dart';

class StudyDetail extends StatefulWidget {
  final String courseCode;
  final String when;
  final String location;
  const StudyDetail(
      {Key key,
      @required this.courseCode,
      @required this.when,
      @required this.location,})
      : super(key: key);

  @override
  _StudyDetailState createState() => _StudyDetailState();
}

class _StudyDetailState extends State<StudyDetail> {

  Future<Uri> createDynamicLink(String id) async {

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://funet.page.link',
      link: Uri.parse('https://funet.page.link/?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.book_club',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.example.book_club',
        minimumVersion: '1.0.1',
      ),
    );

    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    return shortUrl;
  }



  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudyProvider>(context, listen: false).getStudyGroup(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  color: buttonColor,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                //createDynamicLink(id);
                              },
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(height: 24),
                      CustomText(
                          text: widget.courseCode,
                          size: 24,
                          color: HexColor('FFFFFF')),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(children: [
                    Text('adkljf')
                  ],),
                )
              ]),
        ),
      ),
    );
  }
}
