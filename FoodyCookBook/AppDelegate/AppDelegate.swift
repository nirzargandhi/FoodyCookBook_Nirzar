//
//  AppDelegate.swift
//  FoodyCookBook
//
//  Created by Nirzar Gandhi on 08/06/21.
//

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Variable Declaration
    var window: UIWindow?
    var navhomeViewController : UINavigationController?
    
    //MARK: - AppDelegate Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if !isKeyPresentInUserDefaults(key: UserDefault.kIsKeyChain) {
            clearUserDefaultKeyChainData()
        }
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        Utility().setTabbarVC()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        UIPasteboard.general.items = [[String: Any]()]
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.window?.addSubview(splashView)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        splashView.removeFromSuperview()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    //MARK: - Lazy SplashView For Data Leakage Protection
    lazy var splashView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
//        imageView.image = #imageLiteral(resourceName: "splash")
        return imageView
    }()
}

