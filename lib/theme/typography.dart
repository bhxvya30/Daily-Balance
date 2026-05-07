import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTypography {
  static TextStyle get hero => GoogleFonts.dmSans(
    fontSize: 28, fontWeight: FontWeight.w700,
    color: AppColors.textPrimary, letterSpacing: -0.5);

  static TextStyle get h1 => GoogleFonts.dmSans(
    fontSize: 22, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary);

  static TextStyle get h2 => GoogleFonts.dmSans(
    fontSize: 18, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary);

  static TextStyle get h3 => GoogleFonts.dmSans(
    fontSize: 15, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary);

  static TextStyle get body => GoogleFonts.dmSans(
    fontSize: 13, fontWeight: FontWeight.w400,
    color: AppColors.textSecondary, height: 1.6);

  static TextStyle get caption => GoogleFonts.dmSans(
    fontSize: 11, fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 1.2);

  static TextStyle get label => GoogleFonts.dmSans(
    fontSize: 10, fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 1.5);

  static TextStyle get statNumber => GoogleFonts.dmSans(
    fontSize: 26, fontWeight: FontWeight.w700,
    color: AppColors.textPrimary, letterSpacing: -0.5);

  static TextStyle get quote => GoogleFonts.playfairDisplay(
    fontSize: 20, fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.textSecondary, height: 1.6);

  static TextStyle get quoteAuthor => GoogleFonts.dmSans(
    fontSize: 10, fontWeight: FontWeight.w500,
    color: AppColors.textTertiary, letterSpacing: 2.0);

  static TextStyle get buttonPrimary => GoogleFonts.dmSans(
    fontSize: 14, fontWeight: FontWeight.w600,
    color: AppColors.buttonText, letterSpacing: 0.2);

  static TextStyle get buttonSecondary => GoogleFonts.dmSans(
    fontSize: 14, fontWeight: FontWeight.w500,
    color: AppColors.textSecondary);

  static TextStyle get badge => GoogleFonts.dmSans(
    fontSize: 10, fontWeight: FontWeight.w500,
    color: AppColors.textTertiary, letterSpacing: 0.3);
}
