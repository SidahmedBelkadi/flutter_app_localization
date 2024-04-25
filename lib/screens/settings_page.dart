import 'package:bloc_course/core/localization/app_localization.dart';
import 'package:bloc_course/cubit/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "settings".tr(context),
        ),
      ),
      body: Center(
        child: BlocConsumer<LocaleCubit, ChangeLocalState>(
          builder: (context, state) {
            return DropdownMenu(
              initialSelection: state.locale.languageCode,
              onSelected: (value) {
                context.read<LocaleCubit>().changeLocale(languageCode: value.toString());
              },
              dropdownMenuEntries: langDropDrownEntries.map((String item) {
                return DropdownMenuEntry(value: item, label: item);
              }).toList(),
            );
          },
          listener: (BuildContext context, ChangeLocalState state) {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
