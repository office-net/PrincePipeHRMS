//
//  HomeVC.swift
//  NewOffNet
//
//  Created by Netcomm Labs on 01/10/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import SPPermissions
import SemiModalViewController
import SDWebImage
import SideMenu



protocol Birthday
{
    func btnBaddy(tag:Int)
}
protocol newjoiner
{
    func btnNewjoiner(tag:Int)
}
class HomeVC: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,Birthday,newjoiner, reloadData{
    @IBOutlet weak var btnpunch: UIButton!
    
    
    
    
    
    
    func ab() {
        
        getinOutstatus()
        getdetailsApi()
    }

    
    var x = 1
    var imgaray:JSON = []
    var timer = Timer()
    var counter = 0
    var counter2 = 0
    var counter3 = 0
    var birthdayData:JSON = []
    var newjoineeData:JSON = []
    @IBOutlet weak var collectionViewNewJoine: UICollectionView!
    @IBOutlet weak var collectionViewBirthDay: UICollectionView!
    @IBOutlet weak var c2: NSLayoutConstraint!
    @IBOutlet weak var c1: NSLayoutConstraint!
    @IBOutlet weak var vv2_Hieght: NSLayoutConstraint!
    @IBOutlet weak var vv1_Hieght: NSLayoutConstraint!
    
    
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    
    
    
    
    @IBOutlet weak var lbl_OutTime: UILabel!
    @IBOutlet weak var lbl_inOut: UILabel!
    @IBOutlet weak var banner_Hieght: NSLayoutConstraint!
    @IBOutlet weak var lbl_intTime: UILabel!
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let locationManager = CLLocationManager()
    
    //++++++++++++++++++++++++HindiLable_______________________
    @IBOutlet weak var TitlePunchInOut:UILabel!
    @IBOutlet weak var TitlePunchIn:UILabel!
    @IBOutlet weak var TitlePunchOut:UILabel!
    @IBOutlet weak var TitleLeaveAndReg:UILabel!
    @IBOutlet weak var TitleLeave:UILabel!
    @IBOutlet weak var TitleCompOff:UILabel!
    @IBOutlet weak var TitleHolidayList:UILabel!
    @IBOutlet weak var Titleregularsation:UILabel!
    @IBOutlet weak var TitleManagement:UILabel!
    @IBOutlet weak var TitleDirectory:UILabel!
    @IBOutlet weak var TitleAttendance:UILabel!
    @IBOutlet weak var TitleMyTeam:UILabel!
    @IBOutlet weak var TitleGallery:UILabel!
    @IBOutlet weak var TitleAnniversary:UILabel!
    @IBOutlet weak var TitleNotes:UILabel!
    @IBOutlet weak var TitleSuggestion:UILabel!
    @IBOutlet weak var titleMyRequest: UIButton!
    @IBOutlet weak var title_MyApprovals: Gradientbutton!
    @IBOutlet weak var lbl_NoBirthday: UILabel!
    @IBOutlet weak var lbl_NoNewJoinee: UILabel!
    @IBOutlet weak var titleNewJoine: UILabel!
    @IBOutlet weak var title_TodayBirthday: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        let userName = UserDefaults.standard.object(forKey: "UserName") as? String
        lbl_UserName.text = userName
        
        btnpunch.isHidden = false
        let screenSize = UIScreen.main.bounds
        
        self.banner_Hieght.constant = screenSize.height/6
        
     
        self.pageControl.backgroundColor = UIColor.clear
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9294117647, green: 0.1960784314, blue: 0.2156862745, alpha: 1)
        
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
  
    
        
        
        birthdayAPI()
        NewJoineeAPI()
    }
    
    
    
    func setpermissions()
    {
        let controoler = SPPermissions.list([.camera,.locationAlwaysAndWhenInUse])
        controoler.titleText = "Kailash"
        controoler.headerText = "Please allow permissions to get started"
        controoler.footerText = "These Are Required"
        controoler.present(on: self)
    }
    
    
    
    
    @IBAction func btn_MyApproval(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MyApprovalVC")as! MyApprovalVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn_myRequest(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MyRequestVC")as! MyRequestVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupSideMenu() {
        
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func getdetailsApi()
    {
        CustomActivityIndicator.sharedInstance.showActivityIndicator(uiView: self.view)
        var parameters:[String:Any]?
        
        if let UserID = UserDefaults.standard.object(forKey: "UserID") as? Int {
            parameters = ["TokenNo":"abcHkl7900@8Uyhkj","UserID":UserID,"VersionName":""]
        }
        Networkmanager.postRequest(vv: self.view, remainingUrl:"GetPushNotificationList", parameters: parameters!) { (response,data) in
            let json:JSON = response
            print(json)
            let status =  json["Status"].intValue
            if status == 1
            {
                let Attendanceinput = json["AttendanceInput"].stringValue
                UserDefaults.standard.set(Attendanceinput, forKey: "AttendanceInput")
                self.imgaray = json["SliderImageList"]
                print(self.imgaray)
                self.pageControl.numberOfPages = self.imgaray.count
                self.pageControl.currentPage = 0
                
                DispatchQueue.main.async {
                    self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                }
                self.collectionView.reloadData()
                CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
            }
            else
            {
                CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
                let msg = json["Message"].stringValue
                self.showAlert(message: msg)
            }
        }
        
    }
    @objc func changeImage() {
        
        if counter < imgaray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barStyle = .default
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.view.backgroundColor = UIColor.clear
     self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.1960784314, blue: 0.2156862745, alpha: 1)
        //  #colorLiteral(red: 0.3529411765, green: 0.7294117647, blue: 0.3254901961, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        print("Helooooooooookokokokokokokokokokokokokokokokokokokokokokokokokokk")
        
        if let ProfileImage = UserDefaults.standard.object(forKey: "ImageURL") as? String {
            self.UserImage.image = UIImage(url: URL(string:ProfileImage))
        }
           
        getinOutstatus()
        
        getdetailsApi()
        
        if let Language = UserDefaults.standard.string(forKey: "Language")
        {
            print("============\(Language)")
          
            if Language == "English"
            
            {
                
                self.Translate(index: 0)
                
            }
            
            else
            
            {
                
                self.Translate(index: 1)
                
            }
            
       
        }
        
    }
    func maskCircle(anyImage: UIImageView) -> UIImageView {
        let img = anyImage
        img.contentMode = UIView.ContentMode.scaleAspectFill
        img.layer.cornerRadius = img.frame.height / 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        return img
        
    }
    
    
    
    //MARK:-  Collection View Deleagete and DataSource 
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView
        {
            return imgaray.count
        }
        if collectionView == self.collectionViewBirthDay
        {
            return birthdayData.arrayValue.count
            
        }
        else
        {
            
            return newjoineeData.arrayValue.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView ==  self.collectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pagerCell", for: indexPath) as! pagerCell
            let dic =  self.imgaray[indexPath.row]["ImageURL"].stringValue
            cell.contentView.layer.cornerRadius = 2.0
            //self.imgProfile?.sd_setImage(with: URL(string:imgurl), placeholderImage: UIImage())
            cell.imgView?.sd_setImage(with: URL(string:dic), placeholderImage: UIImage())
            cell.imgView.contentMode = .scaleAspectFill
            cell.clipsToBounds = true
            return cell
        }
        else if collectionView ==  self.collectionViewBirthDay
                    
        {      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "birthdaycell", for: indexPath) as! birthdaycell
            cell.name.text =  birthdayData[indexPath.row]["EmpName"].stringValue
            cell.degination.text = birthdayData[indexPath.row]["EmpDesignation"].stringValue
            
            let imgpath = birthdayData[indexPath.row]["EmpImage"].stringValue
            // self.img_Profile?.sd_setImage(with: URL(string:imgpath), placeholderImage: UIImage())
            cell.img?.sd_setImage(with: URL(string:imgpath), placeholderImage: UIImage())
            cell.cellDelegate = self
            return cell
            
        }
        else
        {   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newjoinehomecell", for: indexPath) as! newjoinehomecell
            
            
            
            cell.name.text =  newjoineeData[indexPath.row]["EmpName"].stringValue
            cell.degination.text = newjoineeData[indexPath.row]["EmpDesignation"].stringValue
            
            let imgpath = newjoineeData[indexPath.row]["EmpImage"].stringValue
            cell.img?.sd_setImage(with: URL(string:imgpath), placeholderImage: UIImage())
            cell.cellDelegate = self
            return cell
            
        }
        
        
    }
    
    
    @IBAction func compOffVC(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShortLeaveVC")as! ShortLeaveVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_HolidayCalander(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HolidayVC")as! HolidayVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

    
    
    @IBAction func btn_markatendance(_ sender: Any) {
        
        let AttendanceInput = UserDefaults.standard.object(forKey: "AttendanceInput") as? String
        if AttendanceInput == "A"
        {
            let options: [SemiModalOption : Any] = [
                SemiModalOption.pushParentBack: false
            ]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let pvc = storyboard.instantiateViewController(withIdentifier: "MarkAttendanceVC") as! MarkAttendanceVC
            
            pvc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400)
            
            pvc.modalPresentationStyle = .overCurrentContext
            pvc.delegate = self
            
            presentSemiViewController(pvc, options: options, completion: {
                print("Completed!")
            }, dismissBlock: {
            })
        }
        else
        {
            showAlert(message: "You Are not Allowed to Mark Attendance")
        }
    }
    
    
    
    
    @IBAction func btn_helpDesk(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "HelpDeskVC")as! HelpDeskVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    @IBAction func btn_suggestion(_ sender: Any) {
        
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "SalaryVC") as! SalaryVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btn_mytean(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MyTeamVC") as! MyTeamVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func Attendabce_btn(_ sender: Any) {
        
        UserDefaults.standard.set("False", forKey: "MyTeam") //EmployeeStatus
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalenderViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    
 
    
    
    
    
    
    @IBAction func btn_WorkAnniver(_ sender: Any) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BithdayVC") as! BithdayVC
                vc.isFrom = 3
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    @IBAction func btn_Reguarzation(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "RegulazationVC") as! RegulazationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btn_dierctoryt(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "Directory") as! Directory
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btn_notes(_ sender: Any) {
                let vc =  self.storyboard?.instantiateViewController(withIdentifier: "NotesVC") as! NotesVC
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Gallry(_ sender: Any) {
                let vc =  self.storyboard?.instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btn_leave(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "LeaveVC") as! LeaveVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    
    
   
    func getinOutstatus()  {
        
        
        var parameters:[String:Any]?
        
        if let EmpCode = UserDefaults.standard.object(forKey: "EmpCode") as? String {
            parameters = ["CategoryID":"","DepartmentID":"","DesignationID":"","DeviceID":"","EmpCode":EmpCode,"FromDate":"","LocationID":"","Name":"","PlantID":"","ReqID":"","Status":"","StatusID":"","SubCategoryID":"","SubmittedByID":"","TicketNo":"","ToDate":"","TokenNo":"abcHkl7900@8Uyhkj","UserID":"2285","VersionName":"","Year":""]
        }
        else{
            parameters = ["TokenNo":"abcHkl7900@8Uyhkj","EmpCode":"0"]
        }
        
        AF.request( base.url+"GetInOutStatus", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable (of: JSON.self) { response in
                switch response.result
                {
                    
                case .success(let value):
                    let json:JSON = JSON(value)
                    print(json)
                    print(response.request!)
                    print(parameters!)
                    let status =  json["Status"].intValue
                    if status == 1
                    {            self.lbl_intTime.text = json["InTimeLive"].stringValue
                        self.lbl_OutTime.text = json["OutTimeLive"].stringValue
                        CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
                        
                        let instatus = json["IsInButtonVisable"].intValue
                        let outstatus = json["IsOutButtonVisable"].intValue
                        
                        if instatus == 1
                        {
                            self.lbl_inOut.text = "Punch In"
                        }
                        else if outstatus == 1
                        {
                            self.lbl_inOut.text = "Punch Out"
                        }
                        else
                        {
                            print("Unknowmn")
                        }
                        
                    }
                    else
                    {
                        CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
                    }
                case .failure(let error ):
                    print(error.localizedDescription)
                }
                
                
            }
    }
    
}



class pagerCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension HomeVC
{
    func birthdayAPI()
    {   CustomActivityIndicator.sharedInstance.showActivityIndicator(uiView: self.view)
        var parameters:[String:Any]?
        parameters = ["TokenNo":"abcHkl7900@8Uyhkj"]
        Networkmanager.postRequest(vv: self.view, remainingUrl:"HRCorner_BirthdayList", parameters: parameters!) { (response,data) in
            let json:JSON = response
            let status =  json["Status"].intValue
            if status == 1
            { CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
                self.birthdayData = json["EmpBirthdayList"]
                // self.collectionViewBirthDay.isHidden = true
                print(self.birthdayData)
                self.collectionViewBirthDay.reloadData()
                
                self.timer = Timer.scheduledTimer(timeInterval:3, target: self, selector: #selector(self.changeImage2), userInfo: nil, repeats: true)
            }
            else
            {   self.collectionViewBirthDay.isHidden = true
                self.c1.constant = 0
                self.vv1_Hieght.constant = 110
            }
        }
        
    }
    @objc func changeImage2() {
        if birthdayData.count < 1
        {
            c1.constant = 110
        }
        else
        {
            
            if counter2 < birthdayData.count {
                let index = IndexPath.init(item: counter2, section: 0)
                self.collectionViewBirthDay.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                // pageControl.currentPage = counter
                counter2 += 1
            } else {
                counter2 = 0
                let index = IndexPath.init(item: counter2, section: 0)
                self.collectionViewBirthDay.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                //pageControl.currentPage = counter
                counter2 = 1
            }
        }
    }
    //=====================================================================================
    
    func NewJoineeAPI()
    {   CustomActivityIndicator.sharedInstance.showActivityIndicator(uiView: self.view)
        var parameters:[String:Any]?
        parameters = ["TokenNo":"abcHkl7900@8Uyhkj"]
        Networkmanager.postRequest(vv: self.view, remainingUrl:"HRCorner_NewJoineeList", parameters: parameters!) {
            (response,data) in
            let json:JSON = response
            let status =  json["Status"].intValue
            if status == 1
            { CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
                self.newjoineeData = json["EmpBirthdayList"]
                self.collectionViewNewJoine.reloadData()
                // self.collectionViewNewJoine.isHidden = true
                self.timer = Timer.scheduledTimer(timeInterval:2.5, target: self, selector: #selector(self.changeImage3), userInfo: nil, repeats: true)
                
            }
            else
            {   self.collectionViewNewJoine.isHidden = true
                self.vv2_Hieght.constant = 110
                self.c2.constant = 0
            }
        }
        
        
    }
    @objc func changeImage3() {
        if newjoineeData.count == 1
        {
            c2.constant = 110
        }
        else
        {
            if counter3 < newjoineeData.count {
                let index = IndexPath.init(item: counter3, section: 0)
                self.collectionViewNewJoine.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                // pageControl.currentPage = counter
                counter3 += 1
            } else {
                counter3 = 0
                let index = IndexPath.init(item: counter3, section: 0)
                self.collectionViewNewJoine.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                //pageControl.currentPage = counter
                counter3 = 1
            }
            
        }
        
    }
    
    //========================================================================================================
    func btnNewjoiner(tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
        
        let options: [SemiModalOption : Any] = [
            SemiModalOption.pushParentBack: false
        ]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "BirthdayWishVC") as! BirthdayWishVC
        pvc.txtname = newjoineeData[tag]["EmpName"].stringValue
        pvc.imgpath = newjoineeData[tag]["EmpImage"].stringValue
        pvc.empcode = newjoineeData[tag]["EmpID"].stringValue
        pvc.strWishType = "NewJoinee"
        
        pvc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 520)
        
        pvc.modalPresentationStyle = .overCurrentContext
        presentSemiViewController(pvc, options: options, completion: {
            print("Completed!")
        }, dismissBlock: {
        })
    }
    
}




extension HomeVC
{
    func Translate(index:Int)
    {
        
        
        if index == 0
        {   self.title = "Home"
            
            
            self.TitlePunchInOut.text = "PunchInOut".localizableString(loc: "en")
            self.TitlePunchIn.text = "PunchInt".localizableString(loc: "en")
            self.TitlePunchOut.text = "PunchOut".localizableString(loc: "en")
            self.TitleLeaveAndReg.text = "LeaveAndRegularasation".localizableString(loc: "en")
            self.TitleLeave.text = "Leave".localizableString(loc: "en")
            self.TitleCompOff.text = "Short Leave"
            self.TitleHolidayList.text = "Holiday List"
            self.Titleregularsation.text = "Regularsation".localizableString(loc: "en")
            self.TitleManagement.text = "Management".localizableString(loc: "en")
            self.TitleDirectory.text = "Directory".localizableString(loc: "en")
            self.TitleAttendance.text = "Attendance".localizableString(loc: "en")
            self.TitleMyTeam.text = "MyTeam".localizableString(loc: "en")
            self.TitleGallery.text = "Gallery".localizableString(loc: "en")
            self.TitleAnniversary.text = "Anniversary".localizableString(loc: "en")
            self.TitleNotes.text = "Notes".localizableString(loc: "en")
          //  self.TitleHelpDesk.text = "HelpDesk".localizableString(loc: "en")
            
            self.TitleSuggestion.text = "Salary Slip"
            
            self.titleMyRequest.setTitle( "Myrequest".localizableString(loc: "en"), for: .normal)
            self.title_MyApprovals.setTitle( "MyApprovals".localizableString(loc: "en"), for: .normal)
            self.title_TodayBirthday.text = "ToDayBirthDay".localizableString(loc: "en")
            self.titleNewJoine.text = "NewJoine".localizableString(loc: "en")
            self.lbl_NoBirthday.text = "NoBirthdaystoday".localizableString(loc: "en")
            self.lbl_NoNewJoinee.text = "NoNewJoinee".localizableString(loc: "en")
            
            
            //OtherDetails
        }
        else
        {
            
            self.title = "होम"
         
            self.TitlePunchInOut.text = "PunchOut".localizableString(loc: "hi")
            self.TitlePunchIn.text = "PunchInt".localizableString(loc: "hi")
            self.TitlePunchOut.text = "PunchOut".localizableString(loc: "hi")
            self.TitleLeaveAndReg.text = "LeaveAndRegularasation".localizableString(loc: "hi")
            self.TitleLeave.text = "Leave".localizableString(loc: "hi")
            self.TitleCompOff.text = "अल्पावधि छुट्टी"
            self.TitleHolidayList.text = "छुट्टियों की सूची"
            self.Titleregularsation.text = "Regularsation".localizableString(loc: "hi")
            self.TitleManagement.text = "Management".localizableString(loc: "hi")
            self.TitleDirectory.text = "Directory".localizableString(loc: "hi")
            self.TitleAttendance.text = "Attendance".localizableString(loc: "hi")
            self.TitleMyTeam.text = "MyTeam".localizableString(loc: "hi")
            self.TitleGallery.text = "Gallery".localizableString(loc: "hi")
            self.TitleAnniversary.text = "Anniversary".localizableString(loc: "hi")
            self.TitleNotes.text = "Notes".localizableString(loc: "hi")
           // self.TitleHelpDesk.text = "HelpDesk".localizableString(loc: "hi")
            
            self.TitleSuggestion.text = "वेतन पर्ची"
            
            self.titleMyRequest.setTitle( "Myrequest".localizableString(loc: "hi"), for: .normal)
            self.title_MyApprovals.setTitle( "MyApprovals".localizableString(loc: "hi"), for: .normal)
            self.title_TodayBirthday.text = "ToDayBirthDay".localizableString(loc: "hi")
            self.titleNewJoine.text = "NewJoine".localizableString(loc: "hi")
            self.lbl_NoBirthday.text = "NoBirthdaystoday".localizableString(loc: "hi")
            self.lbl_NoNewJoinee.text = "NoNewJoinee".localizableString(loc: "hi")
          
        }
    }
    
}



class birthdaycell:UICollectionViewCell
{
    @IBOutlet weak var btn_SendWish: Gradientbutton!
    @IBOutlet weak var vv: UIView!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var degination: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    var cellDelegate:Birthday?
    
    @IBAction func btn(_ sender: Any) {
        cellDelegate?.btnBaddy(tag:(sender as AnyObject).tag)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let defaults = UserDefaults.standard
        if let Language = defaults.string(forKey: "Language") {
            if Language == "English"
            {
                self.btn_SendWish.setTitle("Send Wishes", for: .normal)
            }
            else
            {
                self.btn_SendWish.setTitle("शुभकामनाएं भेजें", for: .normal)
            }
        }
    }
}
class newjoinehomecell:UICollectionViewCell
{
    @IBOutlet weak var vv: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var degination: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var btn_Wishes: Gradientbutton!
    var cellDelegate:newjoiner?
    @IBAction func btn(_ sender: Any) {
        cellDelegate?.btnNewjoiner(tag: (sender as AnyObject).tag)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let defaults = UserDefaults.standard
        if let Language = defaults.string(forKey: "Language") {
            if Language == "English"
            {
                self.btn_Wishes.setTitle("Send Wishes", for: .normal)
            }
            else
            {
                self.btn_Wishes.setTitle("शुभकामनाएं भेजें", for: .normal)
            }
        }
    }
}

extension HomeVC
{
    func btnBaddy(tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
        
        let options: [SemiModalOption : Any] = [
            SemiModalOption.pushParentBack: false
        ]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "BirthdayWishVC") as! BirthdayWishVC
        pvc.txtname = birthdayData[tag]["EmpName"].stringValue
        pvc.imgpath = birthdayData[tag]["EmpImage"].stringValue
        pvc.empcode = birthdayData[tag]["EmpID"].stringValue
        pvc.strWishType = "Birthday"
        
        pvc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 520)
        
        pvc.modalPresentationStyle = .overCurrentContext
        presentSemiViewController(pvc, options: options, completion: {
            print("Completed!")
        }, dismissBlock: {
        })
    }
}
