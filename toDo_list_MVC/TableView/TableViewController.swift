//
//  TableViewController.swift
//  toDo_list_MVC
//
//  Created by Иван on 06.06.2023.
//

import UIKit

enum Mode{
    case add
    case edit
    case none
}

protocol TaskDelegate: AnyObject{
    func addCallback(_ name: String, _ date: Date)
    func editCallback(_ index: Int, _ name: String, _ date: Date)
}

class TableViewController: UITableViewController {
    
    var alert = UIAlertController()
    let model = Model()
    
    @IBOutlet weak var addModeButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return model.toDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell

        cell.delegate = self
        
        let currentItem = model.toDoItems[indexPath.row]
        cell.itemLabel?.text = currentItem.name
        deadLineColorChange(cell, indexPath.row)
        completeButtonImageChange(cell, indexPath.row)
        return cell
        
    }
    // Изменение цвета таска в зависимости от статуса выполнености
    func completeButtonImageChange(_ cell: CustomCell, _ index: Int){
        model.toDoItems[index].completed ? cell.completeButton.setImage(.checkmark, for: .normal) :
        cell.completeButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    // Измененине цвета таска в зависимости от близости дедлайна
    func deadLineColorChange(_ cell: CustomCell,_ index: Int){
        
        if model.toDoItems[index].completed{
            cell.backgroundColor = .green
        }
        else{
            if model.deadLineStatusCheck(at: index) == .fewDays{
                cell.backgroundColor = .white
            }
            else if model.deadLineStatusCheck(at: index) == .lastDay{
                cell.backgroundColor = .orange
            }
            else if model.deadLineStatusCheck(at: index) == .overdue{
                cell.backgroundColor = .red
            }
        }
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let showVC = storyboard?.instantiateViewController(identifier: "OpenModeView") as! OpenTaskViewController
        if let sheet = showVC.sheetPresentationController{ sheet.detents = [.medium()]}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        showVC.taskName = model.toDoItems[indexPath.row].name
        showVC.deadLine = dateFormatter.string(from: model.toDoItems[indexPath.row].endDate)
        present(showVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .none
            
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .none {
            
        }    
    }

    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        model.moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal,
                                        title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.editCellContent(indexPath: indexPath)
                                            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func editCellContent(indexPath: IndexPath) {
        
        let showVC = storyboard?.instantiateViewController(identifier: "TaskVC") as! TaskViewController
        if let sheet = showVC.sheetPresentationController{ sheet.detents = [.medium()]}
        showVC.delegate = self
        showVC.mode = .edit
        showVC.editCellIndex = indexPath.row
        showVC.taskName = model.toDoItems[indexPath.row].name
        present(showVC, animated: true)
        
    }
    

    @IBAction func addModeButtonAction(_ sender: UIBarButtonItem) {
        let showVC = storyboard?.instantiateViewController(identifier: "TaskVC") as! TaskViewController
        if let sheet = showVC.sheetPresentationController{ sheet.detents = [.medium()]}
        showVC.delegate = self
        showVC.mode = .add
        present(showVC, animated: true)
    }

}


extension TableViewController: CustomCellDelegate{
    
    func removeCell(_ cell: CustomCell) {
        let indexPath = tableView.indexPath(for: cell)
        guard let unwrIndexPath = indexPath else { return }
        model.removeItem(at: unwrIndexPath.row)
        tableView.reloadData()
    }
    
    func completeCell(_ cell: CustomCell) {
        let indexPath = tableView.indexPath(for: cell)
        guard let unwrIndexPath = indexPath else { return }
        model.changeState(at: unwrIndexPath.row)
        tableView.reloadData()
    }
}

extension TableViewController: TaskDelegate{

    func addCallback(_ name: String, _ date: Date) {
            model.addItem(name: name, endDate: date)
        tableView.reloadData()
    }
    
    func editCallback(_ index: Int, _ name: String, _ date: Date){
        
        model.updateItem(at: index, with: name, deadLine: date)
        tableView.reloadData()
    }
    
}
