import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_info_app/presentation/company_info/company_info_view_model.dart';

import 'company_info_state.dart';
import 'components/stock_chart.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CompanyInfoViewModel>();
    final state = viewModel.state;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (state.errorMessage != null)
              Center(child: Text(state.errorMessage!)),
            if (state.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (state.isLoading == false &&
                state.errorMessage == null &&
                state.companyInfo != null)
              _buildBody(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CompanyInfoState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.companyInfo!.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            state.companyInfo!.symbol,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            'Industry: ${state.companyInfo!.industry}',
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            'Country: ${state.companyInfo!.country}',
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(),
          Text(
            state.companyInfo!.description,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '?????? ?????????',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (state.stockInfos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StockChart(
                infos: state.stockInfos,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}
