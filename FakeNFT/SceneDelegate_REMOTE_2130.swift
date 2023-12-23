import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let shownOnboardingEarlier = UserDefaults.standard.bool(forKey: "shownOnboardingEarlier")
            if shownOnboardingEarlier {
                window.rootViewController = TabBarController()
            } else {
                window.rootViewController = OnboardingPageViewController(transitionStyle: .scroll,
                                                                         navigationOrientation: .horizontal)
            }
            window.makeKeyAndVisible()
            self.window = window
        }
    }
}