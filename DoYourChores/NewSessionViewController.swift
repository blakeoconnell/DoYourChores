//
//  NewSessionViewController.swift
//  DoYourChores
//
//  Created by Blake O'Connell on 11/16/17.
//  Copyright © 2017 Blake O'Connell. All rights reserved.
//

import UIKit

class NewSessionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var personTable: UITableView!
    @IBOutlet weak var choreTable: UITableView!
//    var usersData: userData = userData()
//    var choresData: choreData = choreData()
    var choresSession: choreSession = choreSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        personTable.dataSource = self
        personTable.delegate = self
        addressField.delegate = self
        choreTable.dataSource = self
        choreTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.addressField.resignFirstResponder()
    }
    
    
//    @IBAction func loadTable(_ sender: Any) {
//        visitedPlaces.reloadData()
//    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            if tableView == self.personTable
            {
                choresSession.deletePersonNew(index: indexPath.row)
//                usersData.delete(index: indexPath.row)
                personTable.reloadData()
            }
            
            if tableView == self.choreTable
            {
                choresSession.deleteChoreNew(index: indexPath.row)
                //choresData.delete(index: indexPath.row)
                choreTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.personTable {
            //count = usersData.users.count
            //count = choresSession.fetchUserRecord()
            count = choresSession.users.count
        }
        
        if tableView == self.choreTable {
            //count = choresData.chores.count
            //count = choresSession.fetchChoresRecord()
            count = choresSession.chores.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.personTable {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell!.textLabel?.text = usersData.users[indexPath.row].getName();
            cell!.textLabel?.text = choresSession.users[indexPath.row].getName();
            //cell!.textLabel?.text = choresSession.fetchUserResults[indexPath.row].name;
//            let cell_Image = UIImage(data: choresSession.fetchUserResults[indexPath.row].picture! as Data)
//            cell!.imageView?.image = cell_Image
            let cell_Image = choresSession.getImage(name: (cell!.textLabel?.text)!);
            cell!.imageView?.image = cell_Image
            
        }
        
        if tableView == self.choreTable {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
//           cell!.textLabel?.text = choresData.chores[indexPath.row].getName();
            cell!.textLabel?.text = choresSession.chores[indexPath.row].getName();
//            cell!.textLabel?.text = choresSession.fetchChoresResults[indexPath.row].name;
            
        }
        
        
        
        return cell!
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults"
        {
            let des = segue.destination as! ResultsViewController
            //assignChores()
            des.address = addressField.text!
            des.choresSession = choresSession
            
        }
        
        
        if segue.identifier == "addPerson"
        {
            let des = segue.destination as! AddViewController
            des.addText = "Add a new user:"
            des.nameText = "Name:"
            //des.usersData = usersData
            des.choresSession = choresSession
        }
        
        
        if segue.identifier == "addChore"
        {
            let des = segue.destination as! AddViewController
            des.addText = "Add a new chore:"
            des.nameText = "Chore:"
            //des.choresData = choresData
            des.choresSession = choresSession
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        personTable.reloadData()
        choreTable.reloadData()
    }
    
    @IBAction func returned(segue: UIStoryboardSegue)
    {
        personTable.reloadData()
        choreTable.reloadData()
        for person in choresSession.users {
            person.clearChores()
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "toResults" { // you define it in the storyboard (click on the segue, then Attributes' inspector > Identifier
            
            if !(addressField.text?.isEmpty == false && choresSession.chores.count != 0 && choresSession.users.count != 0) {
                print("*** NOPE, segue wont occur")
                return false
            }
            else {
                print("*** YEP, segue will occur")
            }
        }
        
        // by default, transition
        return true
    }
    
    @IBAction func assignChores(_ sender: Any) {
        if (addressField.text?.isEmpty == false && choresSession.chores.count != 0 && choresSession.users.count != 0)
        {
            choresSession.assignChores()
        }
        else
        {
            print("You didn't actually write anything.")
        }
    }
    
    
    
    
//    @IBAction func returnedSecond(segue: UIStoryboardSegue)
//    {
//        fromSecond.text = "returned from view 3"
//        
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
