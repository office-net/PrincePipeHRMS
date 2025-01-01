//
//  Helper.swift
//  PatanjaliTMS
//
//  Created by Ankit Rana on 22/11/24.
//

import Foundation
import UIKit
import SwiftyJSON

extension RequititionFormVC:UIPickerViewDelegate,UIPickerViewDataSource
 {
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
             if acc_Class.isFirstResponder
            {
                return MasterData["ACCClassTYPE"].count
            }
            else if acc_Booked_BY.isFirstResponder
            {
                return MasterData["RequisitionTicketBookedByList"].count
            }
            
            else if txt_Class_Type.isFirstResponder
            {
                return MasterData["TrainClass"].count
            }
            else if txt_Traveller_Type.isFirstResponder
            {
                return MasterData["RequisitionTravelerTypeList"].count
            }
            
            else if txt_grade.isFirstResponder
            {
                return MasterData["GradeList"].count
            }
            
            else if txt_employe_list.isFirstResponder
            {
                return MasterData["EmpList"].count
            }
            
            
            else if txt_CurrenctType.isFirstResponder
            {
                return MasterData["Currency"].count
            }
            
            else if Departure_City.isFirstResponder
            {
                return MasterData["RequisitionCityList"].count
            }
            else if ArrivalCity.isFirstResponder
            {
                return MasterData["RequisitionCityList"].count
            }
            else if Destination_City.isFirstResponder
            {
                return MasterData["RequisitionCityList"].count
            }
            
            else if Mode.isFirstResponder
            {
                return MasterData["RequisitionModeList"].count
            }
            
            else if _class.isFirstResponder
            {
                return MasterData["ClassList"].count
            }
            else
            {
                return MasterData["RequisitionTicketBookedByList"].count
            }
            //RequisitionClassList
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
             if acc_Booked_BY.isFirstResponder
            {
                return MasterData["RequisitionTicketBookedByList"][row]["Value"].stringValue
            }
            else if acc_Class.isFirstResponder
            {
                return MasterData["ACCClassTYPE"][row]["Value"].stringValue
            }
            else if txt_Class_Type.isFirstResponder
            {
                return MasterData["TrainClass"][row]["Value"].stringValue
            }
            else if txt_grade.isFirstResponder
            {
                return MasterData["GradeList"][row]["Value"].stringValue
            }
            
            else if txt_employe_list.isFirstResponder
            {
                return MasterData["EmpList"][row]["Value"].stringValue
            }
            else if _class.isFirstResponder
            {
                return MasterData["ClassList"][row]["Value"].stringValue
            }
      
            else if txt_Traveller_Type.isFirstResponder
            {
                return MasterData["RequisitionTravelerTypeList"][row]["Value"].stringValue
            }
            else if txt_CurrenctType.isFirstResponder
            {
                return MasterData["Currency"][row]["Value"].stringValue
            }
            else if Departure_City.isFirstResponder
            {
                return MasterData["RequisitionCityList"][row]["Value"].stringValue
            }
            else if ArrivalCity.isFirstResponder
            {
                return  MasterData["RequisitionCityList"][row]["Value"].stringValue
            }
            else if Destination_City.isFirstResponder
            {
                return  MasterData["RequisitionCityList"][row]["Value"].stringValue
            }
            //MasterData["RequisitionModeList"][row]["Value"].stringValue
            else if Mode.isFirstResponder
            {
                return  MasterData["RequisitionModeList"][row]["Value"].stringValue
            }
            else
            {
                return MasterData["RequisitionTicketBookedByList"][row]["Value"].stringValue
            }
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
              if acc_Class.isFirstResponder
            {
                acc_Class.text =  MasterData["ACCClassTYPE"][row]["Value"].stringValue
                ACC_ClassID =  MasterData["ACCClassTYPE"][row]["ID"].stringValue
            }
            else if acc_Booked_BY.isFirstResponder
            {
                acc_Booked_BY.text =  MasterData["RequisitionTicketBookedByList"][row]["Value"].stringValue
                Acc_Booked_ID =  MasterData["RequisitionTicketBookedByList"][row]["Value"].stringValue
            }
            else if txt_Class_Type.isFirstResponder
            {
                txt_Class_Type.text =  MasterData["TrainClass"][row]["Value"].stringValue
                ClassTypeID =  MasterData["TrainClass"][row]["ID"].stringValue
            }
            else if txt_grade.isFirstResponder
            {
                txt_grade.text =  MasterData["GradeList"][row]["Value"].stringValue
                GradeID =  MasterData["GradeList"][row]["ID"].stringValue
            }
            
            else if txt_employe_list.isFirstResponder
            {
                txt_employe_list.text =  MasterData["EmpList"][row]["Value"].stringValue
                EmployeeID =  MasterData["EmpList"][row]["ID"].stringValue
            }
              
                else if txt_Traveller_Type.isFirstResponder
                {
                    txt_Traveller_Type.text =  MasterData["RequisitionTravelerTypeList"][row]["Value"].stringValue
                    Travellet_Type_ID =  MasterData["RequisitionTravelerTypeList"][row]["ID"].stringValue
                }
                
                else if txt_CurrenctType.isFirstResponder
                {
                    txt_CurrenctType.text =  MasterData["Currency"][row]["Value"].stringValue
                    Id_Currency =  MasterData["Currency"][row]["ID"].stringValue
                }
                else if Departure_City.isFirstResponder
                {
                    Departure_City.text =  MasterData["RequisitionCityList"][row]["Value"].stringValue
                    Departure_ID =  MasterData["RequisitionCityList"][row]["ID"].stringValue
                }
                else if ArrivalCity.isFirstResponder
                {
                    ArrivalCity.text =  MasterData["RequisitionCityList"][row]["Value"].stringValue
                    Destination_ID =  MasterData["RequisitionCityList"][row]["ID"].stringValue
                }
                else if Destination_City.isFirstResponder
                {
                    Destination_City.text =  MasterData["RequisitionCityList"][row]["Value"].stringValue
                    Accomadation_DestinatrionCity_ID =  MasterData["RequisitionCityList"][row]["ID"].stringValue
                }
                
                
                
                
                else if Mode.isFirstResponder
                {
                    Mode.text =  MasterData["RequisitionModeList"][row]["Value"].stringValue
                    Mode_ID =  MasterData["RequisitionModeList"][row]["ID"].stringValue
                    self.apicalling_Master(ModeId: Mode_ID)
                }
            
                
                else if _class.isFirstResponder
                {
                    _class.text =  MasterData["ClassList"][row]["Value"].stringValue
                    Class_ID =  MasterData["ClassList"][row]["ID"].stringValue
                    
                }
                else
                {
                    txt_Booked_By.text =  MasterData["RequisitionTicketBookedByList"][row]["Value"].stringValue
                    Booked_By_ID =  MasterData["RequisitionTicketBookedByList"][row]["ID"].stringValue
                }
            
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
             if textField == acc_Booked_BY
            {  if acc_Booked_BY.text == ""
                 {
                acc_Booked_BY.text =  MasterData["RequisitionTicketBookedByList"][0]["Value"].stringValue
                Acc_Booked_ID =  MasterData["RequisitionTicketBookedByList"][0]["Value"].stringValue
            }
            }
             if textField == txt_Class_Type
            {  if txt_Class_Type.text == ""
                 {
                txt_Class_Type.text =  MasterData["TrainClass"][0]["Value"].stringValue
                ClassTypeID =  MasterData["TrainClass"][0]["ID"].stringValue
                 }
            }
            if textField == acc_Class
            {  if acc_Class.text == ""
                {
                acc_Class.text =  MasterData["ACCClassTYPE"][0]["Value"].stringValue
                ACC_ClassID =  MasterData["ACCClassTYPE"][0]["ID"].stringValue
            }
            }
            
             if textField == txt_grade
            {if txt_grade.text == ""
                 {
                txt_grade.text =  MasterData["GradeList"][0]["Value"].stringValue
                GradeID =  MasterData["GradeList"][0]["ID"].stringValue
            }
            }
            
             if textField == txt_employe_list
            {  if txt_employe_list.text == ""
                 {
                txt_employe_list.text =  MasterData["EmpList"][0]["Value"].stringValue
                EmployeeID =  MasterData["EmpList"][0]["ID"].stringValue
            }
            }
            
            
            
          
         
             if textField == txt_Traveller_Type
            {   if txt_Traveller_Type.text == ""{
                txt_Traveller_Type.text =  MasterData["RequisitionTravelerTypeList"][0]["Value"].stringValue
                Travellet_Type_ID =  MasterData["RequisitionTravelerTypeList"][0]["ID"].stringValue
               
            }
    
                 if Travellet_Type_ID == "1"
                 {
                     View_Grade.isHidden = true
                     Hieght_grade.constant = 0
                     view_employeList.isHidden = true
                     Hieght_EmployeList.constant = 0
                     view_name.isHidden = false
                     Hieght_name.constant = 80
                     Traveller_Name.text = UserDefaults.standard.object(forKey: "UserName") as? String
                     txt_name.text = UserDefaults.standard.object(forKey: "UserName") as? String
                     txt_name.isUserInteractionEnabled = false
                     Traveller_Name.isUserInteractionEnabled = false
                     GradeID = ""
                     txt_grade.text = ""
                     EmployeeID = ""
                     txt_employe_list.text = ""
                     
                 }
                 else if Travellet_Type_ID == "2"
                 {    txt_name.text = ""
                     EmployeeID = ""
                     txt_employe_list.text = ""
                     View_Grade.isHidden = false
                     Hieght_grade.constant = 80
                     view_employeList.isHidden = true
                     Hieght_EmployeList.constant = 0
                     view_name.isHidden = true
                     Hieght_name.constant = 0
                     Traveller_Name.isUserInteractionEnabled = true
                     
                 }
                 else
                 {   txt_name.text = ""
                     txt_grade.text = ""
                     GradeID = ""
                     View_Grade.isHidden = true
                     Hieght_grade.constant = 0
                     view_employeList.isHidden = false
                     Hieght_EmployeList.constant = 80
                     view_name.isHidden = true
                     Hieght_name.constant = 0
                     Traveller_Name.isUserInteractionEnabled = true
                 }
            }
            
             if textField == txt_CurrenctType
            {   if txt_CurrenctType.text == ""
                 {
                txt_CurrenctType.text =  MasterData["Currency"][0]["Value"].stringValue
                Id_Currency =  MasterData["Currency"][0]["ID"].stringValue
            }
             }
            if textField == txt_Booked_By
            {
                if txt_Booked_By.text == ""
                {
                    txt_Booked_By.text =  MasterData["RequisitionTicketBookedByList"][0]["Value"].stringValue
                    Booked_By_ID =  MasterData["RequisitionTicketBookedByList"][0]["ID"].stringValue
                }
            }
             if textField == Departure_City
            {
                 if Departure_City.text == ""
                 {
                     Departure_City.text =  MasterData["RequisitionCityList"][0]["Value"].stringValue
                     Departure_ID =  MasterData["RequisitionCityList"][0]["ID"].stringValue
                 }
                 if ArrivalCity.text == Departure_City.text
                 {    ArrivalCity.text = ""
                      Departure_City.text = ""
                     self.showAlert(message: "To city and from city should not be same.")
                     
                 }
            }
             if textField == ArrivalCity
            {   if ArrivalCity.text == ""
                 {
                ArrivalCity.text =  MasterData["RequisitionCityList"][0]["Value"].stringValue
                Destination_ID =  MasterData["RequisitionCityList"][0]["ID"].stringValue
                  }
                 if ArrivalCity.text == Departure_City.text
                 {   ArrivalCity.text = ""
                     Departure_City.text = ""
                     self.showAlert(message: "To city and from city should not be same.")
                 }
            }
            if textField == Destination_City
            { if Destination_City.text == ""
                {
                Destination_City.text =  MasterData["RequisitionCityList"][0]["Value"].stringValue
                Accomadation_DestinatrionCity_ID =  MasterData["RequisitionCityList"][0]["ID"].stringValue
            }}
            
            if textField == Mode
            {
                if Mode.text == ""
                {
                    Mode.text =  MasterData["RequisitionModeList"][0]["Value"].stringValue
                    Mode_ID =  MasterData["RequisitionModeList"][0]["ID"].stringValue
                    _class.text = ""
                   apicalling_Master(ModeId: Mode_ID)
                 
                    
                    view_flieght_number.isHidden = Mode_ID == "1" || Mode_ID == "2" ? false:true
                    hieght_flieght.constant = Mode_ID == "1" || Mode_ID == "2"  ? 80:0
                    
                    view_type.isHidden =  Mode_ID == "2" ? false:true
                    hieght_type.constant = Mode_ID == "2"  ? 80:0
                    
                    
                }
                else
                {  _class.text = ""
                    apicalling_Master(ModeId: Mode_ID)
                    
                    view_flieght_number.isHidden = Mode_ID == "1" || Mode_ID == "2" ? false:true
                    hieght_flieght.constant = Mode_ID == "1" || Mode_ID == "2"  ? 80:0
                    
                    view_type.isHidden =  Mode_ID == "2" ? false:true
                    hieght_type.constant = Mode_ID == "2"  ? 80:0
                    
                    
                }
                
            }
            
             if  textField == _class
            {   if SelectTourType.text == "" || Mode.text == ""
                 {
                
                  }
                 else
                 {
                     if _class.text == ""
                     {
                         _class.text =  MasterData["ClassList"][0]["Value"].stringValue
                         Class_ID =  MasterData["ClassList"][0]["ID"].stringValue
                           self.Eligibility(ModeId: Mode_ID, ClassId: Class_ID, Tourtype:Tour_Type_ID)
                     }
                     else
                     {
                          self.Eligibility(ModeId: Mode_ID, ClassId: Class_ID, Tourtype:Tour_Type_ID)
                     }
                 }
             }
          
        }
    
    
    }





//MARK: TEXTFIELD  STARTING FUNCTION =======================================================================

extension  RequititionFormVC
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
     
        if textField == ArrivalCity
        {
            if Departure_ID == "-1" || Departure_City.text == ""
            {
                self.showAlert(message: "Please Select Departure City First")
            }
            else
            {
                
                ArrivalCity.inputView = gradePicker
            }
        }
        
        if textField == _class
        {
            if Mode_ID == "-1" || Mode.text == "" || SelectTourType.text == ""
            {
                self.showAlert(message: "Please Select Mode & Tour Type First")
            }
            else
            {
                
                _class.inputView = gradePicker
            }
        }
        
        if textField == txt_ToDate
         {
            if txt_FromDate.text == ""
            {
                self.showAlert(message: "Please Enter From Date first")
            }
            else
            {
                self.txt_ToDate.Set_DatePicker_With_From_date(target: self, selector: #selector(tapDoneToDate), FromDate: self.txt_FromDate.text!)
                self.Departure_Date.text = ""
                self.Arrival_Date.text = ""
            }
            
            
            
        }
        
       if textField == Departure_Date
        {
           if txt_FromDate.text == "" || txt_ToDate.text == ""
           {
               self.showAlert(message: "Please Enter From Date and To Date first")
           }
           else
           {
               Departure_Date.Set_DatePicker_With_Range(target: self, selector: #selector(tapDoneDepartureDate), FromDate: txt_FromDate.text!, Todate: txt_ToDate.text!)
               txt_FromDate.isUserInteractionEnabled = false
               txt_ToDate.isUserInteractionEnabled = false
              
           } }
        if textField == Arrival_Date
        {
            if Departure_Date.text == ""
            {
                self.showAlert(message: "Please select Departure Date First")
            }
            else
            {
                Arrival_Date.Set_DatePicker_With_Range(target: self, selector: #selector(tapDoneArrivalDate), FromDate: Departure_Date.text!, Todate: txt_ToDate.text!)
            }
        }
        
        if textField == Arrival_Time
        {
            if Departure_Time.text == ""
            {
                self.showAlert(message: "Please Enter Departure Time First")
            }
            else
            {
                Arrival_Time.set_TimePicker_With_TimeRange(target: self, selector: #selector(tapDoneArrivalTime), startTime: Departure_Time.text!, endTime: "23:59")
            }
        }
        
        
        if textField == CheckIn_Date
        {
           if txt_FromDate.text == "" || txt_ToDate.text == ""
           {
               self.showAlert(message: "Please Enter From Date and To Date first")
           }
           else
           {
               CheckIn_Date.Set_DatePicker_With_Range(target: self, selector: #selector(tapDoneCheckINDate), FromDate: txt_FromDate.text!, Todate: txt_ToDate.text!)
               txt_FromDate.isUserInteractionEnabled = false
               txt_ToDate.isUserInteractionEnabled = false
           }
            
        }
        
        
        if textField == Check_OutDate
        {
           if CheckIn_Date.text == ""
           {
               self.showAlert(message: "Please Enter Check-IN Date first")
           }
           else
           {
               Check_OutDate.Set_DatePicker_With_Range(target: self, selector: #selector(tapDoneCheck_Out_Date), FromDate: CheckIn_Date.text!, Todate: txt_ToDate.text!)
           } }
        
        if textField == Check_OutTime
        {
            if CheckInTime.text == ""
            {
                self.showAlert(message: "Please Enter Check In Time First")
            }
            else
            {
                Check_OutTime.set_TimePicker_With_TimeRange(target: self, selector: #selector(tapDoneCheck_OutTime), startTime: CheckInTime.text!, endTime: "23:59")
            }
        }
        
  
         
    }
}
