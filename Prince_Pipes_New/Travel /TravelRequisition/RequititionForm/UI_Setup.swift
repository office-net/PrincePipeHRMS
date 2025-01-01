//
//  UI_Setup.swift
//  PatanjaliTMS
//
//  Created by Ankit Rana on 22/11/24.
//

import Foundation
import UIKit
import SwiftyJSON
extension RequititionFormVC
{
    

    
    
    func UiSetup()
    {
        setupTableview()
        
        view_name.isHidden = true
        Hieght_name.constant = 0
        
        View_Grade.isHidden = true
        Hieght_grade.constant = 0
        
        view_employeList.isHidden = true
        Hieght_EmployeList.constant = 0
        
        
        view_flieght_number.isHidden = true
        hieght_flieght.constant = 0
        
        view_type.isHidden = true
        hieght_type.constant = 0
        
        View_Advance.isHidden = true
        Hieght_Advance.constant = 0
        btn_Advancee.isSelected = false
        gradePicker = UIPickerView()
        gradePicker.delegate = self
        gradePicker.dataSource = self
        
        SelectTourType.delegate = self
        SelectTourType.inputView = gradePicker
        
        txt_Traveller_Type.delegate = self
        txt_Traveller_Type.inputView = gradePicker
        txt_Booked_By.delegate = self
        txt_Booked_By.inputView = gradePicker
        txt_CurrenctType.delegate = self
        txt_CurrenctType.inputView = gradePicker
        
        Destination_City.delegate = self
        Destination_City.inputView = gradePicker
        
       
        ArrivalCity.delegate = self
    
        Mode.delegate = self
        Mode.inputView = gradePicker
        _class.delegate = self
        //_class.inputView = gradePicker
        Departure_City.delegate = self
        Departure_City.inputView = gradePicker
        
        base.changeImageCalender(textField: self.txt_ToDate)
        base.changeImageCalender(textField: self.txt_FromDate)
        base.changeImageCalender(textField: Departure_Date)
        base.changeImageCalender(textField: Arrival_Date)
        base.changeImageClock(textField: Departure_Time)
        base.changeImageClock(textField: Arrival_Time)
        
        base.changeImageCalender(textField: CheckIn_Date)
        base.changeImageCalender(textField: Check_OutDate)
        base.changeImageClock(textField: CheckInTime)
        base.changeImageClock(textField: Check_OutTime)
        
        Departure_Date.delegate = self
        Departure_Time.delegate = self
        Arrival_Date.delegate = self
        Arrival_Time.delegate = self
        txt_FromDate.delegate = self
        txt_ToDate.delegate = self
        
        CheckInTime.delegate = self
        CheckIn_Date.delegate = self
        Check_OutDate.delegate = self
        Check_OutTime.delegate = self
        
        self.txt_FromDate.setInputViewDatePicker(target: self, selector: #selector(tapDoneFromDate))
        self.Departure_Time.setInputViewDateTimePicker(target: self, selector: #selector(tapDoneDepartureTime))
        self.CheckInTime.setInputViewDateTimePicker(target: self, selector: #selector(tapDoneCheck_In_Time))
        base.changeImageDropdown(textField: SelectTourType)
        base.changeImageDropdown(textField: txt_Traveller_Type)
        base.changeImageDropdown(textField: txt_grade)
        base.changeImageDropdown(textField: txt_employe_list)
        base.changeImageDropdown(textField: Departure_City)
        base.changeImageDropdown(textField: ArrivalCity)
        base.changeImageDropdown(textField: Mode)
        base.changeImageDropdown(textField: txt_Class_Type)
        base.changeImageDropdown(textField: txt_Booked_By)
        base.changeImageDropdown(textField: Destination_City)
        base.changeImageDropdown(textField: acc_Class)
        base.changeImageDropdown(textField: acc_Booked_BY)
        
        
        
        
        txt_grade.delegate = self
        txt_grade.inputView = gradePicker
        
        txt_employe_list.delegate = self
        txt_employe_list.inputView = gradePicker
        
        txt_Class_Type.delegate = self
        txt_Class_Type.inputView = gradePicker
        
        acc_Class.delegate = self
        acc_Class.inputView = gradePicker
        
        acc_Booked_BY.delegate = self
        acc_Booked_BY.inputView = gradePicker
        
        apicalling_Master(ModeId: "0")
        
        
    }
    
    func setupTableview()
    
    {
       
       
        view_AddAccomodation.isHidden = true
        Hieght_AddAccomadation.constant = 0
        
        self.tbl_TravelHistory.delegate =  self
        self.tbl_TravelHistory.dataSource =  self
        self.tbl_TravelHistory.separatorStyle = .none
        self.tbl_TravelHistory.register(UINib(nibName: "TravelHistoryCell", bundle: nil), forCellReuseIdentifier: "TravelHistoryCell")
        self.tbl2.delegate =  self
        self.tbl2.dataSource =  self
        self.tbl2.separatorStyle = .none
        self.tbl2.register(UINib(nibName: "AddAccomadationCell", bundle: nil), forCellReuseIdentifier: "AddAccomadationCell")
    }
    
    

    
    @objc func tapDoneCheck_OutTime() {
        if let datePicker = self.Check_OutTime.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2

            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "HH:mm"
            self.Check_OutTime.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.Check_OutTime.resignFirstResponder() // 2-5
    }
    
    @objc func tapDoneCheck_In_Time() {
        if let datePicker = self.CheckInTime.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2

            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "HH:mm"
            self.CheckInTime.text = dateformatter.string(from: datePicker.date)
            self.Check_OutTime.text = ""//2-4
        }
        self.CheckInTime.resignFirstResponder() // 2-5
    }
    
    @objc func tapDoneCheck_Out_Date() {
        if let datePicker = self.Check_OutDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "dd/MM/yyyy"
           self.Check_OutDate.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.Check_OutDate.resignFirstResponder() // 2-5
    }
    
    @objc func tapDoneCheckINDate() {
        if let datePicker = self.CheckIn_Date.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "dd/MM/yyyy"
           self.CheckIn_Date.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.Check_OutDate.text = ""
        self.CheckIn_Date.resignFirstResponder() // 2-5
    }
    
    
        @objc func tapDoneDepartureTime() {
            if let datePicker = self.Departure_Time.inputView as? UIDatePicker { // 2-1
                let dateformatter = DateFormatter() // 2-2
    
                dateformatter.dateStyle = .medium
                dateformatter.dateFormat = "HH:mm"
                self.Departure_Time.text = dateformatter.string(from: datePicker.date) //2-4
            }
            self.Departure_Time.resignFirstResponder() // 2-5
        }
        @objc func tapDoneArrivalTime() {
            if let datePicker = self.Arrival_Time.inputView as? UIDatePicker { // 2-1
                let dateformatter = DateFormatter() // 2-2
                dateformatter.dateStyle = .medium // 2-3
                dateformatter.dateFormat = "HH:mm"
    
                self.Arrival_Time.text = dateformatter.string(from: datePicker.date) //2-4
            }
            self.Arrival_Time.resignFirstResponder() // 2-5
        }
    
    @objc func tapDoneFromDate() {
        if let datePicker = self.txt_FromDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "dd/MM/yyyy"
           self.txt_FromDate.text = dateformatter.string(from: datePicker.date)
            txt_ToDate.text = ""
             //2-4
        }
        self.txt_FromDate.resignFirstResponder() // 2-5
    }
    
    @objc func tapDoneToDate() {
        if let datePicker = self.txt_ToDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "dd/MM/yyyy"
           self.txt_ToDate.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.txt_ToDate.resignFirstResponder() // 2-5
    }
    
    
        @objc func tapDoneDepartureDate() {
            if let datePicker = self.Departure_Date.inputView as? UIDatePicker { // 2-1
                let dateformatter = DateFormatter() // 2-2
                dateformatter.dateFormat = "dd/MM/yyyy"
               self.Departure_Date.text = dateformatter.string(from: datePicker.date) //2-4
            }
            self.Departure_Date.resignFirstResponder() // 2-5
        }
    @objc func tapDoneArrivalDate() {
        if let datePicker = self.Arrival_Date.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "dd/MM/yyyy"
           self.Arrival_Date.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.Arrival_Date.resignFirstResponder() // 2-5
    }
    
}
