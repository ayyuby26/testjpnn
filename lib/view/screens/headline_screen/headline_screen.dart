import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jpnn2/utils/general.dart';
import 'package:jpnn2/view/screens/headline_screen/headline_parts.dart';
import 'package:jpnn2/view_model/headline_view_model.dart';
import 'package:provider/provider.dart';
import '../headline_search_screen.dart';

class HeadlineScreen extends StatefulWidget {
  HeadlineScreen({Key? key}) : super(key: key);

  @override
  _HeadlineScreenState createState() => _HeadlineScreenState();
}

class _HeadlineScreenState extends State<HeadlineScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    final prov = Provider.of<HeadlineProvider>(context, listen: false);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0)
          // You're at the bottom.
          prov.setHeadLine(true);
      }
    });
    super.initState();
  }

  final searchCtrl = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    itemList(HeadlineProvider prov) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: prov.getHeadline.length,
        itemBuilder: (context, index) {
          final _data = prov.getHeadline[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "${_data?.urlToImage}",
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, _) {
                    return imgError(
                      img: "${_data?.urlToImage}",
                      width: 80,
                    );
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_data?.title}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${_data?.description}",
                        maxLines: 2,
                      ),
                      Text(
                        "${_data?.source.name}",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget smallHeader(HeadlineProvider prov) {
      final _range = prov.getHeadline.getRange(1, 4).toList();

      _imgWidget(String img) {
        return Image.network(
          img,
          width: double.maxFinite,
          fit: BoxFit.cover,
          height: 80,
          errorBuilder: (context, error, stackTrace) {
            return imgError(
              width: double.maxFinite,
              height: 80,
              img: img,
            );
          },
        );
      }

      return Row(
        children: _range.map((e) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _imgWidget("${e?.urlToImage}"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${e?.title}",
                    maxLines: 2,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      );
    }

    headline(HeadlineProvider prov) {
      return Column(
        children: [
          Stack(
            children: [
              Image.network(
                "${prov.getHeadline[0]?.urlToImage}",
                width: double.maxFinite,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return imgError(
                    width: double.maxFinite,
                    height: 200,
                    img: "${prov.getHeadline[0]?.urlToImage}",
                  );
                },
              ),
              Positioned.fill(
                // bottom: 10,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white.withOpacity(.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${prov.getHeadline[0]?.title}",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          smallHeader(prov)
        ],
      );
    }

    return Scaffold(
      key: _key,
      body: Consumer<HeadlineProvider>(
        builder: (BuildContext context, prov, Widget? child) {
          if (prov.getHeadline.isEmpty) prov.setHeadLine();
          // final _parts = HeadlineParts(_key);
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () {
                prov.clear();
                return Future.delayed(Duration(seconds: 2), () {
                  prov.setHeadLine(false, true);
                });
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    // _parts.smallHeader,
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.maxFinite,
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return HeadlineSearchScreen();
                            }),
                          );
                        },
                        child: Text("Search..."),
                      ),
                    ),
                    if (prov.getHeadline.isNotEmpty)
                      Column(
                        children: [
                          headline(prov),
                          itemList(prov),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
