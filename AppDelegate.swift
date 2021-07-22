import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let initialViewController = ViewController()
        
        window.rootViewController = initialViewController
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }

}

