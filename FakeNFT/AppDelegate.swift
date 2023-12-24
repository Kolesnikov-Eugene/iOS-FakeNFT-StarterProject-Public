import UIKit
import ProgressHUD

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        UINavigationBar.appearance().tintColor = UIColor.black
        window = UIWindow()
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()

        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorHUD = UIColor(resource: .blackDayNight)

        return true
    }
}
