//
//  AddAccomadationCell.swift
//  HRMS Trivitron
//
//  Created by Netcommlabs on 18/09/23.
//

import UIKit

class AddAccomadationCell: UITableViewCell {
    @IBOutlet weak var DestinationCity:UILabel!
    @IBOutlet weak var HotelName:UILabel!
    @IBOutlet weak var CheckInDate:UILabel!
    @IBOutlet weak var CheckInTime:UILabel!
    @IBOutlet weak var CheckOutDate:UILabel!
    @IBOutlet weak var CheckOutTime:UILabel!

    @IBOutlet weak var btnremove:UIButton!
    @IBOutlet weak var class_type: UILabel!
    @IBOutlet weak var bookedby: UILabel!
    @IBOutlet weak var remarks: UILabel!
    @IBOutlet weak var txt_View: UIView!
    @IBOutlet weak var txt_Amt: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
