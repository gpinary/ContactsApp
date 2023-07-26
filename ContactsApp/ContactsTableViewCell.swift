//
//  ContactsTableViewCell.swift
//  ContactsApp
//
//  Created by Gökçe Pınar Yıldız on 22.07.2023.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
