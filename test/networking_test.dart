import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_log/service/networking.dart';


class MockClient extends Mock implements http.Client {

  MockClient(Function function);
}



void main(){
  test("Testing the network call", () async{
    final networkHelper = NetworkHelper();
    networkHelper.client = MockClient((request) async {
      final mapJson = {'id':'12345678' };
      return http.Response(json.encode(mapJson), 200);
    });
    var data = await networkHelper.getUsers();
    expect(data.id, '12345678');
  });
}
