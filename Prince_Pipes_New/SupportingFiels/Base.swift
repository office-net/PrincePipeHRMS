//
//  Base.swift
//  Maruti TMS
//
//  Created by Netcommlabs on 22/09/22.
//


import Foundation
import UIKit
class base
{
    static var Token = ""
    static var Title = ""
    static var ok = ""
    static var cancel = ""
    static var yes = ""
    static var alertname = Title
    static let url = "http://hrms.princepipes.com/MobileAPI/AppServices.svc/"
    //"http://182.72.156.154/MobileAPI/AppServices.svc/"
    //https://kalstree.officenet.in/MobileAPI/AppServices.svc/
    
   // "https://kailashhospitaluat.officenet.in/MobileAPI/AppServices.svc/"

    ///http://192.168.0.18:7108
    ///#colorLiteral(red: 0.9294117647, green: 0.1960784314, blue: 0.2156862745, alpha: 1)
    static let secondcolor = UIColor.darkGray
    static let firstcolor = #colorLiteral(red: 0.9294117647, green: 0.1960784314, blue: 0.2156862745, alpha: 1)


    static func changeImageCalender(textField:UITextField)
    {
        if let myImage = UIImage(named: "calendar")
        {
            
            textField.withImage(direction: .Left, image: myImage, colorBorder: UIColor.clear)
        }
    }
    static func changeImageClock(textField:UITextField)
    {
        if let myImage = UIImage(named: "wallclock")
        {
            
            textField.withImage(direction: .Left, image: myImage, colorBorder: UIColor.clear)
        }
    }
    static func getCurrentTime() -> String {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let time = "\(hour):\(minutes):\(seconds)"
        return time
        
    }
    
}
class CustomActivityIndicator {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    // Singleton Instance
    static let sharedInstance = CustomActivityIndicator()
    private init() {}
    
    
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = #colorLiteral(red: 0.007843137255, green: 0.4039215686, blue: 0.6941176471, alpha: 0.3447798295)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width:40.0, height: 40.0)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        
        activityIndicator.color = base.firstcolor
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    
    
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
        
    }
    
}


class Gradientbutton: UIButton {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let color1 = base.firstcolor
        let color2 = base.secondcolor
        gradientLayer.colors = [color1.cgColor,color2.cgColor]
    }
}
class statusView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let color1 = base.firstcolor
        let color2 = base.secondcolor
        gradientLayer.colors = [color1.cgColor,color2.cgColor]
    }
}

class Validation {
    static func validateName(name: String) ->Bool {
        
        let nameRegex = "^\\w{3,18}$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    static func validaPhoneNumber(phoneNumber: String) -> Bool {
        let PHONE_REGEX = "^[7-9][0-9]{9}$";
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
    static func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    static func validatePassword(password: String) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
    static func validateAnyOtherTextField(otherField: String) -> Bool {
        let otherRegexString = "^[a-z]{1,10}$+^[a-z]$+^[a-z'\\-]{2,20}$+^[a-z0-9'.\\-\\s]{2,20}$+^(?=\\P{Ll}*\\p{Ll})(?=\\P{Lu}*\\p{Lu})(?=\\P{N}*\\p{N})(?=[\\p{L}\\p{N}]*[^\\p{L}\\p{N}])[\\s\\S]{8,}$"
        let trimmedString = otherField.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", otherRegexString)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}
