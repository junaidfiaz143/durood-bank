import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durood_bank/components/slider_component.dart';
import 'package:durood_bank/components/text_field_component.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/globals.dart';
import 'package:durood_bank/utils/no_scroll_glow_behavior.dart';
import 'package:durood_bank/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../models/current_user_model.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  double _daroodCounter = 0;

  makeContribution() {
    if (_daroodCounter >= 100) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Utilities.showLoadingDialog(context: context);
          });
      FirebaseFirestore.instance.collection("durood").doc().set({
        "full_name":
            Provider.of<CurrentUserModel>(context, listen: false).fullName,
        "username":
            Provider.of<CurrentUserModel>(context, listen: false).userName,
        "is_official":
            Provider.of<CurrentUserModel>(context, listen: false).isOfficial ==
                    "true"
                ? true
                : false,
        "contribution": "${_daroodCounter.round()}",
        "time_stamp": FieldValue.serverTimestamp(),
        "contribution_id": contributionId
      }).whenComplete(() {
        Navigator.pop(context);
        Navigator.pop(context, "contributed");
      });
    } else {
      Utilities.showSnackBar(
          txt: "Recite درود atleast 100 times", context: context);
    }
  }

  late FixedExtentScrollController fixedExtentScrollController;
  int sliderLength = 101;
  late int selectedFatValue;
  @override
  void initState() {
    selectedFatValue = 0;
    fixedExtentScrollController = FixedExtentScrollController(initialItem: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: const Color(MyColors.primaryColor),
      //   elevation: 0,
      //   title: const Text("Counter"),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkResponse(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color(MyColors.primaryColor)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            LineIcons.arrowLeft,
                            color: Color(MyColors.primaryColor),
                          )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "About Us",
                          style: TextStyle(
                              color: Color(MyColors.primaryColor),
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              letterSpacing: 2),
                        ),
                        // const Text("Junaid Fiaz"),
                      ],
                    ),
                    Visibility(
                      visible: true,
                      child: InkResponse(
                        onTap: () {},
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              LineIcons.edit,
                              color: Colors.transparent,
                            )),
                      ),
                    )
                  ]),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("درود بینک کے بانی",
                  style: GoogleFonts.elMessiri(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: const Color(MyColors.primaryColor))),
            ),

            // const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.all(1),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(MyColors.primaryColor)
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/haji_m_fiaz.jpeg",
                            fit: BoxFit.fill,
                          ),
                        )),
                    Text(
                      "حاجی محمد فیاض",
                      style: GoogleFonts.elMessiri(
                          color: const Color(MyColors.primaryColor)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.all(1),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(MyColors.primaryColor)
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/haji_m_muneer.png",
                            fit: BoxFit.fill,
                          ),
                        )),
                    Text(
                      "حاجی منیر احمد",
                      style: GoogleFonts.elMessiri(
                          color: const Color(MyColors.primaryColor)),
                    )
                  ],
                )
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    ));
  }
}