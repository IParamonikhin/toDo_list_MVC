//
//  CustomCell.swift
//  toDo_list_MVC
//
//  Created by Иван on 06.06.2023.
//

import UIKit

protocol CustomCellDelegate{
    func removeCell(_ cell: CustomCell)
    func completeCell(_ cell: CustomCell)
}

class CustomCell: UITableViewCell {

    var delegate: CustomCellDelegate?
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBAction func customCellCompletedButtonAction(_ sender: UIButton) {
        delegate?.completeCell(self)
    }
    
    @IBAction func customCellRemoveButtonAction(_ sender: UIButton) {
        delegate?.removeCell(self)
    }
}
