//
//  ViewController.swift
//  Photo_Scavenger_Hunt
//
//  Created by Alex Rivas on 2/15/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var taskview: UITableView!
    var photohunt = [photohunttask]()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        taskview.tableHeaderView = UIView()
        taskview.dataSource = self
        photohunt = photohunttask.phototask
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskview.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photohunt.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = taskview.dequeueReusableCell(withIdentifier: "phototaskcell", for: indexPath) as? Phototaskcell else {
            fatalError("Unable to dequeue Task Cell")
        }

        cell.config(with: photohunt[indexPath.row])

        return cell
    }



    override func prepare(for segue:UIStoryboardSegue,sender:Any?){
        if segue.identifier == "newtask" {

            // Since the segue is connected to the navigation controller that manages the ComposeViewController
            // we need to access the navigation controller first...
            if let composeNavController = segue.destination as? UINavigationController,
                // ...then get the actual ComposeViewController via the navController's `topViewController` property.
               let newtaskviewcontroller = composeNavController.topViewController as? newtaskviewcontroller {

                // Update the tasks array for any new task passed back via the `onComposeTask` closure.
                newtaskviewcontroller.newtask = { [weak self] task in
                    self?.photohunt.append(task)
                }
            }

            // Segue to Detail View Controller
        } else if segue.identifier == "detailedsegue" {
            if let detailviewcontroller = segue.destination as? phototaskdetailviewcontroller,
                // Get the index path for the current selected table view row.
               let selectedIndexPath = taskview.indexPathForSelectedRow {

                // Get the task associated with the slected index path
                let phototask = photohunt[selectedIndexPath.row]

                // Set the selected task on the detail view controller.
                detailviewcontroller.phototask = phototask
            }
        }
    }
}

            
