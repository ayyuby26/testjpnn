import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jpnn2/data/provider/headline_provider.dart';
import 'package:jpnn2/utils/general.dart';
import 'package:provider/provider.dart';

import 'headline_search_screen.dart';

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
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          prov.setHeadLine(true);
        }
      }
    });
    super.initState();
  }

  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HeadlineProvider>(context);
    if (prov.getHeadline.isEmpty) prov.setHeadLine();

    smallHeader(String img, String title) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "$img",
              width: double.maxFinite,
              fit: BoxFit.cover,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return imgError(
                  width: double.maxFinite,
                  height: 80,
                  img: "$img",
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$title",
                maxLines: 2,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            prov.clear();
            // Timer(Duration(seconds: 2), ()=> )
            return Future.delayed(Duration(seconds: 2), () => prov.setHeadLine(false, true));
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  color: Colors.blue.withOpacity(.1),
                  width: double.maxFinite,
                  height: 50,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HeadlineSearchScreen()),
                      );
                    },
                    child: Text("Search..."),
                  ),
                ),
                prov.getHeadline.isEmpty
                    ? SizedBox()
                    : Column(
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
                          Row(
                            children: [
                              smallHeader("${prov.getHeadline[1]?.urlToImage}", "${prov.getHeadline[1]?.title}"),
                              smallHeader("${prov.getHeadline[2]?.urlToImage}", "${prov.getHeadline[2]?.title}"),
                              smallHeader("${prov.getHeadline[3]?.urlToImage}", "${prov.getHeadline[3]?.title}"),
                            ],
                          )
                        ],
                      ),
                prov.getHeadline.isEmpty
                    ? SizedBox()
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: prov.getHeadline.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "${prov.getHeadline[index]?.urlToImage}",
                                  width: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return imgError(
                                      img: "${prov.getHeadline[index]?.urlToImage}",
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
                                        "${prov.getHeadline[index]?.title}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "${prov.getHeadline[index]?.description}",
                                        maxLines: 2,
                                      ),
                                      Text(
                                        "${prov.getHeadline[index]?.source?.name}",
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
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
