import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/providers/repo_provider.dart';
import 'package:flutter_application_test/providers/user_provider.dart';
import 'package:flutter_application_test/screen/info_screen.dart';
import 'package:flutter_application_test/screen/repo_screen.dart';
import 'package:flutter_application_test/screen/user_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  String username;
  ResultScreen({this.username});
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
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
      print(widget.username);
      print("UUUUUUUUUUUUUUUUUUUUUUUU");
      Provider.of<UserProvider>(context)
          .getUserProfile(widget.username)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  // @override
  // void didChangDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if (_init) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     Provider.of<RepositriesProvider>(context)
  //         .getRepositriesList(widget.username)
  //         .then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _init = false;
  // }

  TabController _tabController;

  @override
  void initState() {
    // initialise your tab controller here
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.green,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              tabs: <Widget>[
                Text('PROFILE'),
                Text('REPOSITORY'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                buildProfile(),
                RepositiriesScreen(widget.username)
                // _buildRepo(), // UserDetailsScreen(),
                // Center(
                //   child: Text(
                //     'KALTEGETRANKE',
                //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfile() {
    final user = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    var textStyle = TextStyle(fontFamily: 'Lato', fontSize: 18);
    // final f = new DateFormat.yMMMMd("en_US");
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : user.user.username == null &&
                user.user.followers == null &&
                user.user.imageUrl == null &&
                user.user.followings == null &&
                user.user.public_repo == null
            ? Center(
                child: Text('Nothing Found'),
              )
            : Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: size.height * 0.4,
                            color: Colors.white,
                          ),
                          Container(
                            height: size.height * 0.23,
                            color: Color(0xff330033),
                          ),
                          Positioned(
                            top: size.height * 0.15,
                            left: size.width * 0.35,
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0)),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(0xff330033)),
                                      ),
                                      width: 121.0,
                                      height: 121.0,
                                      padding: EdgeInsets.all(70.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    imageUrl: user.user.imageUrl.toString(),
                                    width: 121.0,
                                    height: 121.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    user.user.username,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Lato'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // for(int i=0;i<githubinfo.length;i++)
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:
                                  Text('Public Repositries', style: textStyle),
                            ),
                          ],
                        ),
                        Text(user.user.public_repo.toString(),
                            style: textStyle),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              );
    // ));
  }

  Widget _buildRepo() {
    final repoData = Provider.of<RepositriesProvider>(context);
    final dateF = new DateFormat.yMMMMd("en_US");
    _isLoading
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
                    Container(
                        height: 40,
                        width: double.infinity,
                        color: Color(0xffd9d9d9),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(repoData.repoList[index].repo_name)),
                        )),
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
                              repoData.repoList[index].created_date)))
                        ],
                      ),
                    ),
                    repoData.repoList[index].description == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Description :',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff595959)),
                                ),
                                Container(
                                    width: 150,
                                    child: Text(
                                        repoData.repoList[index].description))
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Last Pushed : ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff595959)),
                          ),
                          Text(dateF.format(DateTime.parse(
                              repoData.repoList[index].last_pushed)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Branch : ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff595959)),
                          ),
                          Text(repoData.repoList[index].branch)
                        ],
                      ),
                    ),
                    Container(
                        height: 40,
                        width: double.infinity,
                        color: Color(0xffd9d9d9),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  'Stars: ${repoData.repoList[index].stars.toString()}'),
                              Text(repoData.repoList[index].language),
                            ],
                          ),
                        )),
                    //  Text('${url}')
                  ],
                ),
              ),
            ),
          );
  }
}
