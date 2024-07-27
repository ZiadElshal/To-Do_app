import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/app_colors.dart';

class MyThemeData{
  ///light mode
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.grayColor,
      showUnselectedLabels: false,
      //showSelectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0
    ),

    ///text fonts
    textTheme: TextTheme(
      ///title of app
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor
      ),
      ///head of bottom sheet
      titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor
      ),
      ///hint text in TextFormField
      labelMedium: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppColors.hintTextColor
      ),
      ///select date
      labelLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor
      ),
      ///time in task list
      displaySmall: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor
      ),
      ///language and theme
      headlineMedium: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor
      ),
    )
  );

  ///dark mode
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          elevation: 0
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.grayColor,
          showUnselectedLabels: false,
          //showSelectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0
      ),

      ///text fonts
      textTheme: TextTheme(
        ///title of app
        titleLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor
        ),
        ///head of bottom sheet
        titleMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor
        ),
        ///hint text in TextFormField
        labelMedium: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.hintTextColor
        ),
        ///select date
        labelLarge: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.whiteColor
        ),
        ///time in task list
        displaySmall: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.whiteColor
        ),
        ///language and theme
        headlineMedium: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor
        ),
      )
  );

}