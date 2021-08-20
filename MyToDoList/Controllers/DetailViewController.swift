//
//  DetailViewController.swift
//  MyToDoList
//
//  Created by doyun on 2021/08/18.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedItem:Item?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designLabel(dateLabel)
        designLabel(titleLabel)
        designLabel(subtitleLabel)
        setLabel()
    }

    func setLabel(){
        dateLabel.text = selectedItem?.date
        titleLabel.text = selectedItem?.title
        subtitleLabel.text = selectedItem?.subtitle
    }
    
    func designLabel(_ label:UILabel){
        label.layer.cornerRadius = 10
    }
    

}
