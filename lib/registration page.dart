import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/constant/app_colors.dart';
import 'package:flutter_application_1/constant/text_style_values.dart';
import 'package:flutter_application_1/bloc/auth_bloc.dart';
import 'user_info_page.dart';

/// A user registration page supporting validation,
/// two-way form input, localization, and BLoC-based authentication.
class RegistrationPageNew extends StatefulWidget {
  const RegistrationPageNew({super.key});

  @override
  State<RegistrationPageNew> createState() => _RegistrationPageNewState();
}

class _RegistrationPageNewState extends State<RegistrationPageNew> {
  final _formKey = GlobalKey<FormState>();

  /// Text controllers
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final storyCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  /// Password visibility toggles
  bool _hidePass = true;
  bool _hideConfirm = true;

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    storyCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  // ----------------------
  // VALIDATION METHODS
  // ----------------------

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'name_required'.tr();
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'email_required'.tr();
    if (!value.contains('@')) return 'email_invalid'.tr();

    final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!pattern.hasMatch(value.trim())) return 'email_invalid'.tr();

    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'phone_required'.tr();
    if (!value.startsWith('+7')) return 'phone_must_start'.tr();
    if (!RegExp(r'^\+7\d{10}$').hasMatch(value)) return 'phone_invalid'.tr();
    return null;
  }

  String? _validatePass(String? value) {
    if (value == null || value.isEmpty) return 'pass_required'.tr();
    if (value.length < 6) return 'pass_length'.tr();
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value != passCtrl.text) return 'pass_not_match'.tr();
    return null;
  }

  // ----------------------
  // FORM SUBMISSION
  // ----------------------

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            RegisterSubmitted(
              name: nameCtrl.text.trim(),
              phone: phoneCtrl.text.trim(),
              email: emailCtrl.text.trim(),
              story: storyCtrl.text.trim(),
              password: passCtrl.text,
            ),
          );
    }
  }

  // ----------------------
  // COMMON FIELD STYLE
  // ----------------------

  InputDecoration _fieldStyle({
    required String label,
    required IconData icon,
    String? helper,
    String? hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      helperText: helper,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.indigoColor),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.gray),
      ),
      suffixIcon: suffix,
    );
  }

  // ----------------------
  // BUILD METHOD
  // ----------------------

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => UserInfoPage(
                name: state.name,
                phone: state.phone,
                email: state.email,
                story: state.story,
              ),
            ),
          );
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade400,
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },

      child: Scaffold(
        backgroundColor: AppColors.creamColor,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text(
            'title'.tr(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),

        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              children: [

                // NAME FIELD
                TextFormField(
                  controller: nameCtrl,
                  decoration: _fieldStyle(
                    label: 'full_name'.tr(),
                    icon: Icons.person,
                    helper: 'example_name'.tr(),
                  ),
                  validator: _validateName,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 14),

                // PHONE FIELD
                TextFormField(
                  controller: phoneCtrl,
                  decoration: _fieldStyle(
                    label: 'phone_number'.tr(),
                    icon: Icons.phone,
                    helper: 'phone_format'.tr(),
                    hint: '+7XXXXXXXXXX',
                  ),
                  validator: _validatePhone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 14),

                // EMAIL FIELD
                TextFormField(
                  controller: emailCtrl,
                  decoration: _fieldStyle(
                    label: 'email_address'.tr(),
                    icon: Icons.email_outlined,
                  ),
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 14),

                // STORY FIELD
                TextFormField(
                  controller: storyCtrl,
                  maxLines: 3,
                  decoration: _fieldStyle(
                    label: 'life_story'.tr(),
                    icon: Icons.notes_rounded,
                    helper: 'story_hint'.tr(),
                  ),
                ),
                const SizedBox(height: 16),

                // PASSWORD FIELD
                TextFormField(
                  controller: passCtrl,
                  obscureText: _hidePass,
                  decoration: _fieldStyle(
                    label: 'password'.tr(),
                    icon: Icons.lock_outline,
                    suffix: IconButton(
                      onPressed: () =>
                          setState(() => _hidePass = !_hidePass),
                      icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  validator: _validatePass,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 14),

                // CONFIRM PASSWORD
                TextFormField(
                  controller: confirmCtrl,
                  obscureText: _hideConfirm,
                  decoration: _fieldStyle(
                    label: 'confirm_pass'.tr(),
                    icon: Icons.lock_reset_outlined,
                    suffix: IconButton(
                      onPressed: () =>
                          setState(() => _hideConfirm = !_hideConfirm),
                      icon: Icon(
                        _hideConfirm ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  validator: _validateConfirm,
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 28),

                // SUBMIT BUTTON (With Loading)
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.indigoColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                            : Text('submit_form'.tr()),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // LANGUAGE SWITCHER
                Center(
                  child: Column(
                    children: [
                      Text('change_lang'.tr(), style: AppTextStyles.superSmall),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _langButton('EN', const Locale('en')),
                          const SizedBox(width: 16),
                          _langButton('RU', const Locale('ru')),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper button to switch languages.
  Widget _langButton(String text, Locale locale) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => context.setLocale(locale),
      child: Text(text),
    );
  }
}
