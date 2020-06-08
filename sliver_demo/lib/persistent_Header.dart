import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliver_demo/custom_header.dart';

class PersistentHeader extends StatefulWidget {
  PersistentHeader({Key key, @required this.title}) : super(key: key);
  final String title;
  @override
  _PersistentHeaderState createState() => _PersistentHeaderState();
}

class _PersistentHeaderState extends State<PersistentHeader>
    with SingleTickerProviderStateMixin {
  Widget _renderTitle(String title) => SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );

  TabController tabController;
  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: 170,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.title),
              background: Image.network(
                  'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                  fit: BoxFit.cover),
            ),
            actions: <Widget>[
              CupertinoButton(
                  child: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CustomSliverHeader()));
                  })
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              tabBar: TabBar(
                controller: this.tabController,
                labelColor: Colors.red,
                tabs: <Widget>[
                  Tab(text: 'home'),
                  Tab(text: 'setting'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('content of home .')),
                Center(child: Text('content of setting .'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  StickyTabBarDelegate({@required this.tabBar});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.tabBar;
  }

  @override
  double get maxExtent => this.tabBar.preferredSize.height;

  @override
  double get minExtent => this.tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
