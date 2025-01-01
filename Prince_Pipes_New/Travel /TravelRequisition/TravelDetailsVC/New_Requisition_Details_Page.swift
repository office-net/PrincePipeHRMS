//
//  New_Requisition_Details_Page.swift
//  PatanjaliTMS
//
//  Created by Ankit Rana on 27/11/24.
//

import UIKit
import SwiftyJSON

class New_Requisition_Details_Page: UIViewController {
    
    @IBOutlet weak var empCode:UITextField!
    @IBOutlet weak var Name:UITextField!
    @IBOutlet weak var Department:UITextField!
    @IBOutlet weak var Location:UITextField!
    @IBOutlet weak var Desigination:UITextField!
    @IBOutlet weak var grade:UITextField!
    @IBOutlet weak var CostCenter:UITextField!
    @IBOutlet weak var Request_date: UILabel!
    @IBOutlet weak var tour_Type: UITextField!
    @IBOutlet weak var Traveler_Type: UITextField!
    @IBOutlet weak var traveler_Name: UITextField!
    @IBOutlet weak var from_date: UITextField!
    @IBOutlet weak var To_date: UITextField!
    @IBOutlet weak var tbl_Travel: UITableView!
    @IBOutlet weak var Width_Travel: NSLayoutConstraint!
    @IBOutlet weak var Hieght_Travel: NSLayoutConstraint!
    @IBOutlet weak var view_Travel_Edit: UIView!
    
    @IBOutlet weak var Hieght_Acc: NSLayoutConstraint!
    @IBOutlet weak var tbl_acc: UITableView!
    @IBOutlet weak var Width_Acc: NSLayoutConstraint!
    @IBOutlet weak var View_Acc_Edit: UIView!
    
    
    @IBOutlet weak var Hieght_Tbl_Boked: NSLayoutConstraint!
    @IBOutlet weak var tbl_booked: UITableView!
    @IBOutlet weak var width_tbl_booked: NSLayoutConstraint!
    
    @IBOutlet weak var view_Doc: UIView!
    @IBOutlet weak var View_action: UIView!
    
    @IBOutlet weak var Advance_Amount: UITextField!
    @IBOutlet weak var Currency: UITextField!
    @IBOutlet weak var Approvd_Amount_Status: UITextField!
    @IBOutlet weak var Purpose_of_Travel: UITextField!
    @IBOutlet weak var Remarks: UITextField!
    
    @IBOutlet weak var Rm_Status: UILabel!
    @IBOutlet weak var Rm_Date: UILabel!
    @IBOutlet weak var Rm_Remark: UILabel!
    @IBOutlet weak var RM_View: UIView!
    @IBOutlet weak var Rm_Hieght: NSLayoutConstraint!
    
    
    @IBOutlet weak var HOD_Status: UILabel!
    @IBOutlet weak var HOD_Date: UILabel!
    @IBOutlet weak var HOD_Remark: UILabel!
    @IBOutlet weak var HOD_View: UIView!
    @IBOutlet weak var HOD_Hieght: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var TD_Status: UILabel!
    @IBOutlet weak var TD_Date: UILabel!
    @IBOutlet weak var TD_Remark: UILabel!
    @IBOutlet weak var TD_View: UIView!
    @IBOutlet weak var TD_Hieght: NSLayoutConstraint!
    
 
    @IBOutlet weak var Finance_Status: UILabel!
    @IBOutlet weak var Finance_Date: UILabel!
    @IBOutlet weak var Finance_Remark: UILabel!
    @IBOutlet weak var Finance_View: UIView!
    @IBOutlet weak var Finance_Hieght: NSLayoutConstraint!
    
    
    @IBOutlet weak var Approve: UIButton!
    @IBOutlet weak var DiSAPPROVE: UIButton!
    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var REVERT: UIButton!
    
    
    @IBOutlet weak var txt_Remark: UITextField!
    @IBOutlet weak var Hieght_Remark: NSLayoutConstraint!

    @IBOutlet weak var App_Amount: UITextField!
    @IBOutlet weak var Hieght_App_Amount: NSLayoutConstraint!
    
    
    @IBOutlet weak var View_Attachment: UIStackView!
    @IBOutlet weak var Hieght_Attachment: NSLayoutConstraint!
    
    @IBOutlet weak var Acco_Details: UILabel!
    
    
    var IsFrom = ""
    var trID = ""
    var HistoryJSON:JSON = []
    var AccomadationJSON:JSON = []
    var BookTicketDetail:JSON = []
    var imgString = ""
    var imgType = ""
    var GetData:JSON = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GetDeatails(Type: IsFrom, TRID: trID)
        tbl_Travel.delegate = self
        tbl_Travel.dataSource = self
        Width_Travel.constant = 1700
        view_Travel_Edit.isHidden = true
        tbl_acc.delegate = self
        tbl_acc.dataSource = self
        Width_Acc.constant = 1200
        View_Acc_Edit.isHidden = true
        self.tbl_booked.delegate = self
        self.tbl_booked.dataSource = self
        width_tbl_booked.constant = 1700
      
    }
    
    @IBAction func View_Doc(_ sender: Any) {
        let imaepath =  GetData["FILE_PATH"].stringValue
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "WebViewController")as! WebViewController
        secondVC.urlString = imaepath
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    
    @IBAction func btn_Approve(_ sender: Any) {
        self.APiAction(SaveStatus: "1")
    }
    
    @IBAction func btn_DisApprove(_ sender: Any) {
        if txt_Remark.text == ""
        {
            self.showAlert(message: "Please Fill Remarks!")
        }
        else
        {
            self.APiAction(SaveStatus: "2")
        }
    }
    
    
    
    
    @IBAction func btn_Revert(_ sender: Any)
    {
        self.APiAction(SaveStatus: "0")
    }
    
    
    @IBAction func Cancel(_ sender: Any) {
        self.APiAction(SaveStatus: "3")
    }
    
    func APiAction(SaveStatus:String)
    {
        var parameters:[String:Any]?
        let token  = UserDefaults.standard.object(forKey: "TokenNo") as? String
        let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int
        parameters = ["TokenNo":token!,"UserID":UserID!,"TRID":self.trID,"Remarks":txt_Remark.text ?? "","SaveStatus":SaveStatus,"APPAMOUNT":App_Amount.text ?? ""]
        Networkmanager.postRequest(vv: self.view, remainingUrl:"Update_Status", parameters: parameters!) { (response,data) in
            let Status = response["Status"].intValue
            let msg  = response["Message"].stringValue
            if Status == 1
            {
                self.showAlertWithAction(message: msg)
            }
            else
            {
                self.showAlert(message: msg)
            }
            
            
        }
    }
   

}


//MARK: API GET DETAILS OF REQUEST CALLING ===============================

extension New_Requisition_Details_Page
{
    func GetDeatails(Type:String,TRID:String)
    {
        var parameters:[String:Any]?
        let token  = UserDefaults.standard.object(forKey: "TokenNo") as? String
        let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int
        parameters = ["TokenNo":token!,"UserID":UserID!,"TRID":TRID,"RequestType":Type]
        Networkmanager.postRequest(vv: self.view, remainingUrl:"Request_Details", parameters: parameters!) { (response,data) in
            if response["Status"].intValue == 1
            {   self.GetData = response
                self.SetValues(response: response)
                self.HistoryJSON = response["TravelData"]
                self.tbl_Travel.reloadData()
                self.AccomadationJSON = response["AccomodationData"]
                self.tbl_acc.reloadData()
               
                if response["TDStatus"].stringValue != "Pending " || response["IsUploadTicketSection"].boolValue == true
                {
                    self.BookTicketDetail = response["BookTicketDetail"]
                    self.tbl_booked.reloadData()
                }
                else
                {
                    self.Hieght_Tbl_Boked.constant = 0
                    self.tbl_booked.isHidden = true
                }
                
            }
            else
            {
                self.showAlertWithAction(message: response["Message"].stringValue)
            }
        }
    }
}








//MARK: Func set details on textfields ===============================


extension New_Requisition_Details_Page
{
    func SetValues(response:JSON)
    {
        //MARK:  USER DEATLS
        self.title = "Request No. (\(response["reqno"].stringValue))"
        self.Name.text = response["emplyeeName"].stringValue
        self.empCode.text = response["empCode"].stringValue
        self.Department.text = response["department"].stringValue
        self.Location.text = response["location"].stringValue
        self.Desigination.text = response["designation"].stringValue
        self.grade.text = response["Grade"].stringValue
        self.CostCenter.text = response["COSTCENTER"].stringValue
        self.Acco_Details.text = response["ACCOMMODATION"].stringValue
        
        //MARK:  Travel DEATLS
        self.Request_date.text =  "Requested Date : " + response["requestedDate"].stringValue
        self.tour_Type.text = response["travellerType"].stringValue
        self.Traveler_Type.text = response["location"].stringValue
        self.traveler_Name.text = response["TravelDetailName"].stringValue
        self.from_date.text = response["tourFromDate"].stringValue
        self.To_date.text = response["tourToDate"].stringValue
        
        
        //MARK:  Travel DEATLS & Advance Amount
        self.Advance_Amount.text = response["ADVANCE_AMOUNT"].stringValue
        self.Approvd_Amount_Status.text = response["ADVANCEAPPStatus"].stringValue
        self.Currency.text = response["CURRENCY"].stringValue
        self.Purpose_of_Travel.text = response["Purposeoftravel"].stringValue
        self.Remarks.text = response["PurposeofRemark"].stringValue
        
        
        //MARK:  Travel Approval Detailss=============================
        let DaTA = response
        Rm_Status.text = DaTA["RMStatus"].stringValue
        Rm_Date.text = DaTA["RMDate"].stringValue
        Rm_Remark.text = DaTA["RMRemarks"].stringValue
        RM_View.isHidden = DaTA["RMStatus"].stringValue == "" || DaTA["RMStatus"].stringValue == "NA"
        Rm_Hieght.constant = DaTA["RMStatus"].stringValue == "" || DaTA["RMStatus"].stringValue == "NA" ? 0:90
        
        
        TD_Status.text = DaTA["TDStatus"].stringValue
        TD_Date.text = DaTA["TDDate"].stringValue
        TD_Remark.text = DaTA["TDRemarks"].stringValue
        TD_View.isHidden = DaTA["TDStatus"].stringValue == "" || DaTA["TDStatus"].stringValue == "NA"
        TD_Hieght.constant = DaTA["TDStatus"].stringValue == "" || DaTA["TDStatus"].stringValue == "NA" ? 0:90
        
        HOD_Status.text = DaTA["hodStatus"].stringValue
        HOD_Date.text = DaTA["hodDate"].stringValue
        HOD_Remark.text = DaTA["hodRemarks"].stringValue
        HOD_View.isHidden = DaTA["hodStatus"].stringValue == "" || DaTA["hodStatus"].stringValue == "NA"
        HOD_Hieght.constant = DaTA["hodStatus"].stringValue == "" || DaTA["hodStatus"].stringValue == "NA" ? 0:90
        
        
        Finance_Status.text = DaTA["financeStatus"].stringValue
        Finance_Date.text = DaTA["financeDate"].stringValue
        Finance_Remark.text = DaTA["financeRemarks"].stringValue
        Finance_View.isHidden = DaTA["financeStatus"].stringValue == "" || DaTA["financeStatus"].stringValue == "NA"
        Finance_Hieght.constant = DaTA["financeStatus"].stringValue == "" || DaTA["financeStatus"].stringValue == "NA" ? 0:90
        
        //MARK:  Travel Button Hide And Show =============================
        self.Approve.isHidden = response["IsApproveButton"].stringValue == "false"
        self.DiSAPPROVE.isHidden = response["IsDisApproveButton"].stringValue == "false"
        self.REVERT.isHidden = response["IsRevertButton"].stringValue == "false"
        self.Cancel.isHidden = response["IsCancelButtonVisable"].stringValue == "false"
        
        //MARK:  Travel Remarks and Approval Amount =============================
        self.txt_Remark.isHidden = self.Approve.isHidden == false || self.DiSAPPROVE.isHidden == false || self.REVERT.isHidden == false || self.Cancel.isHidden == false ? false:true
        self.Hieght_Remark.constant = self.Approve.isHidden == false || self.DiSAPPROVE.isHidden == false || self.REVERT.isHidden == false || self.Cancel.isHidden == false ? 40:0
        self.App_Amount.isHidden = response["IsADVAMTEdit"].boolValue == false ? true:false
        self.Hieght_App_Amount.constant = response["IsADVAMTEdit"].boolValue == false ? 0:40
        self.view_Doc.isHidden = response["FILE_PATH"].stringValue == ""
        self.Hieght_Attachment.constant = response["FILE_PATH"].stringValue == "" ? 0:55
        
    }
}



//MARK:  ===============================TableView DataSource===============================


extension New_Requisition_Details_Page:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbl_acc
        {  if AccomadationJSON.count == 0
            {
                 Hieght_Acc.constant = 0
             }
            else
            {
                Hieght_Acc.constant = CGFloat(35 * AccomadationJSON.count) + 40
            }
            return AccomadationJSON.count
        }
        else if tableView == tbl_booked
        {
            self.Hieght_Tbl_Boked.constant = CGFloat((BookTicketDetail.count) * 35) + 30
            return BookTicketDetail.count
        }
        else
        {
            Hieght_Travel.constant = CGFloat(35 * HistoryJSON.count) + 40
            return HistoryJSON.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl_acc
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAccomadationCell", for: indexPath)as! AddAccomadationCell
            cell.HotelName.text = AccomadationJSON[indexPath.row]["Hotel"].stringValue
            cell.CheckInDate.text = AccomadationJSON[indexPath.row]["CheckInDate"].stringValue
            cell.CheckInTime.text = AccomadationJSON[indexPath.row]["CheckInTime"].stringValue
            cell.CheckOutDate.text = AccomadationJSON[indexPath.row]["CheckOutDate"].stringValue
            cell.CheckOutTime.text = AccomadationJSON[indexPath.row]["CheckOutTime"].stringValue
            cell.class_type.text = AccomadationJSON[indexPath.row]["CLASS_TYPE"].stringValue
            cell.bookedby.text = AccomadationJSON[indexPath.row]["TK_BOOKED_BY"].stringValue
            cell.remarks.text = AccomadationJSON[indexPath.row]["ACOMMOD_REMARK"].stringValue
            cell.DestinationCity.text =  AccomadationJSON[indexPath.row]["DesCity"].stringValue
            cell.txt_View.isHidden = true
            return cell
        }
        else if tableView == tbl_booked
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Booked_Ticket_Cell", for: indexPath) as! Booked_Ticket_Cell
            cell.Departure_Date.text = BookTicketDetail[indexPath.row]["DepartureDate"].stringValue
            cell.Departure_Time.text = BookTicketDetail[indexPath.row]["DepartureTime"].stringValue
            cell.Departure_City.text = BookTicketDetail[indexPath.row]["DepartureCity"].stringValue
            cell.Destination_Date.text = BookTicketDetail[indexPath.row]["DestinationDate"].stringValue
            cell.Destination_Time.text = BookTicketDetail[indexPath.row]["DestinationTime"].stringValue
            cell.Destination_City.text = BookTicketDetail[indexPath.row]["DestinationCity"].stringValue
            cell.amount.text = BookTicketDetail[indexPath.row]["Amount"].stringValue
            cell.booking_Date.text = BookTicketDetail[indexPath.row]["BookingDate"].stringValue
            cell.pnr.text = BookTicketDetail[indexPath.row]["PNRNO"].stringValue
            cell.btn_View_Image.tag = indexPath.row
            cell.btn_View_Image.isHidden =  BookTicketDetail[indexPath.row]["UploadTicket"].stringValue == ""
            cell.btn_View_Image.addTarget(self, action: #selector(Btn_View_Image), for: .touchUpInside)
            cell.btn_Choose_Image.tag = indexPath.row
            cell.btn_Choose_Image.addTarget(self, action: #selector(Btn_Chose_Image), for: .touchUpInside)
            cell.btn_UploadTicket.tag = indexPath.row
            cell.btn_UploadTicket.addTarget(self, action: #selector(Btn_Upload_Tickte), for: .touchUpInside)
            cell.btn_Delete_Ticket.tag = indexPath.row
            cell.btn_Delete_Ticket.addTarget(self, action: #selector(Btn_Delete_Ticket), for: .touchUpInside)
            base.changeImageCalender(textField: cell.booking_Date)
            cell.booking_Date.isUserInteractionEnabled = GetData["IsUploadTicketSection"].boolValue
            cell.pnr.isUserInteractionEnabled = GetData["IsUploadTicketSection"].boolValue
            cell.amount.isUserInteractionEnabled = GetData["IsUploadTicketSection"].boolValue
            cell.view_Doc.isHidden = GetData["IsUploadTicketSection"].boolValue == true ? false:true
            cell.View_action.isHidden = GetData["IsUploadTicketSection"].boolValue == true ? false:true
            self.view_Doc.isHidden = GetData["IsUploadTicketSection"].boolValue == true ? false:true
            self.View_action.isHidden = GetData["IsUploadTicketSection"].boolValue == true ? false:true
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelHistoryCell", for: indexPath)as! TravelHistoryCell
            cell.txtDeparturedate.text = HistoryJSON[indexPath.row]["DepDate"].stringValue
            cell.txtDepartureTime.text = HistoryJSON[indexPath.row]["DepTime"].stringValue
            cell.txtArrivaldate.text = HistoryJSON[indexPath.row]["ArrDate"].stringValue
            cell.txtArrivalTime.text = HistoryJSON[indexPath.row]["ArrTime"].stringValue
            cell.txtDeparturePlace.text =  HistoryJSON[indexPath.row]["DepCity"].stringValue
            cell.txtDestinationPlace.text =  HistoryJSON[indexPath.row]["ArrCity"].stringValue
            cell.txtSelectMode.text = HistoryJSON[indexPath.row]["Mode"].stringValue
            cell.txtSelectClass.text = HistoryJSON[indexPath.row]["Class"].stringValue
            cell.txtTravellerName.text = HistoryJSON[indexPath.row]["TD_NAME"].stringValue
            cell.txtRemarks.text = HistoryJSON[indexPath.row]["Remark"].stringValue
            cell.txt_Type.text = HistoryJSON[indexPath.row]["TRAIN_TYPE"].stringValue
            cell.txt_BookedBY.text = HistoryJSON[indexPath.row]["TK_BOOKED_BY"].stringValue
            cell.txt_Flight_number.text = HistoryJSON[indexPath.row]["VEHICLE_NO"].stringValue
            let color = HistoryJSON[indexPath.row]["IsEligible"].stringValue
            if color == "No"
            {
                for i in 0..<cell.stackView.subviews.count {
                    cell.stackView.subviews[i].backgroundColor = UIColor.yellow
                }
                
            }
            else
            {
                for i in 0..<cell.stackView.subviews.count {
                    cell.stackView.subviews[i].backgroundColor = UIColor.lightGray
                }
            }
            cell.txt_View.isHidden = true
            
            return cell
        }
    }
    
    @objc func Btn_Upload_Tickte(Senser:UIButton) {
        let ID = BookTicketDetail[Senser.tag]["ID"].stringValue
        let indexPath = IndexPath(row:Senser.tag, section: 0)
        guard let cell = tbl_booked.cellForRow(at:indexPath) as? Booked_Ticket_Cell else {
            print("Cell not found at row \(indexPath)")
               return
           }
        self.API_Upload_Delete_Ticket(Action: "1", ID: ID, AMOUNT: cell.amount.text ?? "", BOOKING_DATE: cell.booking_Date.text ?? "", PNR_NO: cell.pnr.text ?? "")
        cell.btn_Choose_Image.setTitle("Choose File", for: .normal)
        self.imgType = ""
        self.imgString = ""
       }
    
    @objc func Btn_Delete_Ticket(Senser:UIButton) {
       
        self.API_Upload_Delete_Ticket(Action: "2", ID: BookTicketDetail[Senser.tag]["ID"].stringValue, AMOUNT: "", BOOKING_DATE: "", PNR_NO: "")
       }
    
    @objc func Btn_View_Image(Senser:UIButton) {
        let imaepath =  BookTicketDetail[Senser.tag]["UploadTicket"].stringValue
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "WebViewController")as! WebViewController
        secondVC.urlString = imaepath
        self.navigationController?.pushViewController(secondVC, animated: true)
       }
    
    @objc func Btn_Chose_Image(Senser:UIButton) {
        
        ImagePickerHelper.shared.pickImage(from: self) { base64String, imageName in
         if let base64String = base64String, let imageName = imageName {
             self.imgString = base64String
             self.imgType = ".PNG"
             print("===========\(self.imgString)")
             Senser.setTitle(imageName, for: .normal)
                   }
               }
       
       }
    
    
    func API_Upload_Delete_Ticket(Action:String,ID:String,AMOUNT:String,BOOKING_DATE:String,PNR_NO:String)
    {
        
        let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int
        let parameters = ["Action": Action,"ID": ID, "AMOUNT": AMOUNT, "BOOKING_DATE": BOOKING_DATE, "PNR_NO": PNR_NO, "FileEXT": imgType, "UserID": UserID!, "TokenNo": "abcHkl7900@8Uyhkj","FileStringBase64":imgString] as [String : Any]
        Networkmanager.postRequest(vv: self.view, remainingUrl:"UploadTiketDetail", parameters: parameters) { (response,data) in
            if response["Status"].intValue == 1
            {
                self.showAlert(message:response["Message"].stringValue)
                self.GetDeatails(Type: self.IsFrom, TRID: self.trID)
            }
            else
            {
                self.showAlert(message:response["Message"].stringValue)
            }
        }
        
    }
   
}




class Booked_Ticket_Cell: UITableViewCell {
    
    @IBOutlet weak var Departure_Date: UILabel!
    @IBOutlet weak var Departure_Time: UILabel!
    @IBOutlet weak var Departure_City: UILabel!
    
    @IBOutlet weak var Destination_Date: UILabel!
    @IBOutlet weak var Destination_Time: UILabel!
    @IBOutlet weak var Destination_City: UILabel!
    
    @IBOutlet weak var btn_UploadTicket: UIButton!
    @IBOutlet weak var btn_Delete_Ticket: UIButton!
    
    @IBOutlet weak var booking_Date: UITextField!
    @IBOutlet weak var pnr: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var btn_Choose_Image: UIButton!
    @IBOutlet weak var btn_View_Image: UIButton!
    @IBOutlet weak var view_Doc: UIView!
    @IBOutlet weak var View_action: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.booking_Date.setInputViewDatePicker(target: self, selector: #selector(tapDoneFromDate))
    }
    
    @objc func tapDoneFromDate() {
        if let datePicker = self.booking_Date.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "dd/MM/yyyy"
           self.booking_Date.text = dateformatter.string(from: datePicker.date)
          
        }
        self.booking_Date.resignFirstResponder() // 2-5
    }
}
