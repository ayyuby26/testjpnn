import 'package:flutter/material.dart';
import 'package:jpnn2/model/headline_model.dart';
import 'package:jpnn2/utils/general.dart';
import 'package:jpnn2/view/screens/headline_screen/headline_screen.dart';
import 'package:jpnn2/view_model/headline_view_model.dart';
import 'package:provider/provider.dart';

class KKOl extends StatelessWidget {
  const KKOl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// ignore: must_be_immutable
// class HeadlineParts extends HeadlineScreen {
//   GlobalKey<ScaffoldState> key;
//   HeadlineParts(this.key);
//   get prov => Provider.of<HeadlineProvider>(key.currentContext!);

//   Widget get smallHeader {
//     final List<HeadlineModel> _range = prov.getHeadline.getRange(1, 4).toList();

//     _imgWidget(String img) {
//       return Image.network(
//         img,
//         width: double.maxFinite,
//         fit: BoxFit.cover,
//         height: 80,
//         errorBuilder: (context, error, stackTrace) {
//           return imgError(
//             width: double.maxFinite,
//             height: 80,
//             img: img,
//           );
//         },
//       );
//     }

//     return Row(
//       children: _range.map((e) {
//         return Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _imgWidget("${e.urlToImage}"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "${e.title}",
//                   maxLines: 2,
//                 ),
//               )
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget get headline {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             Image.network(
//               "${prov.getHeadline[0]?.urlToImage}",
//               width: double.maxFinite,
//               height: 200,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return imgError(
//                   width: double.maxFinite,
//                   height: 200,
//                   img: "${prov.getHeadline[0]?.urlToImage}",
//                 );
//               },
//             ),
//             Positioned.fill(
//               // bottom: 10,
//               child: Container(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   color: Colors.white.withOpacity(.5),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "${prov.getHeadline[0]?.title}",
//                       style: TextStyle(),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         smallHeader
//       ],
//     );
//   }

//   get 
// }
