import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class FirebaseDynamicLinkController {
  // create dynamic link
  Future<String> craeteDynamicLink(String screenPath, int fakeId) async {
    final String url =
        "https://com.example.linking?appScreenPath=$screenPath&&id=$fakeId";

    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: "https://mustafaggm.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.example.linking",
        minimumVersion: 0,
      ),
      //       iosParameters: const IOSParameters(
      //   bundleId: "com.example.app.ios",
      //   appStoreId: "123456789",
      //   minimumVersion: "0",
      // ),

      socialMetaTagParameters: SocialMetaTagParameters(
        title: "NEW IMAGE MUSTAFA ",
        imageUrl: Uri.parse(
            "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
      ),
    );

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;

    final refLink = await link.buildShortLink(dynamicLinkParams);
    return refLink.shortUrl.toString();
  }

  // init dynamic link

  initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final refCode = instanceLink.link;
      Share.share('hello i am mustafa check this link ${refCode.data}');
    }
  }
}
