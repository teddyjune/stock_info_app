import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_info_app/domain/repository/stock_repository.dart';
import 'package:stock_info_app/presentation/company_listings/company_listings_action.dart';
import 'package:stock_info_app/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;
  var _state = const CompanyListingsState();

  CompanyListingsState get state => _state;

  Timer? _debounce;

  //불필요한 실행을 줄여준다

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  void onAction(CompanyListingsAction action) {
    action.when(
      refresh: () => _getCompanyListings(fetchFromRemote: true),
      onSearchQueryChange: (query) {
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          _getCompanyListings(query: query);
        });
      },
    );
  }

  Future _getCompanyListings({
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(success: (listings) {
      _state = state.copyWith(
        companies: listings,
      );
    }, error: (e) {
      print('리모트 에러 : $e');
    });
    //if는 강제성이 없고, when은 강제성을 준다

    _state = state.copyWith(
      isLoading: false,
    );
    notifyListeners();
  }
}
