//
//  Phototaskcell.swift
//  Photo_Scavenger_Hunt
//
//  Created by Alex Rivas on 2/21/23.
//

import UIKit

class Phototaskcell: UITableViewCell {
    @IBOutlet weak var tasktitlelabel :UILabel!
    @IBOutlet weak var taskcompleteimageview:UIImageView!
    func config(with phtotask:photohunttask){
        tasktitlelabel.text = phtotask.title
        tasktitlelabel.textColor =  phtotask.taskcomplete ? .secondaryLabel:.label
        taskcompleteimageview.image = UIImage(systemName: phtotask.taskcomplete ? "circle.inset.filled": "circle")?.withRenderingMode(.alwaysTemplate)
        taskcompleteimageview.tintColor = phtotask.taskcomplete ? .systemGreen : .tertiaryLabel
        
        
        
    }

}
