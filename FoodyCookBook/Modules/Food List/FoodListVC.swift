//
//  FoodListVC.swift
//  FoodyCookBook
//
//  Created by Nirzar Gandhi on 08/06/21.
//

class FoodListVC: UIViewController {
    
    //MARK: - UILabel Outlet
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK: - UITextField Outlet
    @IBOutlet weak var txtSearch: UITextField!
    
    //MARK: - UICollectionView Outlet
    @IBOutlet weak var cvFoodList: UICollectionView!
    
    //MARK: - Variable Declaration
    var arrMealsList : [Meals]?
    var arrMealID = [String]()
    
    //MARK: - ViewCOntroller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        initialization()
        
        txtSearch.text = ""
        
        wsAllMealList(strSearch: "")
    }
    
    //MARK: - Initialization Method
    func initialization() {
        
        setNavigationHeader(strTitleName: "Foody CookBook")
        
        arrMealID = [String]()
        
        if let mealID : String = KeychainWrapper.standard.string(forKey: UserDefault.kMealID) {
            let arrTempMealID = mealID.split(separator: "-")
            
            for i in 0..<arrTempMealID.count {
                arrMealID.append(String(arrTempMealID[i]))
            }
        }
    }
    
    //MARK: - UIButton Action Method
    @objc func btnFavAction(_ btn: UIButton) {
        
        
        if arrMealID.contains(arrMealsList?[btn.tag].idMeal ?? "") {
            let index = arrMealID.indices(where: {$0 == arrMealsList?[btn.tag].idMeal ?? ""})
            arrMealID.remove(at: index?[0] ?? 0)
        } else {
            arrMealID.append(arrMealsList?[btn.tag].idMeal ?? "")
        }
        
        cvFoodList.reloadData()
        
        let arrTempMealID = arrMealID.joined(separator:"-")
        KeychainWrapper.standard.set("\(arrTempMealID)", forKey: UserDefault.kMealID)
        
        setUserDefault(true, key: UserDefault.kIsKeyChain)
    }
    
    //MARK: - Webservice Call Method
    func wsAllMealList(strSearch : String, isLoader : Bool = true) {
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(AlertMessage.msgNetworkConnection)
            return
        }
        
        ApiCall().get(apiUrl: "\(WebServiceURL.MealListURL)\(strSearch)", model: FoodListModal.self, isLoader: isLoader, isAPIToken: false) { (success, responseData) in
            if success, let responseData = responseData as? FoodListModal {
                self.arrMealsList = responseData.meals ?? []
                
                self.cvFoodList.reloadData()
                
                self.cvFoodList.isHidden = false
                self.lblNoData.isHidden = true
            } else {
                mainThread {
                    self.view.makeToast(AlertMessage.msgError)
                    
                    self.cvFoodList.isHidden = true
                    self.lblNoData.isHidden = false
                }
            }
        }
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource Extension
extension FoodListVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMealsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.kCellFoodList, for: indexPath) as! FoodListCVC
        
        cell.imgvFoodItem.sd_setImage(with: URL(string: arrMealsList?[indexPath.row].strMealThumb ?? ""), completed: nil)
        
        if arrMealID.contains(arrMealsList?[indexPath.row].idMeal ?? "") {
            cell.btnFav.isSelected = true
            cell.btnFav.tintColor = .appRedColor()
        } else {
            cell.btnFav.isSelected = false
            cell.btnFav.tintColor = .appRedColor()
        }
        
        cell.lblFoodName.text = arrMealsList?[indexPath.row].strMeal ?? ""
        
        cell.lblFoodCategory.text = arrMealsList?[indexPath.row].strCategory ?? ""
        
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(btnFavAction(_:)) , for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objFoodDetailVC = AllStoryBoard.Main.instantiateViewController(withIdentifier: ViewControllerName.kFoodDetailVC) as! FoodDetailVC
        objFoodDetailVC.strMealID = arrMealsList?[indexPath.row].idMeal ?? ""
        self.navigationController?.pushViewController(objFoodDetailVC, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.width/2.0 - 10, height: 235)
        return size
    }
}

//MARK: - UITextField Delegate Extension
extension FoodListVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == UIReturnKeyType.next {
            textField.superview?.superview?.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.done {
            textField.resignFirstResponder()
        }
        
        if textField == txtSearch && textField.text?.count ?? 0 > 0 {
            arrMealsList = nil
            
            wsAllMealList(strSearch: txtSearch.text ?? "")
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let strTextFieldValue: NSString = (textField.text ?? "") as NSString
        let strSearchText = strTextFieldValue.replacingCharacters(in: range, with: string)
        var isSearch = false
        
        if Int(strSearchText.count) >= 1 {
            isSearch = true
        } else if Int(strSearchText.count) == 0 {
            isSearch = true
            
            textField.text = ""
            textField.resignFirstResponder()
        }
        
        if isSearch {
            arrMealsList = nil
            
            wsAllMealList(strSearch: strSearchText, isLoader: false)
        }
        
        return true
    }
}
