//
//  Model.swift
//  DoYourChores
//
//  Created by Blake O'Connell on 11/16/17.
//  Copyright © 2017 Blake O'Connell. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//class userData
//{
//    var users: [userRecord] = []
//    
//    
//    init()
//    {
//        var newUser = userRecord(n: "Blake")
//        //newPlace.addPic("cali")
//        users.append(newUser)
//        
//        newUser = userRecord(n: "Lindsay")
//        //newPlace.addPic("cali")
//        users.append(newUser)
//        
//        newUser = userRecord(n: "Tori")
//        //newPlace.addPic("cali")
//        users.append(newUser)
//        
//        newUser = userRecord(n: "Anyssa")
//        //newPlace.addPic("cali")
//        users.append(newUser)
//        
//    }
//    
//    func getAUser(_ name:NSString) -> userRecord
//    {
//        var j: Int = self.users.count-1
//        var r: userRecord = userRecord(n: " ")
//        
//        for i in 0...j
//        {
//            if self.users[i].getName() == name as String
//            {
//                r = self.users[i]
//            }
//        }
//        return r
//    }
//    
//    func deleteUser(index: Int)
//    {
//        self.users.remove(at: index)
//    }
//}

//class choreData
//{
//    var chores: [choreRecord] = []
//    
//    
//    init()
//    {
//        var newChore = choreRecord(n: "Dishes")
//        //newPlace.addPic("cali")
//        chores.append(newChore)
//        
//        newChore = choreRecord(n: "Laundry")
//        //newPlace.addPic("cali")
//        chores.append(newChore)
//        
//        newChore = choreRecord(n: "Garbage")
//        //newPlace.addPic("cali")
//        chores.append(newChore)
//        
//        newChore = choreRecord(n: "Sweep and mop")
//        //newPlace.addPic("cali")
//        chores.append(newChore)
//        
//    }
//    
//    func getAChore(_ name:NSString) -> choreRecord
//    {
//        var j: Int = self.chores.count-1
//        var r: choreRecord = choreRecord(n: " ")
//        
//        for i in 0...j
//        {
//            if self.chores[i].getName() == name as String
//            {
//                r = self.chores[i]
//            }
//        }
//        return r
//    }
//    
//    func deleteChore(index: Int)
//    {
//        self.chores.remove(at: index)
//    }
//}

class userRecord
{
    fileprivate var name: String = ""
    fileprivate var chores = [String]()
    fileprivate var index = 0
    fileprivate var pic: String = " "
    init (n: String, i: Int)
    {
        name=n
        index=i
    }
    
    internal func getName() -> String
    {
        return name
    }
    
    internal func getChores() -> String
    {
        var choreString = ""
        for chore in chores {
            choreString += chore
            choreString += ", "
        }
        if (chores.count != 0) {
        let range = choreString.index(choreString.endIndex, offsetBy: -2)..<choreString.endIndex
        choreString.removeSubrange(range)
        return choreString
        }
        return ""
    }
    
    internal func clearChores()
    {
        chores.removeAll()
    }

    internal func getImage() -> String
    {
        return pic
    }
    
    internal func addPic(_ picture: String)
    {
        pic = picture
    }
}

class choreRecord
{
    fileprivate var name: String = ""
    fileprivate var index = 0
    fileprivate var userAssigned: String = ""
    init (n: String, i: Int)
    {
        name=n
        index=i
    }
    
    internal func getName() -> String
    {
        return name
    }
    
    internal func getUser() -> String
    {
        return userAssigned
    }
}

class sessionRecord
{
    fileprivate var sessionID: Int16 = 0
    fileprivate var address: String = ""
    init (id: Int16, a: String)
    {
        sessionID=id
        address=a
    }
    
    internal func getAddress() -> String
    {
        return address
    }
    
    internal func getId() -> Int16
    {
        return sessionID
    }
}

class choreSession {
    
    var chores: [choreRecord] = []
    var users: [userRecord] = []
    var sessions: [sessionRecord] = []
    var pictures = [String: UIImage]()
    var fetchUserResults = [Person]()
    var fetchChoresResults = [Chores]()
    var fetchSessionResults = [Session]()
    var count = 0
    
    var userDataContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var choreDataContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var sessionDataContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(){
//        count = fetchSessionRecord()
//        
//        if (count == 0) {
//            let newSession = addSession(id: 0, address: "")
//            count += 1
//        }
    }
    
    func fetchUserRecord() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        var x = 0
        fetchUserResults = ((try?
            userDataContext.fetch(fetchRequest)) as? [Person])!
        
        x = fetchUserResults.count
        
        print(x)
        users = []
        for result in fetchUserResults {
            if(result.sessionID == sessions[count].sessionID) {
                let newPerson = userRecord(n: result.name!, i: users.count)
            users.append(newPerson)
            saveImage(name: newPerson.name, image: UIImage(data: result.picture! as Data)!)
            }
        }
        return x
    }
    
    func fetchChoresRecord() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chores")
        var x = 0
        fetchChoresResults = ((try?
            choreDataContext.fetch(fetchRequest)) as? [Chores])!
        
        x = fetchChoresResults.count
        
        print(x)
        chores = []
        for result in fetchChoresResults {
            if(result.sessionID == sessions[count].sessionID) {
                let newChore = choreRecord(n: result.name!, i: chores.count)
            chores.append(newChore)
            }
        }
        return x
    }
    
    func populate(index: Int) {
        let numUsers = fetchUserRecord()
        let numChores = fetchChoresRecord()
        
        print(numUsers)
        print(numChores)
        
        var newUsers = [userRecord]()
        var newChores = [choreRecord]()
        for user in fetchUserResults {
            print("User session ID: \(user.sessionID)")
            print("session ID: \(sessions[index].sessionID)")
            if (user.sessionID == sessions[index].sessionID) {
                let newUser = userRecord(n: user.name!, i: Int(user.index))
                newUser.chores = user.chores as! [String]
                newUsers.append(newUser)
            }
        }
        for chore in fetchChoresResults {
            if (chore.sessionID == sessions[index].sessionID) {
                let newChore = choreRecord(n: chore.name!, i: Int(chore.index))
                newChore.userAssigned = chore.userAssigned!
                newChores.append(newChore)
            }
        }
        users = newUsers
        chores = newChores
    }
    
    func fetchSessionRecord() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Session")
        var x = 0
        fetchSessionResults = ((try?
            sessionDataContext.fetch(fetchRequest)) as? [Session])!
        
        x = fetchSessionResults.count
        
        print(x)
        sessions = []
        for result in fetchSessionResults {
            _ = sessions.count
            let newSession = sessionRecord(id: result.id, a: result.address!)
            sessions.append(newSession)
        }
        return x
    }

    
    func getAUser(_ name:NSString) -> userRecord
    {
        let j: Int = self.users.count-1
        var r: userRecord = userRecord(n: " ", i: 0)
        
        for i in 0...j
        {
            if self.users[i].getName() == name as String
            {
                r = self.users[i]
            }
        }
        return r
    }
    
    func addUser(newUser: userRecord, image: UIImage, sessionID: Int16) {
        users.append(newUser)
        let ent = NSEntityDescription.entity(forEntityName: "Person", in: self.userDataContext)
        let newItem = Person(entity: ent!, insertInto: self.userDataContext)
        newItem.name = newUser.name
        newItem.chores = newUser.chores as NSObject
        let imageData = UIImagePNGRepresentation(image)
        newItem.picture = imageData! as NSData as Data
        newItem.sessionID = sessionID
        newItem.index = Int16(users.count)
        
        do {
            try
                self.userDataContext.save()
        } catch _ {
        }
        
        print(newItem)
    }
    
    func deleteUsers()
    {
        self.users.removeAll()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        var x = 0
        fetchUserResults = ((try?
            userDataContext.fetch(fetchRequest)) as? [Person])!
        
        x = fetchUserResults.count
        
        print(x)
        
        for records in fetchUserResults {
            userDataContext.delete(records)
        }
        
        do {
            try
                self.userDataContext.save()
        } catch _ {
        }
    }
    
    func getAChore(_ name:NSString) -> choreRecord
    {
        let j: Int = self.chores.count-1
        var r: choreRecord = choreRecord(n: " ", i: 0)
        
        for i in 0...j
        {
            if self.chores[i].getName() == name as String
            {
                r = self.chores[i]
            }
        }
        return r
    }
    
    func addChore(newChore: choreRecord, sessionID: Int16) {
        chores.append(newChore)
        let ent = NSEntityDescription.entity(forEntityName: "Chores", in: self.choreDataContext)
        let newItem = Chores(entity: ent!, insertInto: self.choreDataContext)
        newItem.name = newChore.name
        newItem.userAssigned = newChore.userAssigned
        newItem.sessionID = sessionID
        newItem.index = Int16(chores.count)
        
        do {
            try
                self.choreDataContext.save()
        } catch _ {
        }
        
        print(newItem)
    }
    
    func addSession(id: Int16, address: String) {
        let newSession = sessionRecord(id: id, a: address)
        sessions.append(newSession)
        let ent = NSEntityDescription.entity(forEntityName: "Session", in: self.sessionDataContext)
        let newItem = Session(entity: ent!, insertInto: self.sessionDataContext)
        newItem.address = address
        newItem.id = id
        
        do {
            try
                self.sessionDataContext.save()
        } catch _ {
        }
        
        print(newItem)
    }
    
    func deletePersonNew(index: Int) {
        self.users.remove(at: index)
    }
    
    func deleteChoreNew(index: Int) {
        self.chores.remove(at: index)
    }
    
    func deleteChores()
    {
        self.chores.removeAll()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chores")
        var x = 0
        fetchChoresResults = ((try?
            choreDataContext.fetch(fetchRequest)) as? [Chores])!
        
        x = fetchChoresResults.count
        
        print(x)
        
        for chore in fetchChoresResults {
            choreDataContext.delete(chore)
        }
        
        do {
            try
                self.choreDataContext.save()
        } catch _ {
        }
    }
    
    func deleteSessions()
    {
        self.sessions.removeAll()
        deleteUsers()
        deleteChores()
        self.pictures.removeAll()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Session")
        var x = 0
        fetchSessionResults = ((try?
            sessionDataContext.fetch(fetchRequest)) as? [Session])!
        
        x = fetchSessionResults.count
        
        print(x)
        
        for session in fetchSessionResults {
            sessionDataContext.delete(session)
        }
        
        
        do {
            try
                self.sessionDataContext.save()
        } catch _ {
        }
    }
    
    func saveSession(address: String) {
        let ID = fetchSessionRecord()
        addSession(id: Int16(ID), address: address)
        for person in users {
            addUser(newUser: person, image: getImage(name: person.name), sessionID: Int16(ID))
        }
        for chore in chores {
            addChore(newChore: chore, sessionID: Int16(ID))
        }
    }
    
    func saveImage(name: String, image: UIImage) {
        pictures[name] = image
    }
    
    func getImage(name: String) -> UIImage {
        for (savedName, picture) in pictures {
            if (name == savedName) {
                return picture
            }
        }
        return #imageLiteral(resourceName: "artist-placeholder.png")
    }
    
    func assignChores() {
        
        var choresAssigned = 0
        var indexesAssigned = [Int]()
        var indexExists = true
        
        if (chores.count % users.count == 0) {
            let eachPersonsChores = chores.count / users.count
            for person in users {
                var timesThrough = 0
                while (timesThrough < eachPersonsChores){
                indexExists = true
                var randomNum:UInt32 = arc4random_uniform(UInt32(chores.count))
                var randomInt:Int = Int(randomNum)
                if (indexesAssigned.count != 0){
                while (indexExists == true){
                    indexExists = false
                for index in indexesAssigned {
                    if (index == randomInt) {
                        indexExists = true
                        randomNum = arc4random_uniform(UInt32(chores.count))
                        randomInt = Int(randomNum)
                    }
                    }
                }
                    indexesAssigned.append(randomInt)
                    person.chores.append(chores[randomInt].name)
                    chores[randomInt].userAssigned = person.name
                    timesThrough += 1
                    
                }
                else {
                    indexesAssigned.append(randomInt)
                    person.chores.append(chores[randomInt].name)
                    chores[randomInt].userAssigned = person.name
                    timesThrough += 1
                }
            }
        }
        }
        
        else {
            let eachPersonsChores = chores.count / users.count
            for person in users {
                var timesThrough = 0
                while (timesThrough < eachPersonsChores) {
                    indexExists = true
                    var randomNum:UInt32 = arc4random_uniform(UInt32(chores.count))
                    var randomInt:Int = Int(randomNum)
                    if(indexesAssigned.count != 0){
                        while(indexExists == true){
                            indexExists = false
                            for index in indexesAssigned {
                                if (index == randomInt) {
                                    indexExists = true
                                    randomNum = arc4random_uniform(UInt32(chores.count))
                                    randomInt = Int(randomNum)
                                }
                            }
                        }
                        indexesAssigned.append(randomInt)
                        person.chores.append(chores[randomInt].name)
                        chores[randomInt].userAssigned = person.name
                        timesThrough += 1
                        choresAssigned += 1
                    }
                    else {
                        indexesAssigned.append(randomInt)
                        person.chores.append(chores[randomInt].name)
                        chores[randomInt].userAssigned = person.name
                        timesThrough += 1
                        choresAssigned += 1
                    }
                }
            }
            while (choresAssigned < chores.count) {
                indexExists = true
                var randomNum:UInt32 = arc4random_uniform(UInt32(chores.count))
                var randomInt:Int = Int(randomNum)
                while(indexExists == true){
                    indexExists = false
                    for index in indexesAssigned {
                        if (index == randomInt) {
                            indexExists = true
                            randomNum = arc4random_uniform(UInt32(chores.count))
                            randomInt = Int(randomNum)
                        }
                    }
                }
                indexesAssigned.append(randomInt)
                let randomUser:UInt32 = arc4random_uniform(UInt32(users.count))
                let randomUserInt:Int = Int(randomUser)
                users[randomUserInt].chores.append(chores[randomInt].name)
                chores[randomInt].userAssigned = users[randomUserInt].name
                choresAssigned += 1
            }
        }
        
        
        
    }
    
}
