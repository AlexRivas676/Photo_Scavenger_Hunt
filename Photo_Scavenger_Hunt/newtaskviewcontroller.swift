//
//  ViewController2.swift
//  Photo_Scavenger_Hunt
//
//  Created by Alex Rivas on 2/16/23.
//

import UIKit

class newtaskviewcontroller: UIViewController {
    
    @IBOutlet weak var tasktitleField: UITextField!
    @IBOutlet weak var taskdescriptionField:
    UITextField!
    var newtask: ((photohunttask) -> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        

    // When a new task is created, this closure is called, passing in the newly created task.
    
    @IBAction func didTapDoneButton(_ sender: Any) {

        guard let tasktitle = tasktitleField.text,
              let taskdescription = taskdescriptionField.text,
              !tasktitle.isEmpty,
              !taskdescription.isEmpty else {
            EmptyFieldsAlert()
            return
        }

        let phototask = photohunttask(title: tasktitle, desc: taskdescription)
        newtask?(phototask)
        dismiss(animated: true)
    }

    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }

    private func EmptyFieldsAlert() {
        let alert = UIAlertController(
            title: "Oops...",
            message: "Both title and description fields must be filled out",
            preferredStyle: .alert)

        let okAct = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAct)

        present(alert, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
