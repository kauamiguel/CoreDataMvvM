//
//  CoreDataViewModel.swift
//  coreDataMVVM
//
//  Created by Kaua Miguel on 14/08/23.
//

import Foundation
import CoreData

class CoreDataViewModel : ObservableObject {
    let container : NSPersistentContainer
    @Published var savedEntities : [AlunosEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "AlunosModel")
        container.loadPersistentStores { (description, error) in
            if let _ = error{
                print("Error to load")
            }
        }
        fetchAunos()
    }
    
    //Functions to make CRUD on data
    
    func fetchAunos(){
        let request = NSFetchRequest<AlunosEntity>(entityName: "AlunosEntity")
        
        do{
            try savedEntities = container.viewContext.fetch(request)
        }catch{
            print("Error fetching data")
        }
    }
    
    func updateAluno(entity : AlunosEntity){
        let newName = "AlunoEditado"
        entity.name = newName
        saveData()
    }
    
    func removeAluno(index: IndexSet){
        let indexDeletedObject = index.first!
        let deletedObject = savedEntities[indexDeletedObject]
        container.viewContext.delete(deletedObject)
        saveData()
    }
    
    func addAluno(text : String){
        let newAluno = AlunosEntity(context: container.viewContext)
        newAluno.name = text
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetchAunos()
        }catch{
            print("Error saving data")
        }
    }
}
