import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:onscreen_logger/debug_helper/debug_log_controller.dart';
import 'package:onscreen_logger/debug_helper/debug_utilities.dart';

const _kTimeoutInterval = 1;

class GraphqlHelper {
  static void graphqlSuccessCall() async {
    /// Log the title of Graphql
    DebugLog debugLog = DebugLog(
      logTitle: "graphqlSuccessCall",
      dateTime: DateTime.now(),
    );
    var graphqlUrl = "https://api.spacex.land/graphql";

    /// Log the Url of Graphql
    debugLog.logStrings.add(
      DebugLogString(
        logTitle: "Graphql URL",
        logsDescription: graphqlUrl,
      ),
    );
    Map<String, String> header = {
      "Content-type": "application/json",
    };

    /// Log the Headers of Graphql
    debugLog.logStrings.add(
      DebugLogString(
        logTitle: "Graphql Headers",
        logsDescription: header.toString(),
      ),
    );

    final ValueNotifier<GraphQLClient> graphqlClient = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: HttpLink(
          graphqlUrl,
          defaultHeaders: header,
          // httpClient: ioClient,
        ),
      ),
    );
    QueryResult? queryResult = await _makeApiCall(
        graphqlClient: graphqlClient,
        fetchPolicy: FetchPolicy.networkOnly,
        query: correctGraphqlUrl());
    if (queryResult.hasException) {
      /// Log the Exception of Graphql
      debugLog.logStrings.add(
        DebugLogString(
          logTitle: "Graphql Exception",
          logsDescription: queryResult.exception?.toString() ?? "NULL",
        ),
      );

      /// Set Log color as red
      debugLog.setAsRed();
    } else {
      /// Log the Result of Graphql
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql Result",
          logsDescription:
              OnScreenDebugUtils.getMapToString(queryResult.data)));

      /// Set Log color as green
      debugLog.setAsGreen();
    }

    /// Finally Build the Ui for log
    OnScreenDebugUtils.onScreenDebugLogController.addDebugLog(debugLog);
  }

  static void graphqlFailureCall() async {
    /// Log the title of Graphql
    DebugLog debugLog = DebugLog(
      logTitle: "graphqlFailureCall",
      dateTime: DateTime.now(),
    );
    var graphqlUrl = "https://api.spacex.land/graphql";

    /// Log the Url of Graphql
    debugLog.logStrings.add(
      DebugLogString(
        logTitle: "Graphql URL",
        logsDescription: graphqlUrl,
      ),
    );
    Map<String, String> header = {
      "Content-type": "application/json",
    };

    /// Log the Headers of Graphql
    debugLog.logStrings.add(
      DebugLogString(
        logTitle: "Graphql Headers",
        logsDescription: header.toString(),
      ),
    );

    final ValueNotifier<GraphQLClient> graphqlClient = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: HttpLink(
          graphqlUrl,
          defaultHeaders: header,
          // httpClient: ioClient,
        ),
      ),
    );
    QueryResult? queryResult = await _makeApiCall(
        graphqlClient: graphqlClient,
        fetchPolicy: FetchPolicy.networkOnly,
        query: wrongGraphqlUrl());
    if (queryResult.hasException) {
      /// Log the Exception of Graphql
      debugLog.logStrings.add(
        DebugLogString(
          logTitle: "Graphql Exception",
          logsDescription: queryResult.exception?.toString() ?? "NULL",
        ),
      );

      /// Set Log color as red
      debugLog.setAsRed();
    } else {
      /// Log the Result of Graphql
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql Result",
          logsDescription:
              OnScreenDebugUtils.getMapToString(queryResult.data)));

      /// Set Log color as green
      debugLog.setAsGreen();
    }

    /// Finally Build the Ui for log
    OnScreenDebugUtils.onScreenDebugLogController.addDebugLog(debugLog);
  }

  static String correctGraphqlUrl() {
    return """
    {
      dragons {
        name
        type
      }
    }
    """;
  }

  static String wrongGraphqlUrl() {
    return """
    {
      dragons {
        name
        typeooo
      }
    }
    """;
  }

  static Future<QueryResult> _makeApiCall(
      {required ValueNotifier<GraphQLClient> graphqlClient,
      required FetchPolicy fetchPolicy,
      required String query}) async {
    return await graphqlClient.value
        .query(
      QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    )
        .timeout(const Duration(minutes: _kTimeoutInterval), onTimeout: () {
      return QueryResult(
        source: QueryResultSource.network,
        exception: OperationException(),
        parserFn: (Map<String, dynamic> data) {
          return data;
        },
      );
    });
  }
}
