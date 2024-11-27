import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String welcomeToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? message;
  bool? success;
  Data? data;
  dynamic code;

  LoginModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["Message"],
        success: json["Success"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "Data": data?.toJson(),
        "Code": code,
      };
}

class Data {
  String? userId;
  dynamic dbUserId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  dynamic testingPhone;
  String? authToken;
  dynamic userStatus;
  String? userType;
  String? role;
  dynamic isAdmin;
  bool? isAssociate;
  dynamic dateOfBirth;
  dynamic dateOfJoining;
  dynamic permissions;
  int? ffvId;
  String? code;
  String? profilePicUrl;
  dynamic branches;
  String? paymentMode;
  bool? selfRegistered;
  bool? showXpcnFreightDetails;
  bool? administrator;
  String? productType;
  dynamic vehicleNumber;
  List<PermissionType>? permissionType;

  Data({
    this.userId,
    this.dbUserId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.testingPhone,
    this.authToken,
    this.userStatus,
    this.userType,
    this.role,
    this.isAdmin,
    this.isAssociate,
    this.dateOfBirth,
    this.dateOfJoining,
    this.permissions,
    this.ffvId,
    this.code,
    this.profilePicUrl,
    this.branches,
    this.paymentMode,
    this.selfRegistered,
    this.showXpcnFreightDetails,
    this.administrator,
    this.productType,
    this.vehicleNumber,
    this.permissionType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["UserId"],
        dbUserId: json["DBUserId"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        email: json["Email"],
        phone: json["Phone"],
        testingPhone: json["TestingPhone"],
        authToken: json["AuthToken"],
        userStatus: json["UserStatus"],
        userType: json["UserType"],
        role: json["Role"],
        isAdmin: json["IsAdmin"],
        isAssociate: json["IsAssociate"],
        dateOfBirth: json["DateOfBirth"],
        dateOfJoining: json["DateOfJoining"],
        permissions: json["Permissions"],
        ffvId: json["FfvId"],
        code: json["Code"],
        profilePicUrl: json["ProfilePicUrl"],
        branches: json["Branches"],
        paymentMode: json["PaymentMode"],
        selfRegistered: json["SelfRegistered"],
        showXpcnFreightDetails: json["ShowXPCNFreightDetails"],
        administrator: json["Administrator"],
        productType: json["ProductType"],
        vehicleNumber: json["VehicleNumber"],
        permissionType: json["PermissionType"] == null
            ? []
            : List<PermissionType>.from(
                json["PermissionType"]!.map((x) => PermissionType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "DBUserId": dbUserId,
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "Phone": phone,
        "TestingPhone": testingPhone,
        "AuthToken": authToken,
        "UserStatus": userStatus,
        "UserType": userType,
        "Role": role,
        "IsAdmin": isAdmin,
        "IsAssociate": isAssociate,
        "DateOfBirth": dateOfBirth,
        "DateOfJoining": dateOfJoining,
        "Permissions": permissions,
        "FfvId": ffvId,
        "Code": code,
        "ProfilePicUrl": profilePicUrl,
        "Branches": branches,
        "PaymentMode": paymentMode,
        "SelfRegistered": selfRegistered,
        "ShowXPCNFreightDetails": showXpcnFreightDetails,
        "Administrator": administrator,
        "ProductType": productType,
        "VehicleNumber": vehicleNumber,
        "PermissionType": permissionType == null
            ? []
            : List<dynamic>.from(permissionType!.map((x) => x.toJson())),
      };
}

class PermissionType {
  dynamic permissionId;
  dynamic permissionName;

  PermissionType({
    this.permissionId,
    this.permissionName,
  });

  factory PermissionType.fromJson(Map<String, dynamic> json) => PermissionType(
        permissionId: json["PermissionId"],
        permissionName: json["PermissionName"],
      );

  Map<String, dynamic> toJson() => {
        "PermissionId": permissionId,
        "PermissionName": permissionName,
      };
}
