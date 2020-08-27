import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliver_demo/persistent_Header.dart';

class SliverScroll extends StatelessWidget {
  SliverScroll({Key key, @required this.title}) : super(key: key);
  final String title;

  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
    Colors.deepPurpleAccent,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
    Colors.deepPurpleAccent,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
    Colors.deepPurpleAccent,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
    Colors.deepPurpleAccent,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
    Colors.deepPurpleAccent,
  ];

  Widget renderTitle(String title) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.blueAccent,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          '$title',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(this.title)),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: false, //控制是否一次性折叠，或是根据滑动距离折叠对应的px
            pinned: true,
            expandedHeight: 170,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(this.title),
              background: Image.network(
                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              CupertinoButton(
                  child: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PersistentHeader(title: 'sticky header')));
                  })
            ],
          ),
          // this.renderTitle('sliver grid'),
          SliverPersistentHeader(
            // floating: true,            
            pinned: true,
            delegate: StickySectionHeaderDelegate(
              child: Container(
                height: 44,
                color: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'sliver grid',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: colors
                .map((myColor) => Container(
                      color: myColor,
                    ))
                .toList(),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickySectionHeaderDelegate(
              child: Container(
                height: 44,
                color: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'sliver list',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => Container(
                  padding: EdgeInsets.all(10.0),
                  color: this.colors[index],
                ),
                childCount: this.colors.length,
              ),
              itemExtent: 70),
        ],
      ),
    );
  }
}

class StickySectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickySectionHeaderDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
