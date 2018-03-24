//
//  AddViewController.swift
//  DoYourChores
//
//  Created by Blake O'Connell on 11/16/17.
//  Copyright © 2017 Blake O'Connell. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
//    var usersData: userData = userData()
//    var choresData: choreData = choreData()
    var choresSession: choreSession = choreSession()
    
    var addText = ""
    var nameText = ""
    
    @IBOutlet weak var addPhoto: UIButton!
    @IBOutlet weak var addLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var cameraOrLibrary: UISegmentedControl!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var picture: UIImageView!
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        nameTextField.delegate = self
        addLabel.text = addText
        nameLabel.text = nameText
        if (nameText == "Chore:") {
            cameraOrLibrary.isHidden = true
            picture.isHidden = true
            addPhoto.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.nameTextField.resignFirstResponder()
    }
    
    @IBAction func saveRecord(_ sender: Any) {
        if (nameText == "Chore:") {
            let newChore = choreRecord(n: nameTextField.text!, i: choresSession.chores.count)
            //choresData.chores.append(newChore)
            choresSession.chores.append(newChore)
            //choresSession.addChore(newChore: newChore)
        }
        else {
            let newUser = userRecord(n: nameTextField.text!, i: choresSession.users.count)
//            usersData.users.append(newUser)
            choresSession.users.append(newUser)
            choresSession.saveImage(name: newUser.getName(), image: picture.image!)
            //choresSession.addUser(newUser: newUser, image: picture.image!)
        }
    }
    
    @IBAction func addImage(_ sender: Any) {
        if cameraOrLibrary.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker, animated: true, completion: nil)
            } else {
                print("No camera")
            }
        } else {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker .dismiss(animated: true, completion: nil)
        picture.image=info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
