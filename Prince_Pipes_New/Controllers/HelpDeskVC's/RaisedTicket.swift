//
//  RaisedTicket.swift
//  NewOffNet
//
//  Created by Netcomm Labs on 04/10/21.
//

import UIKit
import SwiftyJSON

class RaisedTicket: UIViewController,UITabBarDelegate,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var arrHelpDeskDetailsList:JSON = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HelpDesk_GetDetailsAPI()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHelpDeskDetailsList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell", for: indexPath)as! tableviewcell
        let dic = arrHelpDeskDetailsList[indexPath.row]
        
        cell.lblTicket.text = dic["TicketNo"].stringValue
        cell.lblDepartMent.text = dic["Department"].stringValue
        cell.lblCategory.text = dic["Category"].stringValue
        cell.lblSubCateGory.text = dic["SubCategory"].stringValue
        cell.lblStatus.text = dic["Status"].stringValue
        cell.lbl_Date.text = dic["SubmissionDate"].stringValue
        cell.lbl_Priority.text = "Priority :" +  dic["Priority"].stringValue
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  storyboard?.instantiateViewController(withIdentifier: "HelpDeskViewRequestVC")as! HelpDeskViewRequestVC
        let dic = arrHelpDeskDetailsList[indexPath.row]
        vc.RequestId = dic["ReqID"].stringValue
        vc.isfromRaisedTicket = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func HelpDesk_GetDetailsAPI()   {
       
        var parameters:[String:Any]?
        if let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int {
            parameters = ["TokenNo":"abcHkl7900@8Uyhkj","UserID":UserID,"StatusID":"%","Priority":"%"]
        }
        else{
            parameters = ["TokenNo":"abcHkl7900@8Uyhkj","UserID":"0"]
        }
        Networkmanager.postRequest(vv: self.view, remainingUrl:"HelpDesk_GetDetails", parameters: parameters!) { (response,data) in
            let status = response["Status"].intValue
            if status == 1 {
                
                self.arrHelpDeskDetailsList = response["HelpDeskDetailsList"]
                  self.tableView.reloadData()
                }
            else {
                let msg = response["Message"].stringValue
                self.showAlertWithAction(message: msg)
            }
            
        }
        
        
        
    }
}
class tableviewcell:UITableViewCell
{
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSubCateGory: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDepartMent: UILabel!
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Priority: UILabel!
}

