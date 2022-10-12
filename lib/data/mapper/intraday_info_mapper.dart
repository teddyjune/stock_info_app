import 'package:intl/intl.dart';
import 'package:stock_info_app/data/source/remote/dto/intraday_info_dto.dart';

import '../../domain/model/intraday_info.dart';

extension ToIntradayInfo on IntradayInfoDto {
  IntradayInfo toIntradayInfo() {
    // 2022-06-27 19:15:00
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return IntradayInfo(
      date: formatter.parse(timestamp),
      close: close,
    );
  }
}
