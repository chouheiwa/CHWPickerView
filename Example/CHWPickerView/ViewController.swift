//
//  ViewController.swift
//  CHWPickerView
//
//  Created by chouheiwa on 06/13/2019.
//  Copyright (c) 2019 chouheiwa. All rights reserved.
//

import UIKit
import CHWPickerView


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }
    @IBAction func showAction(_ sender: Any) {
        CHWPickerView.show(in: self.view, with: ["test", "test1", "test2", "test", "test1", "test2", "test", "test1", "test2"], stringConverter: nil) {
            print("\($0) \($1)")
        }
    }

    @IBAction func showDateAction(_ sender: Any) {
        let settings = CHWDatePickerViewSettings()

        settings.locale = .init(identifier: "zh_CN")
        settings.maxShowDate = Date()

        CHWDatePickerView.show(in: self.view, settings: settings) {
            print($0)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

