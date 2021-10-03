import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watermark/dialogs/add_order.dart';
import 'package:watermark/models/order.dart';
import 'package:watermark/utils/app_config.dart';
import 'package:watermark/widgets/custom_list_item.dart';

class DataEntry extends StatefulWidget {
  @override
  _DataEntryState createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  final key = GlobalKey<AnimatedListState>();

  CollectionReference ref = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext ctxt) {

    SizeConfig().init(ctxt);
    return Container(
      alignment: Alignment.center,
      child: Column(children: [
        StreamBuilder(
            stream: ref.snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Expanded(
                  child: snapshot.hasData
                      ? ListView.builder(
                          key: key,

                          itemCount: snapshot.data.docs.length,

                          itemBuilder: (context, index) {
                            Map<String, dynamic> doc =
                                snapshot.data.docs[index].data();
                            return buildItem(
                                new Order(
                                    doc['clientName'],
                                    doc["orderDate"],
                                    doc["jobTitle"],
                                    doc["jobNature"],
                                    doc["orderQuantity"],
                                    doc["size"],
                                    doc['status']
                                ),
                                index);
                          },
                        )
                      : Center(child: Text("No data found")));
            }),
        Container(
          width: SizeConfig.safeBlockHorizontal * 95,
          height: SizeConfig.safeBlockHorizontal * 11,
          margin: EdgeInsets.fromLTRB(
              SizeConfig.safeBlockHorizontal * 2,
              SizeConfig.safeBlockVertical * 2,
              SizeConfig.safeBlockHorizontal * 2,
              SizeConfig.safeBlockVertical * 2),
          decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Color(0xff1C52DB),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3.0),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Color(0xff1C52DB).withOpacity(0.5);
                  },
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddOrder(
                      );
                    });
              },
              child: Text(
                "Create a new order",
                style: TextStyle(
                  color: Color(0xff1C52DB),
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget buildItem(item, int index) =>
      ListItemWidget(
        item: item,
        // onIconClicked: () => null,
        onItemClicked: (item) {
          // openOptionDialog(index: index, item: item);
          print("clicked");
        },
      );

}
