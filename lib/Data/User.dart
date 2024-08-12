class User {
  String? key;
  UserData? userData;

  User({this.key, this.userData});

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'userData': userData?.toJson(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      key: json['key'],
      userData: json['userData'] != null ? UserData.fromJson(json['userData']) : null,
    );
  }
}

class UserData {

  String username;
  String password;
  String mobilePhoneNumber;
  String gender;
  //Gender gender;
  DateTime dob;
  bool agreeToTerms;

  UserData({
    required this.username,
    required this.password,
    required this.mobilePhoneNumber,
    required this.gender,
    required this.dob,
    required this.agreeToTerms,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password, // Remember: Storing passwords in plaintext is not recommended
      'mobilePhoneNumber': mobilePhoneNumber,
      'gender': gender,
      //'gender': genderToString(gender),
      'dob': dob.toIso8601String(), // Format DateTime as ISO-8601 string
      'agreeToTerms': agreeToTerms,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      username: json['username'],
      password: json['password'], // Ensure secure handling of passwords
      mobilePhoneNumber: json['mobilePhoneNumber'],
      gender: json['gender'],
      //gender: genderFromString(json['gender']),
      dob: DateTime.parse(json['dob']), // Convert ISO-8601 string to DateTime
      agreeToTerms: json['agreeToTerms'],
    );
  }
}

/*enum Gender { male, female }

String genderToString(Gender gender) {
  return gender == Gender.male ? 'male' : 'female';
}

Gender genderFromString(String genderStr) {
  return genderStr == 'male' ? Gender.male : Gender.female;
}*/

