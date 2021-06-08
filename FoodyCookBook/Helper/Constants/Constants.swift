//
//  Utility.swift


//MARK: - Colors
extension UIColor {
    
    class func appBlackColor() -> UIColor { return UIColor(named: "AppBlack")! }
    class func appBlueColor() -> UIColor { return UIColor(named: "AppBlue")! }
    class func appBorderColor() -> UIColor { return UIColor(named: "AppBorder")! }
    class func appDarkRedColor() -> UIColor { return UIColor(named: "AppDarkRed")! }
    class func appGrayColor() -> UIColor { return UIColor(named: "AppGray")! }
    class func appGreenColor() -> UIColor { return UIColor(named: "AppGreen")! }
    class func appLightBlackColor() -> UIColor { return UIColor(named: "AppLightBlack")! }
    class func appLightGreenColor() -> UIColor { return UIColor(named: "AppLightGreen")! }
    class func appRedColor() -> UIColor { return UIColor(named: "AppRed")! }
    class func appSideTopBlack() -> UIColor { return UIColor(named: "AppSideTopBlack")! }
    class func appYellowColor() -> UIColor { return UIColor(named: "AppYellow")! }
}

// MARK: - Global
enum GlobalConstants {
    
    static let appName    = Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

//MARK: - StoryBoard Identifier's
enum AllStoryBoard {
    
    static let Main = UIStoryboard(name: "Main", bundle: nil)
}

//MARK: - ViewController Names
enum ViewControllerName {
    
    static let kTabbarVC = "TabbarVC"
    static let kFoodListVC = "FoodListVC"
    static let kFavouriteRecipesVC = "FavouriteRecipesVC"
    static let kFoodDetailVC = "FoodDetailVC"
}

//MARK: - Cell Identifiers
enum CellIdentifiers {
    
    static let kCellFoodList = "CellFoodList"
    static let kCellFavouriteRecipes = "CellFavouriteRecipes"
}


//MARK: - Message's
enum AlertMessage {
    
    //In Progress Message
    static let msgComingSoon = "Coming soon"
    
    //Internet Connection Message
    static let msgNetworkConnection = "You are not connected to internet. Please connect and try again"
    
    //Camera, Images and ALbums Related Messages
    static let msgPhotoLibraryPermission = "Please enable access for photos from Privacy Settings"
    static let msgCameraPermission = "Please enable camera access from Privacy Settings"
    static let msgNoCamera = "Device has no camera"
    static let msgImageSaveIssue = "Photo is unable to save in your local storage. Please check storage or try after some time"
    static let msgSelectPhoto = "Please select photo"
    
    //Error
    static let msgError = "Something went wrong. Please try after sometime"
    
    //Validation Messages
    static let msgFullName = "Please enter name"
    static let msgValidFullName = "Name must contain atleast 3 characters and maximum 30 characters"
    
    static let msgFirstName = "Please enter first name"
    static let msgValidFName = "First name must contain atleast 2 characters and maximum 15 characters"
    
    static let msgLastName = "Please enter last name"
    static let msgValidLName = "Last name must contain atleast 2 characters and maximum 15 characters"
    
    static let msgPassword = "Please enter password"
    static let msgPasswordCharacter = "Password must contain atleast 8 characters and maximum 15 characters"
    static let msgValidPassword = "Password should contain atleast one uppercase letter, one lowercase letter, one digit and one special character with minimum eight character length."
        
    static let msgEmail = "Please enter email"
    static let msgValidEmail = "Please enter valid email"
    
    static let msgContactNumber = "Please enter contact detail"
    static let msgContactNumberCharacter = "Contact details cannot be less than 10 digits"
    
    static let msgDOB = "Please enter date of birth"
    
    static let msgNewPassword = "Please enter new password"
    static let msgNewPasswordCharacter = "New password must contain atleast 8 characters and maximum 15 characters"
    
    static let msgConfirmPassword = "Please enter confirm password"
    static let msgConfirmPasswordCharacter = "Confirm password must contain atleast 8 characters and maximum 15 characters"
    static let msgValidConfirmPassword = "Confirm password should contain atleast one uppercase letter, one lowercase letter, one digit and one special character with minimum eight character length."
    
    static let msgCNPassword = "Please enter confirm new password"
    static let msgCNPasswordCharacter = "Confirm new password must contain atleast 8 characters and maximum 15 characters"
    
    static let msgPasswordMatch = "Password and confirm new password should be same. Please check it"
    static let msgSspacePassword = "Please remove whitespace from password"
    
    static let msgAgree = "Please select terms and conditions"
    
    //Register Message
    static let msgRegisterSuccess = "Sign Up is successful. Please login and start creating your Skitz"
    
    //Block User Pop up Message
    static let msgBlockUser = "Once you block the user, you’ll not be able to see each others profile or posts"
    static let msgUnBlockUser = "User has been unblocked"
    
    //Report Pop Up Message
    static let msgAddToReport = "Are you sure you want to Report an Abuse?"
    static let msgRemoveFromReport = "Are you sure you want to remove from Abuse?"
    
    //General Delete Message
    static let msgGeneralDelete = "Are you sure you want to delete"
    
    //Logout Message
    static let msgLogout = "Are you sure you want to log out from the application?"
}

//MARK: - Web Service URLs
enum WebServiceURL {
    
    static let mainURL = "https://www.themealdb.com/api/json/v1/1/"
        
    static let MealListURL = mainURL + "search.php?s="
    static let MealDetailURL = mainURL + "lookup.php?i="
}

//MARK: - Web Service Parameters
enum WebServiceParameter {
    
    static let pName = "name"
}

//MARK: - UserDefault
enum UserDefault {
    
    static let kMealID = "meal_id"
    static let kAPIToken = "api_token"
    static let kIsKeyChain = "isKeyChain"
}

//MARK: - Constants
struct Constants {
    
    //MARK: - Device Type
    enum UIUserInterfaceIdiom : Int {
        
        case Unspecified
        case Phone
        case Pad
    }
    
    //MARK: - Screen Size
    struct ScreenSize {
        
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
}

//MARK: - DateTime Format
enum DateAndTimeFormatString {
    
    static let strDateFormate_YYYYMMddhhmmss = "yyyy-MM-dd HH:mm:ss"
    static let strDateFormate_ddMMyyyy = "dd-MM-yyyy"
    static let strDateFormate_MMDDYYYY = "MM-dd-YYYY"
    static let strDateFormate_MMMddYYYY = "MMM dd, yyyy"
}

