import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:machine_test/core/client/dio_client.dart';
import 'package:machine_test/core/constants/api_path.dart';
import 'package:machine_test/src/model/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserController extends GetxController {
  bool isLoading = false;
  List<User> userList = <User>[];
  static Dio dio = Dio();
  final inspector = DioInspector(dio);
  @override
  void onInit() {
    getUserAPICAll();
    super.onInit();
  }

  //fetch users data
  Future<void> getUserAPICAll() async {
    try {
      isLoading = true;
      update();
      final response = await inspector.send<dynamic>(
        RequestOptions(
          method: 'GET',
          path: UrlConstants.users,
        ),
      );
      if (response.statusCode == 200) {
        userList.clear();
        response.data.map((e) {
          userList.add(User.fromJson(e));
        }).toList();
        update();
      }
    } on DioException {
      rethrow;
    } finally {
      isLoading = false;
      update();
    }
  }

  //open dialer
  openPhone(String phone) async {
    String url = "tel:$phone";
    if (!await launchUrl(Uri.parse(url))) {
      const GetSnackBar(
        title: "Failed to open phone",
      );
    }
  }

  //open in mail
  openEmail(String email) async {
    String url = "mailto:email?subject=''&body=''";
    if (!await launchUrl(Uri.parse(url))) {
      const GetSnackBar(
        title: "Failed to open phone",
      );
    }
  }
}
