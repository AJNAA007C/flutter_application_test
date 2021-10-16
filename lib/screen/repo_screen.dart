import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/model/repositries.dart';
import 'package:flutter_application_test/model/user.dart';
import 'package:flutter_application_test/providers/repo_provider.dart';
import 'package:flutter_application_test/screen/info_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RepositiriesScreen extends StatefulWidget {
  String username;
  RepositiriesScreen(
    this.username,
  );
  @override
  _RepositiriesScreenState createState() => _RepositiriesScreenState();
}

class _RepositiriesScreenState extends State<RepositiriesScreen> {
  var _init = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<RepositriesProvider>(context)
          .getRepositriesList(widget.username)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    final repoData = Provider.of<RepositriesProvider>(context);
    final dateF = new DateFormat.yMMMMd("en_US");
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: repoData.repoList.length,
            itemBuilder: (ctx, index) => InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => InfoScreen(
                        repoData.repoList[index].repo_name,
                        repoData.repoList[index].url)));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffd9d9d9), width: 2),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                        height: 40,
                        width: double.infinity,
                        color: Color(0xffd9d9d9),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                repoData.repoList[index].repo_name,
                              ),
                            ))),

                    // Text(repoData.repoList[index].repo_name)),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Created :',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff595959)),
                          ),
                          Text(dateF.format(DateTime.parse(
                            repoData.repoList[index].created_date,
                          )))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ),
          );
  }
}
