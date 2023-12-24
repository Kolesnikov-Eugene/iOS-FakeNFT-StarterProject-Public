import UIKit
import ProgressHUD

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
vadinur/profile


develop
        UINavigationBar.appearance().tintColor = UIColor.black
        window = UIWindow()
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
 vadinur/profile

        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorHUD = UIColor(resource: .blackDayNight)
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorHUD = UIColor(resource: .blackDayNight)
        ProgressHUD.colorAnimation = UIColor(resource: .lightDayNight
                                             develop
        return true
    }
}
