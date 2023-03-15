//
//  UserPostTableViewCell.swift
//  MVVM Title Body
//
//  Created by Phincon on 14/03/23.
//

import UIKit

class UserPostTableViewCell: UITableViewCell {
    static let identifier = "UserPostTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
