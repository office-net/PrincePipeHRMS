//
//  TableView_Functions.swift
//  PatanjaliTMS
//
//  Created by Ankit Rana on 22/11/24.
//

import Foundation
import UIKit
import SwiftyJSON
extension RequititionFormVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         if tableView == tbl2 {
             if AccomadationJSON.count == 0
             {
                 Hieght_Tbl_2.constant = CGFloat(35 * AccomadationJSON.count)
             }
             else
             {
                 Hieght_Tbl_2.constant = CGFloat(35 * AccomadationJSON.count) + 40
             }
             return AccomadationJSON.count
           
         } else {
             if HistoryJSON.count == 0
             {
                 Hieght_Tbl_History.constant = CGFloat(35 * HistoryJSON.count)
             }
             else
             {
                 Hieght_Tbl_History.constant = CGFloat(35 * HistoryJSON.count) + 35
             }
             return HistoryJSON.count
         }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl2
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
            
            cell.btnremove.tag =  indexPath.row
            cell.btnremove.addTarget(self, action: #selector(RemoveAccomadation(_sender:)), for: .touchUpInside)
           cell.DestinationCity.text =  AccomadationJSON[indexPath.row]["DesCity"].stringValue
           
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
            
            
            
            cell.btn_Remove.tag = indexPath.row
            cell.btn_Remove.addTarget(self, action: #selector(RemoveHistory(_sender:)), for: .touchUpInside)
            cell.txt_View.isHidden = true
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
                return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tbl2
        { return 35
            
        }
        else
        { return 35
            
        }
        
    }
    @objc func RemoveHistory (_sender:UIButton)
    {
        self.DeleteRow(ReqType: "TRAVEL", Id: HistoryJSON[_sender.tag]["Id"].stringValue)
    }
    
    @objc func RemoveAccomadation (_sender:UIButton)
    {
        self.DeleteRow(ReqType: "ACCOMODATION", Id: AccomadationJSON[_sender.tag]["Id"].stringValue)
    }
    
    
}
