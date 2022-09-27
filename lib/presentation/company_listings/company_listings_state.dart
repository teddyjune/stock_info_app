import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart'; // toJson 불필요시 삭제

import '../../domain/model/company_listing.dart';

part 'company_listings_state.freezed.dart';

part 'company_listings_state.g.dart';

@freezed
class CompanyListingsState with _$CompanyListingsState {
  const factory CompanyListingsState({
    @Default([]) List<CompanyListing> companies,
    @Default(false) bool isLoadin,
    @Default(false) bool isRefreshing,
    @Default('') String searchQuery,
  }) = _CompanyListingsState;

  factory CompanyListingsState.fromJson(Map<String, Object?> json) =>
      _$CompanyListingsStateFromJson(json);
}
