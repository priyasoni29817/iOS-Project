//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Priya Soni on 21/07/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        //retrieveData()
        updateData()
        //retrieveData()
        deleteData()
        retrieveData()
        // Do any additional setup after loading the view.
    }

    func createData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        for i in 1...5{
            let person = NSManagedObject.init(entity: personEntity, insertInto: managedContext)
            person.setValue("Priya\(i)", forKey: "name")
            person.setValue(23, forKey: "age")
        }
        do {
            try managedContext.save()
        }catch let error as NSError{
            print(error.userInfo)
        }
    }
    func retrieveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey:"name") as! String)
            }
        }catch{
            print("error")
        }
    }
    func updateData(){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate.init(format: "name=%@","Priya1")
        do{
            let test = try managedContext?.fetch(fetchRequest)
            let objectUdate = test?[0] as! NSManagedObject
            objectUdate.setValue("priya soni", forKey: "name")
            do{
                try managedContext?.save()
            }catch{
                print("error")
            }
        }catch{
            print("error")
        }
        
    }
    func deleteData(){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate.init(format: "name=%@", "Priya")
        do{
            let data = try managedContext?.fetch(fetchRequest)
            for dataToDelete in data as! [NSManagedObject]{
                managedContext?.delete(dataToDelete)
            }
            do {
                try managedContext?.save()
            }catch{
                print("error")
            }
            
        }catch{
            print("error")
            
        }
    }
}

