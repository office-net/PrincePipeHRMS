//
//  CustomExtensions.swift
//  Iclick
//
//  Created by Mayank on 21/01/20.
//  Copyright © 2020 Mayank. All rights reserved.
//

import Foundation
import UIKit
extension UITextField
{
    enum Direction {
        case Left
        case Right
    }
    func withImage(direction: Direction, image: UIImage, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        mainView.layer.cornerRadius = 5

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        if(Direction.Left == direction){ // image left

            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right

            self.rightViewMode = .always
            self.rightView = mainView
        }

        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.5)
        self.layer.cornerRadius = 5
    }
    func setInputViewDatePicker(target: Any, selector: Selector) {
          // Create a UIDatePicker object and assign to inputView
          let screenWidth = UIScreen.main.bounds.width
          let datePicker = UIDatePicker()
          if #available(iOS 13.4, *) {
              datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
          } else {
              // Fallback on earlier versions
          }
          datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: self.frame.size.width, height: 200)//1
          datePicker.datePickerMode = .date //2
          self.inputView = datePicker //3

//        let calendar = Calendar(identifier: .gregorian)
//        let currentDate = Date()
//            var components = DateComponents()
//            components.calendar = calendar
//        components.day = +4
//
//        let maxDate = calendar.date(byAdding: components, to: currentDate)!
//        components.day = 0
//        let minDate = calendar.date(byAdding: components, to: currentDate)!
//        datePicker.minimumDate = minDate
//        datePicker.maximumDate = maxDate
          // Created a toolbar and assign it to inputAccessoryView
          let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 45.0)) //4
          let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
          let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
          let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
          toolBar.setItems([cancel, flexible, barButton], animated: false) //8
          self.inputAccessoryView = toolBar //9
      }
      
      
      
      func setInputViewDateTimePicker(target: Any, selector: Selector) {
          // Create a UIDatePicker object and assign to inputView
          let screenWidth = UIScreen.main.bounds.width
          let datePicker = UIDatePicker()//1
          
          if #available(iOS 13.4, *) {
              datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
          }
          else {
            
               }
          
          datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: self.frame.size.width, height: 200)
          datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
          datePicker.datePickerMode = .dateAndTime //2
          self.inputView = datePicker //3
          let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
          
          let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
          let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
          let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
          toolBar.setItems([cancel, flexible, barButton], animated: false) //8
          self.inputAccessoryView = toolBar //9
          
      }
      
      @objc func tapCancel() {
          self.resignFirstResponder()
      }
  
}



extension UITextField
{
    func Set_DatePicker_With_Range(target: Any, selector: Selector,FromDate:String,Todate:String) {
          // Create a UIDatePicker object and assign to inputView
          let screenWidth = UIScreen.main.bounds.width
          let datePicker = UIDatePicker()
          if #available(iOS 13.4, *) {
              datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
          } else {
              // Fallback on earlier versions
          }
          datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: self.frame.size.width, height: 200)//1
          datePicker.datePickerMode = .date //2
          self.inputView = datePicker //3
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let FromDateString = FromDate
        let ToDateString = Todate
        let minimumDate = dateFormatter.date(from: FromDateString)
        let maximumDate = dateFormatter.date(from: ToDateString)
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate  =  maximumDate

          let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 45.0)) //4
          let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
          let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
          let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
          toolBar.setItems([cancel, flexible, barButton], animated: false) //8
          self.inputAccessoryView = toolBar //9
      }
    
    func Set_DatePicker_With_From_date(target: Any, selector: Selector,FromDate:String) {
          // Create a UIDatePicker object and assign to inputView
          let screenWidth = UIScreen.main.bounds.width
          let datePicker = UIDatePicker()
          if #available(iOS 13.4, *) {
              datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
          } else {
              // Fallback on earlier versions
          }
          datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: self.frame.size.width, height: 200)//1
          datePicker.datePickerMode = .date //2
          self.inputView = datePicker //3
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let FromDateString = FromDate
    
        let minimumDate = dateFormatter.date(from: FromDateString)
      //  print(minimumDate!)
        datePicker.minimumDate = minimumDate
        
      

          let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 45.0)) //4
          let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
          let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
          let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
          toolBar.setItems([cancel, flexible, barButton], animated: false) //8
          self.inputAccessoryView = toolBar //9
      }
    
    
    func set_TimePicker_With_TimeRange(target: Any, selector: Selector, startTime: String, endTime: String) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Handle older iOS versions here if needed
            datePicker.datePickerMode = .time
        }
        
        datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: self.frame.size.width, height: 200)
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.datePickerMode = .time
        
        //let dateFormatter = DateFormatter()
        Formatter.time.defaultDate = Calendar.current.startOfDay(for: Date())
        let minimumDate = Formatter.time.date(from: startTime)!
            let maximumDate = Formatter.time.date(from: endTime)!
        datePicker.date = minimumDate
        datePicker.datePickerMode = .time
       
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        
        toolBar.setItems([cancel, flexible, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    func set_TimePicker_With_TimeRange_From(target: Any, selector: Selector, startTime: String) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Handle older iOS versions here if needed
            datePicker.datePickerMode = .time
        }
        
        datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: self.frame.size.width, height: 200)
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.datePickerMode = .time
        
        //let dateFormatter = DateFormatter()
        Formatter.time.defaultDate = Calendar.current.startOfDay(for: Date())
        let minimumDate = Formatter.time.date(from: startTime)!
        datePicker.date = minimumDate
        datePicker.datePickerMode = .time
       
        datePicker.minimumDate = minimumDate
     
        
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        
        toolBar.setItems([cancel, flexible, done], animated: false)
        self.inputAccessoryView = toolBar
    }


}
extension Date {
    
    static func datee (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
}
extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter.string(from: Date())

    }
    static func getCurrentDate2() -> String {

           let dateFormatter = DateFormatter()

           dateFormatter.dateFormat = "yyyy-MM-dd"

           return dateFormatter.string(from: Date())

       }
    static func getCurrentYear() -> String {

           let dateFormatter = DateFormatter()

           dateFormatter.dateFormat = "yyyy"

           return dateFormatter.string(from: Date())

       }
}
extension UIViewController
{
    func showAlert(message: String) {
        
        if let Language = UserDefaults.standard.string(forKey: "Language") {
           
            if Language == "English"
            {
                let alertController = UIAlertController(title: base.Title, message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                // let cancelAction = UIAlertAction(title: "", style: .cancel)
                alertController.addAction(okAction)
                //alertController.addAction(cancelAction)
                self.present(alertController, animated: true)
            }
            else
            {
                let alertController = UIAlertController(title: base.Title, message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ठीक है", style: .default)
                // let cancelAction = UIAlertAction(title: "", style: .cancel)
                alertController.addAction(okAction)
                //alertController.addAction(cancelAction)
                self.present(alertController, animated: true)
            }
        }
    
    }
    
    func showAlertWithAction(message:String){
        
        let alertController = UIAlertController(title: base.Title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: base.ok, style: UIAlertAction.Style.default) {_ in
            self.navigationController?.popViewController(animated: true)
            }
          alertController.addAction(okAction)
          self.present(alertController, animated: true, completion: nil)
      }
    
    
    func ShowAlertAutoDisable(message:String)
    {
        let alertController = UIAlertController(title: base.Title, message: message, preferredStyle: UIAlertController.Style.alert)

        present(alertController, animated: true, completion: nil)

        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
}
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
        
    }
    
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

private var __maxLengths = [UITextField: Int]()




extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    
}




extension Formatter {
    static let time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "em_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
