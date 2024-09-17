import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class Zipcode extends StatefulWidget {
  const Zipcode({super.key});

  @override
  State<Zipcode> createState() => _ZipcodeState();
}

class _ZipcodeState extends State<Zipcode> {
  String zipCode = '';
  String countryCode = '';
  late List codes = [zipCode, countryCode];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 40.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(Icons.pin_drop_outlined, color: Colors.white),
                    hintText: 'Enter Zip Code',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    zipCode = value;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(Icons.public, color: Colors.white),
                    hintText: 'Enter Country Code',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    countryCode = value;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  // print(codes);
                  Navigator.pop(context, codes);
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
