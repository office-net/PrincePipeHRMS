//
//  SL_Archive.swift
//  Prince_Pipes_Newls
//
//  Created by Netcommlabs on 25/08/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class SL_Archive: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrObjleaveGetDetailsRes.arrayValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalGatePassArchivCell") as! PersonalGatePassArchivCell
        let index = indexPath.row
        cell.lblDate.text = arrObjleaveGetDetailsRes[index]["ReqNo"].stringValue
        cell.lblDateDiffrence.text = arrObjleaveGetDetailsRes[index]["Period"].stringValue
        cell.lblStatus.text = arrObjleaveGetDetailsRes[index]["RMStatus"].stringValue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "SL_Details") as! SL_Details
        vc.dodo = arrObjleaveGetDetailsRes[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoRequestToDisplay: UILabel!
    var strRequestId = "1"
    var previousMonthStr = ""
    var nextMonthStr = ""
    var arrObjleaveGetDetailsRes:JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNoRequestToDisplay.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        let PreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: nextMonth!) // string purpose I add here
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd/MM/yyyy"
        let strNextMonth = formatter.string(from: yourDate!)
        let myStringPrevious = formatter.string(from: PreviousMonth!) // string purpose I add here
        let yourDatePrevious = formatter.date(from: myStringPrevious)
        formatter.dateFormat = "dd/MM/yyyy"
        let strPreviousMonth = formatter.string(from: yourDatePrevious!)
        previousMonthStr = strPreviousMonth
        nextMonthStr = strNextMonth
        print("strNextMonth",strNextMonth)
        print("strPreviousMonth",strPreviousMonth)
        let defaults = UserDefaults.standard
        if let Language = defaults.string(forKey: "Language") {
            if Language == "English"
            {
                self.lblNoRequestToDisplay.text = "No Request To Display"
            }
            else
            {
                self.lblNoRequestToDisplay.text = "प्रदर्शित करने के लिए कोई अनुरोध नहीं है"
            }
        }
        
        SL_ArchiveRequestAPI()
        // Do any additional setup after loading the view.
    }
    
func SL_ArchiveRequestAPI()
{
    
    CustomActivityIndicator.sharedInstance.showActivityIndicator(uiView: self.view)
    var parameters:[String:Any]?
    if let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int {
        parameters = ["TokenNo":"abcHkl7900@8Uyhkj","UserID":UserID,"FromDate":previousMonthStr,"ToDate":nextMonthStr,"DateType":strRequestId,"ReqNo":""]
    }
    else{
        parameters = ["TokenNo":"abcHkl7900@8Uyhkj","UserID":"0","PlantID":"0","Year":""]
    }
    AF.request( base.url+"SL_ArchiveRequest", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseDecodable (of:JSON.self) { response in
                    switch response.result
                {
                    case .success(let Value):
                        let json:JSON = JSON(Value)
                        print(json)
                        print(response.request!)
                        print(parameters!)
                        
                        let status = json["Status"].intValue
                        
                        if status == 1 {
                            CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
                            self.arrObjleaveGetDetailsRes = json["objSLGetDataRes"]
                            DispatchQueue.main.async {
                                self.lblNoRequestToDisplay.isHidden = true
                                self.tableView.isHidden = false
                                self.tableView.reloadData()
                            }
                        }else {
                            
                            DispatchQueue.main.async {
                                CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
                                self.lblNoRequestToDisplay.isHidden = false
                                self.tableView.isHidden = true
                            }
                        }

                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                
                }
    
}
    
}
//-----------------------------------------------------//
class PersonalGatePassArchivCell: UITableViewCell {
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblDateDiffrence: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
     
    }
}

