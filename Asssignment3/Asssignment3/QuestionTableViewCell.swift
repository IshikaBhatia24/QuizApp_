//
//  QuestionTableViewCell.swift
//  Asssignment3
//
//  Created by Ishika on 2025-03-21.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTextField: UILabel!
    
    @IBOutlet weak var correctAnswerTextField: UILabel!
    
    @IBOutlet weak var choice1TextField: UILabel!
    
    
    @IBOutlet weak var choice2TextField: UILabel!
    
    
    @IBOutlet weak var choice3TextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
