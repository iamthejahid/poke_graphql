// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field

import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graphql/client.dart';

import 'network_failure.dart';

class NetworkHandlerGraphQL {
  NetworkHandlerGraphQL._();

  static final NetworkHandlerGraphQL instance = NetworkHandlerGraphQL._();

  // String? _token;
  late String _baseUrl;
  late bool _enableDialogue;
  late bool _showLogs;
  late GraphQLClient client;

  void setup(
      {required String baseUrl,
      bool showLogs = false,
      bool enableDialogue = true}) {
    client = GraphQLClient(
      link: HttpLink(baseUrl),
      cache: GraphQLCache(),
    );
    _baseUrl = baseUrl;
    _showLogs = showLogs;
    _enableDialogue = enableDialogue;
  }

  Future<Either<CleanFailure, T>> get<T>({
    required String query,
    required T Function(Map<String, dynamic> data) fromData,
  }) async {
    try {
      // final response = await client.get(
      //   url,
      //   headers: _header,
      // );

      final result = await client.query(QueryOptions(
        document: gql(query),
      ));

      return handleResponse<T>(
        query: query,
        response: result,
        // endPoint: query,
        fromData: fromData,
      );
    } catch (e) {
      Logger.e("1st catch Error: $e");
      return left(
        CleanFailure.withData(
          statusCode: -1,
          enableDialogue: _enableDialogue,
          tag: query,
          method: 'GET',
          url: _baseUrl,
          // header: _header,
          header: {},

          body: const {},
          error: e.toString(),
        ),
      );
    }
  }

  Either<CleanFailure, T> handleResponse<T>({
    required QueryResult response,
    required String query,
    required T Function(Map<String, dynamic> data) fromData,
  }) {
    // Logger.v("request: ${response.request}");
    Logger.json(response.data.toString());

    final Map<String, dynamic>? _regResponse = response.data;

    try {
      final T _typedResponse = fromData(_regResponse!);
      Logger.i("parsed data: $_typedResponse");
      return right(_typedResponse);
    } catch (e) {
      // Logger.w("header: ${response.request?.headers}");
      // Logger.w("request: ${response.request}");

      Logger.w("body: ${response.data}");
      // Logger.w("status code: ${response.statusCode}");
      Logger.w("error: $e");
      return left(
        CleanFailure.withData(
          tag: query,
          url: query,
          // method: response.request?.method ?? "",
          method: "GET",
          header: {},
          statusCode: -1,
          // header: response.request?.headers ?? {},
          body: _regResponse ?? {},
          error: e,
        ),
      );
    }
  }
}
