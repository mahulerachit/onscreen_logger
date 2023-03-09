import 'package:example/screens/home_screen/test_full.dart';
import 'package:flutter/material.dart';

import '../../utils/dio_helper.dart';
import '../../utils/graphql_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TestFull(),
            const Center(
                child: ElevatedButton(
                    onPressed: DioHelper.dioSuccessCall,
                    child: Text("Dio Success Call"))),
            const Center(
                child: ElevatedButton(
                    onPressed: DioHelper.dioFailureCall,
                    child: Text("Dio Failure Call"))),
            const Center(
                child: ElevatedButton(
                    onPressed: GraphqlHelper.graphqlSuccessCall,
                    child: Text("Graphql Success Call"))),
            const Center(
                child: ElevatedButton(
                    onPressed: GraphqlHelper.graphqlFailureCall,
                    child: Text("Graphql Failure Call"))),
          ],
        ),
      ),
    );
  }
}
