import 'package:firbase_nextpak_demo_test/src/features/pages/auth/email_verification/page/email_verification_page.dart';
import 'package:firbase_nextpak_demo_test/src/features/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/pages/auth/login/page/login_page.dart';
import '../features/pages/auth/signup/page/signup_page.dart';
import 'route_transition.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/${AppRoute.signUp}',
    routes: [
    
      GoRoute(
        name: AppRoute.login,
        path: '/${AppRoute.login}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.signUp,
        path: '/${AppRoute.signUp}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: SignupPage(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.homePage,
        path: '/${AppRoute.homePage}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: HomePage(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.verifyEmailPage,
        path: '/${AppRoute.verifyEmailPage}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: EmailVerificationPage(),
          );
        },
      ),
    ],
  );

  static void clearAndNavigate(BuildContext context, String name) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(name);
  }
}

class AppRoute {
////AuthSection

  static const String splash = 'splash-page';
  static const String register = 'register-page';
  static const String signUp = 'signUp-page';
  static const String successfullyAccounttCreate =
      'successfullyAccounttCreate-page';
  static const String login = 'login-page';
  static const String resetPassword = 'resetPassword-page';
  static const String forgettPassword = 'forgettPassword-page';

  static const String update = 'update-page';
  static const String notii = 'notii-page';
  static const String country = 'country-page';
  static const String detail = 'detail-page';

/////////////////////////////////////////
  static const String errorPage = 'error-page';
  static const String splashScreen = 'splash-page';
  static const String welcomeScreen = 'welcomeScreen-page';
  //authScreen
  static const String addAdmin = 'addAdmin-page';
  static const String manageSubAdmin = 'manageSubAdmin-page';
  static const String editSubAdmin = 'editSubAdmin-page';
  static const String transaction = "transaction-page";
  static const String addNewExchangeRate = 'addNewExchangeRate-page';
  static const String accountInfo = 'accountInfo-page';
  static const String profilePage = 'profilePage-page';
  static const String language = 'language-page';
  static const String sendOtp = "sendOtp-page";
  static const String verifyEmailPage = 'verify-email-page';
  static const String homePage = 'homePage-page';
  static const String editAccount = 'editAccount-page';
  static const String resetOtp = 'resetOtp-page';
  static const String passwordChnagedSucessfully =
      'passwordChnagedSucessfully-page';

  //NavigationBarScreens
  static const String navigationBar = 'navigationBar-page';
  static const String searchScreen = 'searchScreen-page';
  static const String feedPage = 'Feed-page';
  static const String chatPage = 'petChat-page';
  static const String followerScreen = 'follower-page';
  static const String myProfile = 'editProfile-page';
  static const String profileMessage = 'profileMessage-page';
  static const String statusStory = 'statusStory-page';
  static const String sellerCenter = 'SellerCenter-page';

  //Categories_Screens
  //topSeller
  static const String pendingTranscation = 'pendingTranscation-page';
  static const String categoriesPage = 'categories-page';
  static const String petShopping = 'shopping-page';
  static const String petToys = 'toys-page';
  static const String petTravel = 'travel-page';
  static const String petAccessories = 'petAccessories-page';
  static const String petFood = 'petFood-page';
  static const String petHouse = 'petHouse-page';

  //PaymentScreen
  static const String orderconfirmation = 'orderconfirmation-page';
  static const String cartPage = 'cart-page';
  static const String paymentDetail = 'payemntDetail-page';
  static const String addressPage = 'checkOut-page';
  //addProducts
  static const String addProduct = 'addProduct-page';
  static const String productDetailPage = 'productDetail-page';
  static const String ratingPage = 'rating-page';
//  static const String uploadIngredient = "uploadIngredient-page";
  static const String uploadRecipe = "uploadRecipe-page";
  //MessageScreen
  static const String messagePage = "message-page";
  static const String createGroup = "createGroup-page";

  //NotificationPages  bussinessProfile
  static const String notificationPage = "notification-page";
  static const String bussinessProfile = "bussinessProfile-page";

  //setting
  static const String setting = "setting-page";
  static const String accountPage = "accountScreen-page";
  static const String membershipPage = "membership-page";
  static const String faqsPage = "faqs-page";
  static const String privcyPolicy = "privcy-page";
  static const String termsAndCondition = "termsAndCondition-page";
  static const String aboutPage = "about-page";
  static const String orderTrackingPage = "order-tracking-page";
  static const String favoritePage = "favorite-page";
  static const String languagePage = "language-page";
  static const String myOrder = "my_FOrder-page";

  //search screens
  static const String explorePage = "explore-page";

  //group chat
  static const String groupChat = 'group-chat';
  //profile
  static const String postPage = 'post-page';
  //Seller
  static const String describePage = 'describe-page';
  //SellerDashBord Pages

  static const String pendingTranscationStatement =
      'pendingTranscationStatement-page';
  static const String allpendingTranscation = 'allpendingTranscation-page';
  static const String productStatement = 'productStatement-page';
  static const String allProducts = 'allProducts-page';
  static const String customerDetail = 'customerDetail-page';
  static const String allCustomers = 'allCustomers-page';
  //OrderHistoryPages
  static const String orderHistory = 'OrderHistory-page';
  static const String quillEditor = 'quillEditor-page';
  static const String chatRequest = 'chatRequest-page';
  // ####### Mishal  Working Routes ###########

  static const String realtimeExchangePage = 'realtime-exchange-page';
  static const String addExchangeRatePage = 'add-exchange-rate-page';
  static const String getExchangeRatePage = 'get-exchange-rate-page';
  static const String convertXafToRubPage = 'convert-xaf-to-rub-page';
}
