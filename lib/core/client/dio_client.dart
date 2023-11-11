import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class DioInspector {
  final Dio _dio;

  DioInspector(this._dio);

  Future<Response<T>> send<T>(RequestOptions options) async {
    try {
      final response = await _dio.request<T>(options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            method: options.method,
            headers: options.headers,
          ));

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        GetSnackBar(
            title: "Error Occured",
            message:
                e.response?.data['message'] ?? "Opps something went wrong");
      }
      return Future.error(e);
    }
  }
}
