//
//  TaskViewController.swift
//  toDo_list_MVC
//
//  Created by Иван on 12.06.2023.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var deadLinePicker: UIDatePicker!
    
    var taskName = ""
    var mode: Mode = .none
    var editCellIndex = 0
    
    weak var delegate: TaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deadLinePicker.datePickerMode = .date
        deadLinePicker.preferredDatePickerStyle = .compact
        nameTextField.text = taskName
    }

    
    @IBAction func saveButtonAction(_ sender: Any) {
        guard let taskName = nameTextField.text else { return }
        if mode == .add{
            delegate?.addCallback(taskName, deadLinePicker.date)
        }
        else if mode  == .edit{
            delegate?.editCallback(editCellIndex, taskName, deadLinePicker.date)
        }
        self.dismiss(animated: true)
    }
}
