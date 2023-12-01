import 'package:book_a_ride/widgets/rounded_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VehicleDetialeScreen extends StatefulWidget {
  final name;
  final contact;
  final avability;
  final List<String> imgList;
  const VehicleDetialeScreen({super.key,required this.name,required this.avability, required this.imgList, this.contact});

  @override
  State<VehicleDetialeScreen> createState() => _VehicleDetialeScreenState();
}

class _VehicleDetialeScreenState extends State<VehicleDetialeScreen> {
  var height , width;

  void openWhatsApp() async{
    String call = widget.contact;
    var whatsapp = "+91$call";
    var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=Hello Conferm the Booking Please Mention Pick-Up Location");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Vehicle Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        titleSpacing: 1,
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(

              child: CarouselSlider(

                carouselController: CarouselController(),
                options: CarouselOptions(
                  autoPlay: true,
                ),
                items: widget.imgList
                    .map((item) => Container(
                  child: Center(
                      child:
                      Image.network(item, width: 1000)),
                ))
                    .toList(),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            Text("Tax Details"),
            Container(
margin: EdgeInsets.only(left: 50),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text("Driver Name            :")),

                    Expanded(flex: 1,   child: Text(widget.name)),

                  ],
                ),
              ),
            ),
            Text(widget.avability),
            Text("Tax Details"),
            RoundedButton(
              backgroundcolor: Colors.lightBlueAccent,
              color: Colors.white,
              title: 'Book Through WhatsApp',
              onPressed: () {
                openWhatsApp();
                // if (_formKey.currentState!.validate()) {
                //   login(context);
                }
            ),
          ],
        ),
      ),
    );
  }
}
