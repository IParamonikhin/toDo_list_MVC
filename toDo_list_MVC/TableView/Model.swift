//
//  Model.swift
//  toDo_list_MVC
//
//  Created by Иван on 06.06.2023.
//

import Foundation
import UIKit

enum TaskDeadLineStatus{
    case overdue
    case lastDay
    case fewDays
}

class Item {
    var name: String
    var completed: Bool = false
//    var startDate: String
    var endDate: Date
    
    init(_ name: String, _ endDate: Date){
        self.name = name
        self.endDate = endDate
        //self.startDate.string(from: startDates) = startDate
    }
    
    func deadLineStatusCheck (_ deadLine: Date) -> TaskDeadLineStatus{
        var deadLineStatus: TaskDeadLineStatus
        var date = Date()
        date = date.stripTime()
        let deadLineStripTime = deadLine.stripTime()
        if deadLineStripTime > date{
            deadLineStatus = .fewDays
        }
        else if deadLineStripTime == date{
            deadLineStatus = .lastDay
        }
        else{
            deadLineStatus = .overdue
        }
        
        return deadLineStatus
    }
}


class Model {
    
    var toDoItems: [Item] = [Item("test1", Date.now)]
    var editButtonClicked : Bool = false
    //метод добавления элемента в список задач
    func addItem(name: String, endDate: Date){
        toDoItems.append(Item(name, endDate))
    }
    
    func removeItem(at index: Int) {
        toDoItems.remove(at: index)
    }
    
    func updateItem(at index: Int, with name: String, deadLine: Date) {
        toDoItems[index].name = name
        toDoItems[index].endDate = deadLine.stripTime()
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = toDoItems[fromIndex]
        toDoItems.remove(at: fromIndex)
        toDoItems.insert(from, at: toIndex)
    }
    
    func changeState(at item: Int) {//-> Bool {
        
        toDoItems[item].completed = !toDoItems[item].completed
//        return toDoItems[item].completed
    }
    
    func deadLineStatusCheck (at item: Int) -> TaskDeadLineStatus{
        return toDoItems[item].deadLineStatusCheck(toDoItems[item].endDate)
    }
}


extension Date {
    func stripTime() -> Date {
            let components = Calendar.current.dateComponents([.day, .month, .year], from: self)
            let date = Calendar.current.date(from: components)
            return date!
        }
}
