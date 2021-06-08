//
//  Utility.swift

//MARK: - Variable Declaration
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
var hud:MBProgressHUD = MBProgressHUD()

//MARK: - Utility
struct Utility {
    
    //MARK: - Show/Hide Loader Method
    func showLoader(isShowLabel : Bool = false) {
        DispatchQueue.main.async {
            hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            UIApplication.shared.keyWindow?.addSubview(hud)
            hud.mode = .indeterminate
            if isShowLabel {
                hud.label.text = "Loading photos..."
            }
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            hud.removeFromSuperview()
        }
    }
    
    //MARK: - Array To JSONString Method
    func arrayToJSONString(from object : Any) -> String? {
        if JSONSerialization.isValidJSONObject(object) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: object, options: [])
                if let string = String(data: jsonData, encoding: String.Encoding.utf8)?.replacingOccurrences(of: "\\/", with: "/") {
                    return string as String
                }
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    //MARK: - WSFail Response Method
    func wsFailResponseMessage(responseData : AnyObject) -> String {
        
        var strResponseData = String()
        
        if let tempResponseData = responseData as? String {
            strResponseData = tempResponseData
        }
        
        if(isObjectNotNil(object: strResponseData as AnyObject)) && strResponseData != "" {
            return responseData as! String
        } else {
            return "Something went wrong, please try after some time"
        }
    }
    
    //MARK: - Check Null or Nil Object
    func isObjectNotNil(object:AnyObject!) -> Bool {
        if let _:AnyObject = object {
            return true
        }
        
        return false
    }
    
    //MARK: - Set Tabbar VC Method
    func setTabbarVC() {
        let objTabbarVC = AllStoryBoard.Main.instantiateViewController(withIdentifier: ViewControllerName.kTabbarVC) as! TabbarVC
        let navigationViewController = UINavigationController(rootViewController: objTabbarVC)
        GlobalConstants.appDelegate.window?.rootViewController = navigationViewController
        GlobalConstants.appDelegate.window?.makeKeyAndVisible()
    }
    
    //MARK: - Set SideMenu Method
    func setSideMenu() {
        
        var objSlideMenuVC = UIViewController()
        
        SideMenuManager.default.menuShadowOpacity = 0
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
        SideMenuManager.default.menuPushStyle = .popWhenPossible
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuAllowPushOfSameClassTwice = false
        SideMenuManager.default.menuWidth = Constants.ScreenSize.SCREEN_WIDTH * (3/4)
        SideMenuManager.default.menuAnimationBackgroundColor = .clear
        SideMenuManager.default.menuAlwaysAnimate = true
        SideMenuManager.default.menuEnableSwipeGestures = false
        
//        objSlideMenuVC = AllStoryBoard.Main.instantiateViewController(withIdentifier: ViewControllerName.kSideMenuVC)
//        let navSlideMenuVC = UISideMenuNavigationController(rootViewController: objSlideMenuVC)
//        navSlideMenuVC.isNavigationBarHidden = true
//        SideMenuManager.default.menuLeftNavigationController = navSlideMenuVC as UISideMenuNavigationController?
        
//        setDashboardVC()
    }
    
    //MARK: -  Date Formatter Method
    func datetimeFormatter(strFormat : String, isTimeZoneUTC : Bool) -> DateFormatter {
        var dateFormatter: DateFormatter?
        if dateFormatter == nil {
            dateFormatter = DateFormatter()
            dateFormatter?.timeZone = isTimeZoneUTC ? TimeZone(abbreviation: "UTC") : TimeZone.current
            dateFormatter?.dateFormat = strFormat
        }
        return dateFormatter!
    }
    
    //MARK: - Height For View Method
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}

//MARK: - Color Functions
func setLblComponents(lblColor : UIColor , lblFont : String , lblBgColor : UIColor , lblFontSize : String , component : UILabel) {
    
    component.textColor = lblBgColor
    component.backgroundColor = lblBgColor
}

//MARK: - DispatchQueue
func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

func mainThread(_ completion: @escaping () -> ()) {
    DispatchQueue.main.async {
        completion()
    }
}

//userInteractive
//userInitiated
//default
//utility
//background
//unspecified
func backgroundThread(_ qos: DispatchQoS.QoSClass = .background , completion: @escaping () -> ()) {
    DispatchQueue.global(qos:qos).async {
        completion()
    }
}
// MARK: - Platform
struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

//MARK: - Get Document Directory Path Method
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

//MARK: - Write Data in Text File Method
func writeDataToFile(strData : String) {
    
    do {
        let urlFile = getDocumentsDirectory().appendingPathComponent("LogFile.txt")
        try strData.appendLineToURL(fileURL: urlFile as URL)
        let _ = try String(contentsOf: urlFile as URL, encoding: String.Encoding.utf8)
    } catch {
        print("Could not write to file")
    }
}

//MARK: - Trim String
func trimString(string : NSString) -> NSString {
    return string.trimmingCharacters(in: NSCharacterSet.whitespaces) as NSString
}

//MARK: - UIButton Corner Radius
func cornerLeftButton(btn : UIButton) -> UIButton {
    
    let path = UIBezierPath(roundedRect:btn.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize.init(width: 5, height: 5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    btn.layer.mask = maskLayer
    
    return btn
}

func cornerRightButton(btn : UIButton) -> UIButton {
    
    let path = UIBezierPath(roundedRect:btn.bounds, byRoundingCorners:[.topRight, .bottomRight], cornerRadii: CGSize.init(width: 5, height: 5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    btn.layer.mask = maskLayer
    
    return btn
}

//MARK: - UITextField Corner Radius
func cornerLeftTextField(textfield : UITextField) -> UITextField {
    
    let path = UIBezierPath(roundedRect:textfield.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize.init(width: 2.5, height: 2.5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    textfield.layer.mask = maskLayer
    
    return textfield
}

//MARK: - UserDefault Methods
func setUserDefault<T>(_ object : T  , key : String) {
    let defaults = UserDefaults.standard
    defaults.set(object, forKey: key)
    UserDefaults.standard.synchronize()
}

func getUserDefault(_ key: String) -> AnyObject? {
    let defaults = UserDefaults.standard
    
    if let name = defaults.value(forKey: key){
        return name as AnyObject?
    }
    return nil
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

//MARK: - Image Upload WebService Methods
func generateBoundaryString() -> String{
    return "Boundary-\(UUID().uuidString)"
}

//MARK: - String to Dictionary Method
func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

//MARK: - Save Iamge to Document Directory Method
func saveImage(data: Data) -> URL? {
    
    let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
    do {
        let targetURL = tempDirectoryURL.appendingPathComponent("Image.jpeg")
        try data.write(to: targetURL)
        return targetURL
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

//MARK: - Logout Method
func logOutMethod(isWalkTroughDone : Bool) {

    clearUserDefaultKeyChainData()
    
    clearVariableDeclaration()
}

//MARK: - Clear UserDefault & KeyChain Data Method
func clearUserDefaultKeyChainData() {
    
    KeychainWrapper.standard.removeObject(forKey: UserDefault.kMealID)
    KeychainWrapper.standard.removeObject(forKey: UserDefault.kAPIToken)
    
    UserDefaults.standard.removeObject(forKey: UserDefault.kIsKeyChain)
    UserDefaults.standard.synchronize()
}

//MARK: - Clear Variable Declaration Method
func clearVariableDeclaration() {
}

//MARK: - Hide IQKeyboard Method
func hideIQKeyboard() {
    IQKeyboardManager.shared.resignFirstResponder()
}

//MARK: - String to Image Method
func stringToImage(strImage : String?) -> UIImage? {
    if strImage != "" {
        if let data = try? Data(contentsOf: URL(string: strImage!)!) {
            return UIImage(data: data)
        }
    }
    return nil
}

//MARK: - Make Attributed String Method
func makeAttributedString(strTitle : String, strValue : String, colorValue : UIColor? = .black, isValueStringBold : Bool? = false) -> NSAttributedString {
    
    let attributeTitle = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.init(name: "Metropolis-Bold", size: 13)]
    
    let attributeValue = [NSAttributedString.Key.foregroundColor: colorValue, NSAttributedString.Key.font: isValueStringBold ?? false ? UIFont.init(name: "Metropolis-Bold", size: 13) : UIFont.init(name: "Metropolis-Regular", size: 13)]

    let strTitle = NSMutableAttributedString(string: strTitle, attributes: attributeTitle as [NSAttributedString.Key : Any])
    let strValue = NSMutableAttributedString(string: strValue, attributes: attributeValue as [NSAttributedString.Key : Any])

    let strFinalAttributed = NSMutableAttributedString()

    strFinalAttributed.append(strTitle)
    strFinalAttributed.append(strValue)
    
    return strFinalAttributed
}

//MARK: - Notification Enable/Disable Check Method
func isNotificationEnabled(completion:@escaping (_ enabled:Bool)->()){
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings: UNNotificationSettings) in
            let status =  (settings.authorizationStatus == .authorized)
            completion(status)
        })
    } else {
        if let status = UIApplication.shared.currentUserNotificationSettings?.types{
            let status = status.rawValue != UIUserNotificationType(rawValue: 0).rawValue
            completion(status)
        }else{
            completion(false)
        }
    }
}
