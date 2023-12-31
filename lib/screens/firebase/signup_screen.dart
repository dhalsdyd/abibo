//SignupScreen.dart
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/screens/init_pin_screen.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

class _SignupScreenState extends State<SignupScreen> {
  final _authentication = FirebaseAuth.instance;
  String? email;
  String? pw;
  String? pwCheck;
  String errorString = ''; //login error 보려고 만든 String state
  bool isButtonPressed = false;

  //firebase auth login 함수, 이멜 + 비번으로 로그인
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/signup_screen.png'), // 배경화면으로 사용할 이미지 경로
                fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조절하여 채우도록 설정
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight / 844 * 104,
                bottom: 0,
                left: screenHeight / 844 * 28,
                right: screenHeight / 844 * 28,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          Text(
                            "아비보 가입하기",
                            style: ABTextTheme.LoginMainText2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 844 * 58,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight / 844 * 40,
                              child: TextField(
                                style: const TextStyle(
                                    color: Colors.white), // 입력 중 텍스트 스타일
                                decoration: InputDecoration(
                                  hintText: '아이디',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                  filled: false,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 944 * 48,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight / 844 * 40,
                              child: TextField(
                                obscureText: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                ), // 입력 중 텍스트 스타일
                                decoration: InputDecoration(
                                  hintText: '비밀번호',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                  filled: false,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    pw = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 944 * 48,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight / 844 * 40,
                              child: TextField(
                                obscureText: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                ), // 입력 중 텍스트 스타일
                                decoration: InputDecoration(
                                  hintText: '비밀번호 확인',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                  filled: false,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    pwCheck = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 944 * 57,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight / 944 * 70,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              if (email != null &&
                                  pw != null &&
                                  pw == pwCheck) {
                                await _authentication
                                    .createUserWithEmailAndPassword(
                                  email: email!,
                                  password: pw!,
                                );
                                navigateToInitPINScreen();
                              } else if (pw != pwCheck) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("비밀번호 확인이 올바르지 않습니다."),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("이메일과 비밀번호를 입력해주세요."),
                                  ),
                                );
                              }
                            } catch (err) {
                              print(err);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("오류"),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD08FFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            "회원가입",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/