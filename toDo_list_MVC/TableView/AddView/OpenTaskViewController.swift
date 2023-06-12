//
//  OpenTaskViewController.swift
//  toDo_list_MVC
//
//  Created by Иван on 12.06.2023.
//

import UIKit

class OpenTaskViewController: UIViewController {

    
    var taskName = ""
    var deadLine = ""
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var deadLineLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameLabel.text = taskName
        deadLineLabel.text = deadLine

    }
    


}
