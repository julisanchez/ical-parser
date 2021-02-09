import 'package:ical_parser/ical_parser.dart';

void main() {
  var calendar =
  '''
BEGIN:VCALENDAR
VERSION:2.0
CALSCALE:GREGORIAN
BEGIN:VTODO
UID:132456762153245
SUMMARY:Do the dishes
DUE:20121028T115600Z
END:VTODO
END:VCALENDAR
  ''';

  print(ICal.toJson(calendar));
  // {VERSION: 2.0, CALSCALE: GREGORIAN, VTODO: [{UID: 132456762153245, SUMMARY: Do the dishes, DUE: 20121028T115600Z}]}

}
