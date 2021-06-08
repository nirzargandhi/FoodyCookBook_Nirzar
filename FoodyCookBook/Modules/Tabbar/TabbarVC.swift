//
//  TabbarVC.swift
//  FoodyCookBook
//
//  Created by Nirzar Gandhi on 08/06/21.
//

class TabbarVC: UITabBarController {
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    //MARK: - Initialization Method
    func initialization() {
                
        tabBar.tintColor = .white
        tabBar.barTintColor = .appBlackColor()
        
        tabBar.unselectedItemTintColor = .gray
    }
}
