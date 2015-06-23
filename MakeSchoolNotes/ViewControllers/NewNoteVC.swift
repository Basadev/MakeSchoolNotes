//
//  NewNoteVC.swift
//  MakeSchoolNotes
//
//  Created by Professional on 2015-06-22.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit

class NewNoteVC: UIViewController {

    var currentNote:Note?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new View Controller using segue.destinationViewController.
        // Pass the selected object to the new View Controller.
        
        if (segue.identifier == "ShowNewNote") {
            // create a new Note and hold onto it, to be able to save it later
            currentNote = Note()
            let noteViewController = segue.destinationViewController as! NoteDisplayVC
            noteViewController.note = currentNote
            noteViewController.edit = true
        }
    }
    

}
