import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stock_info_app/data/repository/stock_repository_impl.dart';
import 'package:stock_info_app/data/source/local/company_listing_entity.dart';
import 'package:stock_info_app/data/source/local/stock_dao.dart';
import 'package:stock_info_app/data/source/remote/stock_api.dart';
import 'package:stock_info_app/domain/repository/stock_repository.dart';
import 'package:stock_info_app/presentation/company_listings/company_listingd_veiw_model.dart';
import 'package:stock_info_app/presentation/company_listings/company_listings_screen.dart';
import 'package:stock_info_app/util/color_schemes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyListingEntityAdapter());

  final repository = StockRepositoryImpl(
    StockApi(),
    StockDao(),
  );

  GetIt.instance.registerSingleton<StockRepository>(repository);
  //어디서나 쉽게 갖다쓸 수 있는 싱글톤 객체가 된다.

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CompanyListingsViewModel(repository),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.system,
      home: const CompanyListingsScreen(),
    );
  }
}
