//
//  ColorChange.swift
//  Medizone
//
//  Created by nilomi on 19/12/18.
//  Copyright © 2018 nilomi. All rights reserved.
//


func colorChange(view : UIView){
    // let allSubviews = view.allSubViewsOf(type: UIView.self)
    //    let allLabels : [UILabel] = view.allSubViewsOf(type: UILabel.self)
    //    changeComponentValues(lblArr: allLabels)
    //    let allViews : [UIView] = view.allSubViewsOf(type: UIView.self)
    
    //    changeComponentValues(viewArr: allViews)
    let allBtn : [UIButton] = view.allSubViewsOf(type: UIButton.self)
    changeAllBtnTintColor(btnArr: allBtn)
    //    changeComponentButtons(btnArr: allBtn , bgColor: UIColor.black, titleColor: UIColor.white, font: UIFont.systemFont(ofSize: 17), tintColor: UIColor.black)
    
    //    let allTxtFld : [UITextField] = view.allSubViewsOf(type: UITextField.self)
    //    changeTxtFld(txtArr: allTxtFld)
    
}


func changeTxtFld (txtArr : [UITextField]){
    for txtfld in txtArr {
        txtfld.changeTxtFieldAttrs(placeHolderColor: UIColor.black, borderWidth: 0.5, borderColor: UIColor.darkGray, textColor: UIColor.lightGray, bgColor: UIColor.white, font: UIFont.systemFont(ofSize: 15), strPlaceholder: nil)
    }
}

func changeComponentValues (lblArr : [UILabel]){
    for lbl in lblArr {
        lbl.changeLabelAttributes(fontColor: UIColor.black, font: UIFont(name: "Mishafi", size: lbl.font.pointSize), bgColor: UIColor.white)
    }
}

func changeComponentValues (viewArr : [UIView]){
    print(viewArr.count)
    
    for v in viewArr {
        if( type(of: v) == UIView.self){
            v.changeViewAttributes(bgColor: UIColor.white, borderWidth: nil, borderColor: nil)
        }
    }
}

func changeAllBtnAttributes (btnArr : [UIButton] , bgColor : UIColor, titleColor : UIColor, font : UIFont? ,  tintColor : UIColor?){
    for btn in btnArr {
        btn.changeBtnAttributes(bgColor: bgColor, titleColor: titleColor, font: font, tintColor: tintColor, strText: nil)
    }
}

func changeAllBtnTintColor (btnArr : [UIButton]){
    for btn in btnArr {
        btn.setTintColor(UIColor.red)
    }
}

func overrideFontSize(intDefaultFontSize : Int, strBuilderFlySize : String?) -> CGFloat {
    
    return CGFloat(intDefaultFontSize)
}

//MARK: changing attributes
extension UIButton {
    func changeBtnAttributes(bgColor : UIColor?, borderColor : UIColor = .clear, titleColor : UIColor?, font : UIFont? ,  tintColor : UIColor?, strText : String?)  {
        
        //font else
        /*else {
         self.titleLabel?.font = UIFont(name: Global.shared.wholeAppFont, size: (self.titleLabel?.font.pointSize) ?? 15)
         }*/
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
        
        if borderColor != nil {
            self.borderColor = borderColor
        }
        
        if titleColor != nil {
            self.setTitleColor(titleColor, for: .normal)
        }
        
        if(font != nil) {
            self.titleLabel?.font = font
        }
        
        if tintColor != nil {
            self.tintColor = tintColor
        }
        
        if strText != nil {
            self.setTitle(strText, for: .normal)
        }
    }
    
    func setTintColor(_ color : UIColor)  {
        self.tintColor = color
    }
    
    func applyButtonGradient(colors : [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    var regular: UIFont { return withWeight(.regular) }
    
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

extension UITextField {
    func changeTxtFieldAttrs(placeHolderColor : UIColor?, borderWidth : CGFloat? , borderColor : UIColor?, textColor : UIColor?, bgColor : UIColor? , font : UIFont? ,strPlaceholder : String? )  {
        
        if strPlaceholder != nil {
            self.placeholder = strPlaceholder
        }
        if placeHolderColor != nil {
            self.placeHolderColor = placeHolderColor?.withAlphaComponent(0.65)
        }
        if borderWidth != nil {
            self.borderWidth = borderWidth!
        }
        if borderColor != nil {
            self.borderColor = borderColor
        }
        if textColor != nil {
            self.textColor = textColor
        }
        if font != nil {
            self.font = font
        }
        if backgroundColor != nil {
            self.backgroundColor = bgColor
        }
    }
}

extension UITextView {
    func changeTxtViewAttrs(borderWidth : CGFloat? , borderColor : UIColor?, textColor : UIColor?, bgColor : UIColor? , font : UIFont?)  {
        
        if borderWidth != nil {
            self.borderWidth = borderWidth ?? 0
        }
        if borderColor != nil {
            self.borderColor = borderColor
        }
        if textColor != nil {
            self.textColor = textColor
        }
        if font != nil {
            self.font = font
        }
        if backgroundColor != nil {
            self.backgroundColor = bgColor
        }
    }
}

extension UILabel {
    
    func changeLabelAttributes( fontColor : UIColor? , font : UIFont? , bgColor : UIColor? )  {
        
        if fontColor != nil {
            self.textColor = fontColor
        }
        
        if font != nil {
            self.font = font
        }
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
    }
}

extension UIView {
    
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }
    
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
    func changeViewAttributes( bgColor : UIColor? , borderWidth : CGFloat? , borderColor : UIColor? )  {
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
        
        if borderWidth != nil {
            self.borderWidth = borderWidth!
        }
        
        if borderColor != nil {
            self.borderColor = borderColor
        }
    }
    
    func applyViewGradient(colors : [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyViewGradienBorder(colors : [CGColor]) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: frame.size)
        gradient.colors = colors
        
        let shape = CAShapeLayer()
        shape.lineWidth = 5
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        layer.insertSublayer(gradient, at: 0)
    }
}


class GradientLabel: UILabel {
    var gradientColors: [CGColor] = []

    override func drawText(in rect: CGRect) {
        if let gradientColor = drawGradientColor(in: rect, colors: gradientColors) {
            self.textColor = gradientColor
        }
        super.drawText(in: rect)
    }

    private func drawGradientColor(in rect: CGRect, colors: [CGColor]) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = rect.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else { return nil }

        let context = UIGraphicsGetCurrentContext()
        context?.drawLinearGradient(gradient,
                                    start: CGPoint.zero,
                                    end: CGPoint(x: size.width, y: 0),
                                    options: [])
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        return UIColor(patternImage: image)
    }
}
extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
