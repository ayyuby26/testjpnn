import 'package:flutter/material.dart';
import 'package:jpnn2/utils/general.dart';
import 'package:jpnn2/view_model/headline_view_model.dart';
import 'package:provider/provider.dart';

class HeadlineSearchScreen extends StatefulWidget {
  HeadlineSearchScreen({Key? key}) : super(key: key);

  @override
  _HeadlineSearchScreenState createState() => _HeadlineSearchScreenState();
}

class _HeadlineSearchScreenState extends State<HeadlineSearchScreen> {
  final searchCtrl = TextEditingController();
  final fn = FocusNode();

  @override
  void initState() {
    fn.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadlineProvider>(builder: (context, prov, child) {
      final Widget _search = Container(
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            onSubmitted: (value) {
              if (searchCtrl.text.isNotEmpty) {
                prov.setHeadLineSearch(searchCtrl.text);
              }
            },
            focusNode: fn,
            controller: searchCtrl,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(15, 10, 0, 10),
              border: InputBorder.none,
              fillColor: Colors.blue.withOpacity(.1),
              filled: true,
              suffixIcon: InkWell(
                onTap: () {
                  if (searchCtrl.text.isNotEmpty) {
                    prov.setHeadLineSearch(searchCtrl.text);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Icon(Icons.search),
                ),
              ),
              prefixStyle: const TextStyle(color: Colors.transparent),
            ),
            // sdec
          ),
        ),
      );

      final _itemList = ListView.builder(
        padding: const EdgeInsets.all(10),
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
                  height: 80,
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${prov.getHeadlineSearch[index]?.description}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        "${prov.getHeadlineSearch[index]?.source.name}",
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

      return Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: true,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {
                prov.searchClear();
                Navigator.of(context).pop(true);
              },
              child: Container(
                // padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.blue[300],
                ),
              ),
            ),
          ),
          leadingWidth: 30,
          backgroundColor: Colors.white,
          title: _search,
        ),
        body: SafeArea(
          child: prov.getHeadlineSearch.isEmpty ? SizedBox() : _itemList,
        ),
      );
    });
  }
}
