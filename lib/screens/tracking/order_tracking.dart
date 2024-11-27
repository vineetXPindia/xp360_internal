import 'dart:async';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'package:xp_internal/constants/colors.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  late AppleMapController appleMapController;
  void _onMapCreated(AppleMapController controller) {
    appleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Track Orders'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(screenWidth * 0.08),
                bottomRight: Radius.circular(screenWidth * 0.08),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  color: Colors.black26,
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by order id/vehicle no. or xpcn',
                hintStyle: TextStyle(
                    color: Colors.black26, fontSize: screenWidth * 0.04),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.06),
                ),
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: AppleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(0.0, 0.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////
