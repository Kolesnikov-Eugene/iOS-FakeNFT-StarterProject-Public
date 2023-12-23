import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

<<<<<<< HEAD
    func scene(_: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {}
=======
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
>>>>>>> 05985f48a6956abe56e5a88d9e95632a2b474f24
}
