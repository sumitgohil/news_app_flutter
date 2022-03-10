import 'package:intl/intl.dart';

class Utils {
  String formatDate(DateTime dt) {
    return DateFormat('dd/MM/yyyy  kk:mm a').format(dt);
  }
}
