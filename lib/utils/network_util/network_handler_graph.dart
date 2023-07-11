// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field

import 'dart:convert';

import 'package:flutter/services.dart';
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
    final HttpLink httpLink = HttpLink(baseUrl);
    final Link link = httpLink;

    Future.microtask(() => client = GraphQLClient(
          link: link,
          cache: GraphQLCache(),
        ));
    _baseUrl = baseUrl;
    _showLogs = showLogs;
    _enableDialogue = enableDialogue;
  }

  Future<Either<CleanFailure, QueryResult>> get({
    required String query,
  }) async {
    try {
      // final response = await client.get(
      //   url,
      //   headers: _header,
      // );

      final result = await client.query(QueryOptions(
        document: gql(query),
      ));

      if (result.hasException) {
        return left(
          CleanFailure.withData(
            statusCode: -1,
            enableDialogue: _enableDialogue,
            tag: query,
            method: 'GET',
            url: _baseUrl,
            // header: _header,
            header: const {},

            body: const {},
            error: result.exception.toString(),
          ),
        );
      }

      return handleResponse(
        query: query,
        result: result,
        // endPoint: query,
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
          header: const {},

          body: const {},
          error: e.toString(),
        ),
      );
    }
  }

  Either<CleanFailure, QueryResult> handleResponse({
    required QueryResult result,
    required String query,
  }) {
    // Logger.v("request: ${result.request}");
    Logger.json(jsonEncode(result.data));

    final Map<String, dynamic>? _regResponse = result.data;

    try {
      // final T _typedResponse = fromData(_regResponse!);
      // Logger.i("parsed data: $_typedResponse");
      return right(result);
    } catch (e) {
      // Logger.w("header: ${response.request?.headers}");
      // Logger.w("request: ${response.request}");

      Logger.w("body: ${result.data}");
      // Logger.w("status code: ${response.statusCode}");
      Logger.w("error: $e");
      return left(
        CleanFailure.withData(
          tag: query,
          url: query,
          // method: response.request?.method ?? "",
          method: "GET",
          header: const {},
          statusCode: -1,
          // header: response.request?.headers ?? {},
          body: _regResponse ?? {},
          error: e,
        ),
      );
    }
  }
}
