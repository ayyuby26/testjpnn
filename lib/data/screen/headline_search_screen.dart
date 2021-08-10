import 'package:flutter/material.dart';
import 'package:jpnn2/data/provider/headline_provider.dart';
import 'package:jpnn2/utils/general.dart';
import 'package:provider/provider.dart';

class HeadlineSearchScreen extends StatefulWidget {
  HeadlineSearchScreen({Key? key}) : super(key: key);

  @override
  _HeadlineSearchScreenState createState() => _HeadlineSearchScreenState();
}

class _HeadlineSearchScreenState extends State<HeadlineSearchScreen> {
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HeadlineProvider>(context);
    if (prov.getHeadline.isEmpty) prov.setHeadLine();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: TextField(
          controller: searchCtrl,
          decoration: InputDecoration(
            suffix: GestureDetector(
              onTap: () {
                print("search3 3 ${searchCtrl.text}");
                if (searchCtrl.text.isNotEmpty) prov.setHeadLineSearch(searchCtrl.text);
              },
              child: Icon(Icons.search),
            ),
            prefixStyle: TextStyle(color: Colors.transparent),
          ),
          // sdec
        ),
      ),
      body: SafeArea(
        child: prov.getHeadlineSearch.isEmpty
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: prov.getHeadlineSearch.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "${prov.getHeadlineSearch[index]?.urlToImage}",
                            width: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return imgError(
                                img: "${prov.getHeadlineSearch[index]?.urlToImage}",
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
                                  "${prov.getHeadlineSearch[index]?.title}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${prov.getHeadlineSearch[index]?.description}",
                                  maxLines: 2,
                                ),
                                Text(
                                  "${prov.getHeadlineSearch[index]?.source?.name}",
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
              ),
      ),
    );
  }
}
