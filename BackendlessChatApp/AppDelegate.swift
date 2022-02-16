
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let APP_ID = "5E6B0ABC-5022-0756-FF6B-9EBDDF263B00"
    private let API_KEY = "C1FE35F6-9FCC-464A-B84A-21958286D443"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Backendless.sharedInstance()?.hostURL = "http://api.backendless.com"
        Backendless.sharedInstance()?.initApp(APP_ID, apiKey: API_KEY)
        return true
        
    }
}
