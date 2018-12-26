//
//  ViewController.swift
//  ProjectStructure
//
//  Created by BLT0013-MACMI on 12/18/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        CallAPI()

    }
    func CallAPI()  {
        APIManager().purposeDetails() { (success, purposeModel) in
            if success
            {
                guard purposeModel?.userId != nil else{
                    return
                }
                print(purposeModel?.userId)
                
            }
    
 

}
}
}

