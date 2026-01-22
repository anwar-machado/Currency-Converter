import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const request = "https://v6.exchangerate-api.com/v6/97a991777ae7e61af2d8bdc3/latest/USD";

void main() {
  runApp(const MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

// Fetch de API data and Turn it into JSON Format
Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return jsonDecode(response.body);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController mznTextController = TextEditingController();
  TextEditingController usdTextController = TextEditingController();
  TextEditingController eurTextController = TextEditingController();
  TextEditingController zarTextController = TextEditingController();

  double usd = 0.0, euro = 0.0, zar = 0.0, mzn = 0.0;

  void resetFields() {
    setState(() {
      mznTextController.text = "";
      usdTextController.text = "";
      eurTextController.text = "";
      zarTextController.text = "";

      // Closes the Keyboard
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {

    void usdChanged(String text) {
      double usd = double.parse(text.replaceAll(',', '.'));

      mznTextController.text = (usd * mzn).toStringAsFixed(2);
      eurTextController.text = (usd * euro).toStringAsFixed(2);
      zarTextController.text = (usd * zar).toStringAsFixed(2);
    }

    void euroChanged(String text) {
      double euro = double.parse(text.replaceAll(',', '.'));

      usdTextController.text = (euro / this.euro).toStringAsFixed(2);
      mznTextController.text = ((euro / this.euro) * mzn).toStringAsFixed(2);
      zarTextController.text = ((euro / this.euro) * zar).toStringAsFixed(2);
    }

    void mznChanged(String text) {
      double mzn = double.parse(text.replaceAll(',', '.'));

      usdTextController.text = (mzn / this.mzn).toStringAsFixed(2);
      eurTextController.text = ((mzn / this.mzn) * euro).toStringAsFixed(2);
      zarTextController.text = ((mzn / this.mzn) * zar).toStringAsFixed(2);
    }

    void zarChanged(String text) {
      double zar = double.parse(text.replaceAll(',', '.'));

      usdTextController.text = (zar / this.zar).toStringAsFixed(2);
      mznTextController.text = ((zar / this.zar) * mzn).toStringAsFixed(2);
      eurTextController.text = ((zar / this.zar) * euro).toStringAsFixed(2);
    }

    return GestureDetector(
      onTap: () {
        // Closes the Keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'C U R R E N C Y',
            style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: resetFields,
              icon: Icon(Icons.refresh_rounded, size: 30, color: Colors.white),
            ),
          ],
          backgroundColor: Colors.grey[700],
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    'Loading Data...',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error Loading Data.',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {

                  // Obtain each currency from the JSON
                  usd = (snapshot.data?["conversion_rates"]["USD"] as num).toDouble();
                  euro = (snapshot.data?["conversion_rates"]["EUR"] as num).toDouble();
                  mzn = (snapshot.data?["conversion_rates"]["MZN"] as num).toDouble();
                  zar = (snapshot.data?["conversion_rates"]["ZAR"] as num).toDouble();
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          Icon(
                            Icons.currency_exchange,
                            size: 120,
                            color: Colors.white,
                          ),
                          SizedBox(height: 40),
                          buildTextField(
                            'MZN',
                            'MZN ',
                            mznTextController,
                            mznChanged,
                          ),
                          SizedBox(height: 20),
                          buildTextField(
                            'USD',
                            'US\$ ',
                            usdTextController,
                            usdChanged,
                          ),
                          SizedBox(height: 20),
                          buildTextField(
                            'EUR',
                            '\u20AC ',
                            eurTextController,
                            euroChanged,
                          ),
                          SizedBox(height: 20),
                          buildTextField(
                            'ZAR',
                            'R ',
                            zarTextController,
                            zarChanged,
                          ),
                        ],
                      ),
                    ),
                  );
                }
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[700],
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.wallet, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.currency_exchange_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.dashboard, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String labelText,
    String prefixText,
    TextEditingController controller,
    Function(String) function,
  ) {
    return TextField(
      onChanged: function,
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white),
        labelText: labelText,
        prefix: Text(
          prefixText,
          style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white),
        ),
        // The OutlineInputBorder Without Touching it
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),

        // The OutlineInputBorder Touching it
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
