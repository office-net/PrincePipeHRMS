
//Created by Ankit Rana  on 23/08/22.


import UIKit
import SwiftyJSON

class RequititionFormVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var SelectTourType: UITextField!
    @IBOutlet weak var btn_ISAccomadation: UIButton!
    
    @IBOutlet weak var Hieght_AddAccomadation: NSLayoutConstraint!
    @IBOutlet weak var view_AddAccomodation: UIView!
    @IBOutlet weak var txt_ToDate: UITextField!
    @IBOutlet weak var txt_FromDate: UITextField!
    
    @IBOutlet weak var tbl_TravelHistory: UITableView!
    @IBOutlet weak var txt_Traveller_Type: UITextField!
    @IBOutlet weak var txt_Booked_By: UITextField!
    @IBOutlet weak var txt_Ammount: UITextField!
    
    
    @IBOutlet weak var Width_Tbl1: NSLayoutConstraint!
    var Id_Currency = ""
    @IBOutlet weak var txt_CurrenctType: UITextField!
    
    @IBOutlet weak var View_Advance: UIView!
    @IBOutlet weak var Hieght_Advance: NSLayoutConstraint!
    @IBOutlet weak var btn_Advancee: UIButton!
    
    @IBOutlet weak var Departure_Date: UITextField!
    @IBOutlet weak var Departure_Time: UITextField!
    @IBOutlet weak var Arrival_Date: UITextField!
    @IBOutlet weak var Arrival_Time: UITextField!
    @IBOutlet weak var Departure_City: UITextField!
    @IBOutlet weak var ArrivalCity: UITextField!
    @IBOutlet weak var Mode: UITextField!
    @IBOutlet weak var _class: UITextField!
    @IBOutlet weak var Traveller_Name: UITextField!
    @IBOutlet weak var Remark: UITextField!
    @IBOutlet weak var Hieght_Tbl_History: NSLayoutConstraint!
    
    
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var Hieght_Tbl_2: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var Destination_City: UITextField!
    @IBOutlet weak var Hotel_Name: UITextField!
    @IBOutlet weak var CheckIn_Date: UITextField!
    @IBOutlet weak var Check_OutDate: UITextField!
    @IBOutlet weak var CheckInTime: UITextField!
    @IBOutlet weak var Check_OutTime: UITextField!
    
    
    @IBOutlet weak var View_AddHistory: UIView!
    
    @IBOutlet weak var Purpose: UITextView!
    @IBOutlet weak var Last_Remarks: UITextView!
    
    @IBOutlet weak var view_flieght_number: UIView!
    @IBOutlet weak var hieght_flieght: NSLayoutConstraint!
    @IBOutlet weak var txt_flight_number: UITextField!
    
    
    @IBOutlet weak var view_type: UIView!
    @IBOutlet weak var hieght_type: NSLayoutConstraint!
    @IBOutlet weak var txt_Class_Type: UITextField!
    var ClassTypeID = ""
    
    @IBOutlet weak var view_name: UIView!
    @IBOutlet weak var Hieght_name: NSLayoutConstraint!
    @IBOutlet weak var txt_name: UITextField!
    
    
    @IBOutlet weak var View_Grade: UIView!
    @IBOutlet weak var Hieght_grade: NSLayoutConstraint!
    @IBOutlet weak var txt_grade: UITextField!
    var GradeID = ""
    
    @IBOutlet weak var view_employeList: UIView!
    @IBOutlet weak var Hieght_EmployeList: NSLayoutConstraint!
    @IBOutlet weak var txt_employe_list: UITextField!
    var EmployeeID = ""
    
    @IBOutlet weak var acc_Class: UITextField!
    var ACC_ClassID = ""
    @IBOutlet weak var acc_Remark: UITextField!
    
    @IBOutlet weak var acc_Booked_BY: UITextField!
    
    @IBOutlet weak var btn_Final_Choose: UIButton!
    var Acc_Booked_ID = ""
    var History_ARRAY = [[String:Any]]()
    var Accomadation_ARRAY = [[String:Any]]()
    var AccomadationJSON:JSON = []
    var HistoryJSON:JSON = []
    var IsEligible = ""
    var gradePicker: UIPickerView!
    var MasterData:JSON = []
   
   
    
    var Tour_Type_ID = "1"
    var Travellet_Type_ID = ""
    var Booked_By_ID = ""
    
    var Departure_ID = ""
    var Destination_ID = ""
    var Mode_ID = ""
    var Class_ID = ""
    
    var Accomadation_DestinatrionCity_ID = ""
    var IsAccomadation = false
    var IsAdvance = false
    var TRID = ""
    
    var Img_type_Final = ""
    var Img_String_Final = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fill Requisition Details"
        self.Width_Tbl1.constant = 1800
        
        self.UiSetup()
   }
    
    @IBAction func btn_AddTravel(_ sender: Any) {
        AddTravelHistory()
        
    }
    
    
    @IBAction func btn_Add_Accomadation(_ sender: Any) {
        AddAccomadation()
    }
    
    @IBAction func btn_IsAccomadatiom(_ sender: Any) {
        HideAndShowView()
        
    }
    
    
    @IBAction func btn_Advance(_ sender: Any) {
        if btn_Advancee.isSelected == false
        {
            View_Advance.isHidden = false
            Hieght_Advance.constant = 120
            btn_Advancee.isSelected = true
        }
        else
        {
            View_Advance.isHidden = true
            Hieght_Advance.constant = 0
            btn_Advancee.isSelected = false
            txt_Ammount.text = ""
            Id_Currency = ""
            
        }
        
        
    }
    
    
    
    
    @IBAction func btn_Submit(_ sender: Any) 
    {
        SubmitDetails()
    }
    
    @IBAction func btn_reset(_ sender: Any)
    {
        ApiSave_Submit(SaveStatus: "2")
    }
    
    
    
    @IBAction func btn_FinalAttachment(_ sender: Any)
    {
        ImagePickerHelper.shared.pickImage(from: self) { base64String, imageName in
         if let base64String = base64String, let imageName = imageName {
             self.Img_String_Final = base64String
             self.Img_type_Final = ".PNG"
             self.btn_Final_Choose.setTitle(imageName, for: .normal)
                   }
               }
        
    }
    
    
    
}















extension RequititionFormVC
{    func ApiSave_Submit(SaveStatus:String)
    {
        var IsAdvance:Bool?
        if txt_Ammount.text == ""
        {
            IsAdvance = false
        }
        else
        {
            IsAdvance = true
        }
        
        let token  = UserDefaults.standard.object(forKey: "TokenNo") as? String
          let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int
        let parameters = 
        [
            "SourceType":"3",
            "CurrencyId": Id_Currency,
            "BookedBy": Booked_By_ID,
            "FromDate": txt_FromDate.text!,
            "IsAccomodationRequired": IsAccomadation,
            "Purpose": Purpose.text ?? "",
            "Remarks": Last_Remarks.text ?? "",
            "SaveStatus": SaveStatus,
            "ToDate": txt_ToDate.text!,
            "TokenNo": token!,
            "TourType": Tour_Type_ID,
            "TravellerType": Travellet_Type_ID,
            "UserID": UserID!,
            "AccomodationData": Accomadation_ARRAY,
            "LCID": "",
            "TravelData": History_ARRAY,
            "TRID": TRID,
            "IsAdvance": IsAdvance ?? "false",
            "AdvanceAmount": txt_Ammount.text ?? "",
            "OnBeHalfEmpID": EmployeeID,
            "GRADEID": GradeID,
            "FilePathBase64":Img_String_Final,
            "FileExt":Img_type_Final
        ] as [String: Any]
        Networkmanager.postRequest(vv: self.view, remainingUrl:"Save_Requisition", parameters: parameters) { (response,data) in
            print(response)
            let Status = response["Status"].intValue
            let Msg = response["Message"].stringValue
            if Status == 1
            {
               
                if SaveStatus == "0"
                {  self.TRID = response["TRID"].stringValue
                    self.apiCalling_Request_Details()
                  }
                else
                {
                    self.showAlertWithAction(message: Msg)
                }
                self.History_ARRAY = [[String:Any]]()
                
                self.Accomadation_ARRAY = [[String:Any]]()
                self.Img_String_Final = ""
                self.Img_type_Final = ""
                self.btn_Final_Choose.setTitle("Choose Image", for: .normal)
            }
            else
            {
                self.showAlert(message: Msg)
                self.History_ARRAY = [[String:Any]]()
                
                self.Accomadation_ARRAY = [[String:Any]]()
            }
        }
    }
    
    
    
    func apiCalling_Request_Details()
    {
        var parameters:[String:Any]?
        let token  = UserDefaults.standard.object(forKey: "TokenNo") as? String
        let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int
        parameters = ["TokenNo":token!,"UserID":UserID!,"TRID":self.TRID,"RequestType":"UserView"]
        Networkmanager.postRequest(vv: self.view, remainingUrl:"Request_Details", parameters: parameters!) { (response,data) in
            
            self.Accomadation_ARRAY = [[String:Any]]()
            self.AccomadationJSON = response["AccomodationData"]
            self.History_ARRAY = [[String:Any]]()
            self.HistoryJSON = response["TravelData"]
            self.txt_FromDate.text = response["tourFromDate"].stringValue
            self.txt_ToDate.text = response["tourToDate"].stringValue
      
            
            
            
            self.txt_Traveller_Type.text = response["travellerType"].stringValue
            for i in 0..<self.MasterData["RequisitionTravelerTypeList"].count {
                if self.MasterData["RequisitionTravelerTypeList"][i]["Value"].stringValue == self.txt_Traveller_Type.text {
                    self.Travellet_Type_ID = self.MasterData["RequisitionTravelerTypeList"][i]["ID"].stringValue
                    break
                }
            }
            
            self.txt_Booked_By.text = response["bookedBy"].stringValue
            for i in 0..<self.MasterData["RequisitionTicketBookedByList"].count {
                if self.MasterData["RequisitionTicketBookedByList"][i]["Value"].stringValue == self.txt_Booked_By.text {
                    self.Booked_By_ID = self.MasterData["RequisitionTicketBookedByList"][i]["ID"].stringValue
                    break
                }
            }
            
            self.tbl2.reloadData()
            self.tbl_TravelHistory.reloadData()
            if response["AccomodationData"].isEmpty ==  false
            {
                self.btn_ISAccomadation.isSelected = true
                self.view_AddAccomodation.isHidden = false
                self.Hieght_AddAccomadation.constant = 450
                self.IsAccomadation = true
            }
            else
            {     self.btn_ISAccomadation.isSelected =  false
                self.view_AddAccomodation.isHidden = true
                self.Hieght_AddAccomadation.constant = 0
                self.IsAccomadation = false
                
            }
           
            if self.txt_Traveller_Type.text == "Self"
            {
                let UserName  = UserDefaults.standard.object(forKey: "UserName") as? String
                self.Traveller_Name.text = UserName
                self.Traveller_Name.isUserInteractionEnabled = false
              
            }
            else
            {
                self.Traveller_Name.text = ""
                self.Traveller_Name.isUserInteractionEnabled = true
            }
        }
        
    }
    
    func SubmitDetails()
    {
        if Booked_By_ID == ""
        {
            self.showAlert(message: "Please select Booked By")
        }
        else if Hieght_Advance.constant == 120 &&  txt_Ammount.text == ""
        {
            self.showAlert(message: "Please Enter Amount")
        }
        else if Hieght_Advance.constant == 120 &&  Id_Currency == ""
        {
            self.showAlert(message: "Please Select Currency Type")
        }
        else if Travellet_Type_ID == ""
        {
            self.showAlert(message: "Please select Traveller Type")
        }
        else if HistoryJSON.count == 0
        {
            self.showAlert(message: "Please Add Travel History details")
        }
        else if Purpose.text == ""
        {
            self.showAlert(message: "Please Enter Purpose Of Travel")
        }
        else if Last_Remarks.text == ""
        {
            self.showAlert(message: "Please Enter Remarks")
        }
        else
        {
            ApiSave_Submit(SaveStatus: "1")
        }
    }
    
    func AddAccomadation()
    {
        if Destination_City.text == ""
        {
            self.showAlert(message: "Please Select Destination City")
        }
        else if Hotel_Name.text == ""
        {
            self.showAlert(message: "Please Enter Hotel Name")
        }
        else if acc_Class.text == ""
        {
            self.showAlert(message: "Please Select Class Type")
        }
        else if CheckIn_Date.text == ""
        {
            self.showAlert(message: "Please select Check In date ")
        }
        else if CheckInTime.text == ""
        {
            self.showAlert(message: "Please Select Check in Time")
        }
        else if Check_OutDate.text == ""
        {
            self.showAlert(message: "Please select Check Out Date")
        }
        else if Check_OutTime.text == ""
        {
            self.showAlert(message: "Please select Check Out Time")
        }
        
        else
        {
            let dic =
            [
                "Id": "",
                "CheckInDate": CheckIn_Date.text!,
                "CheckInTime": CheckInTime.text!,
                "CheckOutDate": Check_OutDate.text!,
                "CheckOutTime": CheckInTime.text!,
                "Country": "",
                "DesCity": Destination_City.text ?? "",
                "Hotel": Hotel_Name.text!,
                "TK_BOOKED_BY": Acc_Booked_ID,
                "CLASS_TYPE": acc_Class.text ?? "",
                "ACOMMOD_REMARK": acc_Remark.text ?? ""
            ]
            self.Accomadation_ARRAY.append(dic)
            self.ApiSave_Submit(SaveStatus: "0")
            
            Destination_City.text = ""
            Hotel_Name.text = ""
            CheckIn_Date.text = ""
            CheckInTime.text = ""
            Check_OutDate.text = ""
            Check_OutTime.text = ""
            acc_Class.text = ""
            acc_Remark.text = ""
           
        }
    }
    
    
    func AddTravelHistory()
    {
        if Departure_Date.text == ""
        {
            self.showAlert(message: "Please Select Departure Date")
            return
        }
         if Departure_Time.text == ""
        {
            self.showAlert(message: "Please Select Departure Time")
             return
        }
         if Arrival_Date.text == ""
        {
            self.showAlert(message: "Please select Arrival date ")
             return
        }
         if Arrival_Time.text == ""
        {
            self.showAlert(message: "please select Arrival time ")
             return
        }
         if Departure_City.text == ""
        {
            self.showAlert(message: "Please select Departure City ")
             return
        }
         if ArrivalCity.text == ""
        {
            self.showAlert(message: "Please select Destination City")
             return
        }
         if Mode.text == ""
        {
            self.showAlert(message: "Please select Mode")
             return
        }
         if _class.text == ""
        {
            self.showAlert(message: "Please select Class")
             return
        }
        if view_type.isHidden == false && txt_Class_Type.text == ""
        {
            self.showAlert(message: "Please Select Type")
             return
        }
        
         if Traveller_Name.text == ""
        {
            self.showAlert(message: "Please Enter Traveller Name")
             return
        }
        if view_flieght_number.isHidden == false && txt_flight_number.text == ""
        {
            self.showAlert(message: "Please Enter Flight or Train Number")
             return
        }
        
        
        let dic = 
        [   "ArrDate": Arrival_Date.text!,
            "ArrTime": Arrival_Time.text!,
            "Class": _class.text!,
            "FromCountry": "",
            "DepDate": Departure_Date.text!,
            "DepTime": Departure_Time.text!,
            "ToCountry": "",
            "DepCity": Departure_City.text ?? "",
            "Remark": Remark.text ?? "",
            "Id": "",
            "ArrCity": ArrivalCity.text ?? "",
            "Mode": Mode.text!,
            "Name": txt_name.text ?? "",
            "IsEligible": IsEligible,
            "TK_BOOKED_BY": txt_Booked_By.text ?? "",
            "VEHICLE_NO": txt_flight_number.text ?? "",
            "TD_NAME": Traveller_Name.text ?? "" ,
            "TRAIN_TYPE":txt_Class_Type.text ?? ""
        ]
            self.History_ARRAY.append(dic)
            self.ApiSave_Submit(SaveStatus: "0")
            Arrival_Date.text = ""
            Arrival_Time.text = ""
            Departure_Date.text = ""
            Departure_Time.text = ""
            Mode.text = ""
            _class.text = ""
            for subview in View_AddHistory.subviews 
           {
                if let textField = subview as? UITextField
                {
                    textField.text = ""
                }
                
            }
            
        
                    
        
    }
}



//=========================================================  MASTER API CALLING ==============================================================

extension RequititionFormVC
{
    func apicalling_Master(ModeId:String)
   {     let token  = UserDefaults.standard.object(forKey: "TokenNo") as? String
       let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int
       let parameters = ["TokenNo":token!,"UTBookedType":"0","UserID":UserID!,"IS_DOMESTIC": "1","ModeId":ModeId] as [String : Any]
        Networkmanager.postRequest(vv: self.view, remainingUrl:"RequisitionMaster_List", parameters: parameters) { (response,data) in
            print("===================TrId===\(response["TRID"].stringValue)")
            let Status = response["Status"].intValue
            if Status == 1
            {
                self.MasterData = response
                self.TRID = response["TRID"].stringValue
                
              
                if self.TRID != "0"
                {
                    
                    self.txt_Traveller_Type.isUserInteractionEnabled = false
                    self.txt_FromDate.isUserInteractionEnabled = false
                    self.txt_ToDate.isUserInteractionEnabled = false
                     self.apiCalling_Request_Details()
                }
               
            }
            else
            {
                let Msg = response["Message"].stringValue
                self.showAlert(message: Msg)
            }
        }
 
    }

    
}














extension RequititionFormVC
{
    
    func HideAndShowView()
    {
        if Hieght_AddAccomadation.constant == 450
        {
            btn_ISAccomadation.isSelected =  false
            view_AddAccomodation.isHidden = true
            Hieght_AddAccomadation.constant = 0
            IsAccomadation = false
        }
        else
        {    btn_ISAccomadation.isSelected = true
            view_AddAccomodation.isHidden = false
            Hieght_AddAccomadation.constant = 450
            IsAccomadation = true
        }
    }
}



extension RequititionFormVC
{
   
func DeleteRow(ReqType:String,Id:String)
    {     let token  = UserDefaults.standard.object(forKey: "TokenNo") as? String
          let parameters = ["TokenNo":token!,"ReqType":ReqType,"Id":Id] as [String : Any]
         Networkmanager.postRequest(vv: self.view, remainingUrl:"delete_Requisition", parameters: parameters) { (response,data) in
        print(response)
             let Status = response["Status"].intValue
             if Status == 1
             {
                 let Msg = response["Message"].stringValue
                 self.showAlert(message: Msg)
                 self.apiCalling_Request_Details()
             }
             else
             {   
                 let Msg = response["Message"].stringValue
                 self.showAlert(message: Msg)
             }
         }
  
     }
    
func Eligibility(ModeId:String,ClassId:String,Tourtype:String)
    {   let token  = UserDefaults.standard.object(forKey: "TokenNo") as? String
        let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int
        let parameters =         [ "UserID": UserID!,
                                   "ModeId": ModeId,
                                   "ClassId": ClassId,
                                   "Tourtype": Tourtype,
                                   "TokenNo": token!
                                   ] as [String : Any]
         Networkmanager.postRequest(vv: self.view, remainingUrl:"GetEligibilityByMode", parameters: parameters) { (response,data) in
        print(response)
             let Status = response["Status"].intValue
             if Status == 1
             {
                 self.IsEligible = response["IsEligible"].stringValue
             }
             else
             {  
                 self.IsEligible = response["IsEligible"].stringValue
                 let Msg = response["Message"].stringValue
                 self.showAlert(message: Msg)
             }
         }
  
     }
}
