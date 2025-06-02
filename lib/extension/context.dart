import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../infrastructure/presentation/util/date_time_format.dart';

/// Get defaults that use of [BuildContext]
extension BuildContextExtension on BuildContext {
  /// Variable for resume for get S.of(context).[variable]
  S get s => S.of(this);

  /// Returns class default of fluent [typography]
  /// title, subTitle, body, bodyStrong ...
  TextTheme get typography => Theme.of(this).textTheme;

  /// Media query of screen // context
  Size get media => MediaQuery.sizeOf(this);

  /// Function for get default Provider.of<{your class ChangeNotifier}>(context)
  /// And type is T
  T provider<T>() {
    return Provider.of<T>(this);
  }
}
