//
//  NoteDisplayVC.swift
//  MakeSchoolNotes
//
//  Created by Professional on 2015-06-22.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
import ConvenienceKit

class NoteDisplayVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: TextView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var toolbarBottomSpace: NSLayoutConstraint!
    
    var note: Note? {
        didSet {
            displayNote(note)
        }
    }
    var edit:Bool?
    var keyboardNotificationHandler: KeyboardNotificationHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        displayNote(self.note)
        
        if (edit != nil) {
            deleteButton.enabled = false
        }
        
        titleTextField.returnKeyType = .Next //1
        titleTextField.delegate = self
        
        keyboardNotificationHandler = KeyboardNotificationHandler()
        
        
        keyboardNotificationHandler!.keyboardWillBeHiddenHandler = { (height: CGFloat) in
            UIView.animateWithDuration(0.3){
                self.toolbarBottomSpace.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        
        keyboardNotificationHandler!.keyboardWillBeShownHandler = { (height: CGFloat) in
            UIView.animateWithDuration(0.3) {
                self.toolbarBottomSpace.constant = height
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote()
    }
    //MARK: Business Logic
    func displayNote(note: Note?) {
        if let note = note, titleTextField = titleTextField, contentTextView = contentTextView  {
            titleTextField.text = note.title
            contentTextView.text = note.content
            
            if count(note.title)==0 && count(note.content)==0 { //1
                titleTextField.becomeFirstResponder()
            }
        }
    }
    
    func saveNote() {
        if let note = note {
            let realm = Realm()
            
            realm.write {
                if (note.title != self.titleTextField.text || note.content != self.contentTextView.textValue) {
                    note.title = self.titleTextField.text
                    note.content = self.contentTextView.textValue
                    note.modificationDate = NSDate()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NoteDisplayVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == titleTextField) {  //1
            contentTextView.becomeFirstResponder()
            contentTextView.returnKeyType = .Done
        }
        
        return false
    }
}
