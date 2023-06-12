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
    
    weak var delegate: TaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deadLinePicker.datePickerMode = .date
        deadLinePicker.preferredDatePickerStyle = .compact
    }

    
    @IBAction func saveButtonAction(_ sender: Any) {
        guard let taskName = nameTextField.text else { return }
        delegate?.callback(taskName, deadLinePicker.date)
        self.dismiss(animated: true)
    }
}
