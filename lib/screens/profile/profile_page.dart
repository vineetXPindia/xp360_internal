import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:xp_internal/models/new_login_model.dart';
import 'package:xp_internal/screens/home/home.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? dateOfJoining;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginModel = LoginDataModel();
    var userData = prefs.getString('userResponse');
    if (userData != null && userData.isNotEmpty) {
      loginModel = loginDataModelFromJson(userData);
      firstName = loginModel.data?.firstName.toString();
      print(loginModel.data?.firstName);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            topBar(context, screenWidth, screenHeight),
            profileImage(context, screenWidth, screenHeight),
            // Edit button
            GestureDetector(
              onTap: () {
                print('Edit button tapped');
                setState(() {
                  loadUserInfo();
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
                height: screenHeight * 0.03,
                width: screenWidth * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ),
              ),
            ),
            infoCard(context, screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget topBar(BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      color: Colors.white,
      height: screenHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: screenHeight * 0.03,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: screenHeight * 0.03,
            ),
          )
        ],
      ),
    );
  }

  Widget profileImage(
      BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.02,
      ),
      height: screenHeight * 0.18,
      width: screenHeight * 0.18,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(screenWidth * 0.5),
      ),
      child: Image.asset(
        'lib/assets/icons/orders.png',
        height: screenHeight * 0.1,
      ), // Add a valid image path
    );
  }

  Widget infoCard(
      BuildContext context, double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.04,
        horizontal: screenWidth * 0.05,
      ),
      width: screenWidth * 0.85,
      height: screenHeight * 0.53,
      decoration: BoxDecoration(
        color: newCardBG,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          infoRow('First Name', firstName),
          infoRow('Last Name', lastName),
          infoRow('Email', email),
          infoRow('Phone Number', phoneNumber),
          infoRow('Date of Joining', dateOfJoining),
        ],
      ),
    );
  }

  Widget infoRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          value ?? "N/A",
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
