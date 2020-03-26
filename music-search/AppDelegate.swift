import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MainViewController()
        let navVC = UINavigationController(rootViewController: vc)
        if #available(iOS 13.0, *) {
            navVC.overrideUserInterfaceStyle = .light
        }
        navVC.modalPresentationStyle = .fullScreen
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }
}

