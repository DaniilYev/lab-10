import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_application_1/constant/app_colors.dart';
import 'package:flutter_application_1/constant/text_style_values.dart';

class UserInfoPage extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String story;

  const UserInfoPage({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Basic user info items
            _infoItem('name'.tr(), name),
            _infoItem('phone'.tr(), phone),
            _infoItem('email'.tr(), email),

            const SizedBox(height: 18),

            /// Story label
            Text(
              'story'.tr(),
              style: AppTextStyles.px12Blue.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 6),

            /// Story text
            Text(
              story.trim().isEmpty ? '-' : story,
              style: AppTextStyles.superSmall.copyWith(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),

            const Spacer(),

            /// Navigation button
            _buildProfileButton(context),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// --------------------------------------------
  ///  APP BAR
  /// --------------------------------------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      title: Text(
        'user_info'.tr(),
        style: AppTextStyles.px12Blue.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// --------------------------------------------
  ///  PROFILE BUTTON
  /// --------------------------------------------
  Widget _buildProfileButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.indigoColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, '/profile'),
        child: const Text("Open Profile (Lab 10)"),
      ),
    );
  }

  /// --------------------------------------------
  ///  USER INFO ROW
  /// --------------------------------------------
  Widget _infoItem(String label, String value) {
    final displayedValue = value.trim().isEmpty ? '-' : value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: AppTextStyles.px12Blue.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              displayedValue,
              style: AppTextStyles.superSmall.copyWith(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
