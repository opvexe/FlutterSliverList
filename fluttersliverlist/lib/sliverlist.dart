import 'package:flutter/material.dart';
import './listBloc.dart';
import './listModel.dart';
import './listViewModel.dart';

class listController extends StatefulWidget {
  @override
  _listControllerState createState() => _listControllerState();
}

class _listControllerState extends State<listController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _sliverWidget(),
    );
  }
}

class _sliverWidget extends StatelessWidget {
  ListBloc listBloc = ListBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<listModel>>(
      stream: listBloc.listItems,
      builder: (context, dataSouce) {
        return dataSouce.hasData
            ? CustomScrollView(
                slivers: <Widget>[
                  _appBar(),
                  _listWidget(
                    listSouce: dataSouce.data,
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class _listWidget extends StatelessWidget {
  final List<listModel> listSouce;
  _listWidget({this.listSouce});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            // color: Colors.red,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _profileWidget(context, listSouce[index]),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    listSouce[index].message,
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontFamily: "Raleway"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                listSouce[index].messageImage != null
                    ? Image.network(
                        listSouce[index].messageImage,
                        fit: BoxFit.cover,
                      )
                    : Container(),
                listSouce[index].messageImage != null
                    ? Container()
                    : _commonDivider(),
                FittedBox(
                  fit: BoxFit.contain,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _bottomButton(
                        numers: "${listSouce[index].likesCount} Likes",
                        iconColor: Colors.green,
                        leftIcon: Icons.favorite,
                        onPressed: () {
                          print("likes");
                        },
                      ),
                      _bottomButton(
                        numers: "${listSouce[index].commentsCount} Comments",
                        iconColor: Colors.blue,
                        leftIcon: Icons.comment,
                        onPressed: () {
                          print("Comments");
                        },
                      ),
                      Text(
                        listSouce[index].postTime,
                        style: TextStyle(fontFamily: "Raleway"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: listSouce.length),
    );
  }

//头部布局
  Widget _profileWidget(BuildContext context, listModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(model.personImage),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.personName,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .apply(fontWeightDelta: 700),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  model.address,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .apply(fontFamily: "Raleway", color: Colors.orange),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//喜欢
class _bottomButton extends StatelessWidget {
  final String numers;
  final leftIcon;
  final Color iconColor;
  final onPressed;
  _bottomButton({this.numers, this.leftIcon, this.iconColor, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed,
      child: Row(
        children: <Widget>[
          Icon(
            leftIcon,
            color: iconColor,
            size: 20.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            numers,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

//mark:分割线
class _commonDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.shade300,
      height: 8.0,
    );
  }
}

///mark: appbar
class _appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      title: Text("新闻"),
      forceElevated: true,
      elevation: 1.0,
      pinned: true,
      floating: true,
      bottom: _bottomBar(context),
    );
  }

  Widget _bottomBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 50.0),
      child: Container(
        color: Colors.black,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "所有新闻",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
