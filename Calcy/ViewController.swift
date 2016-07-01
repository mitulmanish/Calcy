//
//  ViewController.swift
//  Calcy
//
//  Created by Mitul Manish on 1/07/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userIsInTheMiddleOfTyping = false
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        guard let value = sender.currentTitle else {
            print("Not set")
            return
        }
        
        if userIsInTheMiddleOfTyping {
            outputLabel.text = outputLabel.text! + value
        } else {
            outputLabel.text = value
        }
        
        userIsInTheMiddleOfTyping = true
        
    }
    
    @IBAction func matmaticalOperationPerformed(sender: UIButton) {
        
        
        if let operation = sender.currentTitle {
            if operation == "π" {
                outputLabel.text = String(format: "%.3f", M_PI)
            }
        }
        userIsInTheMiddleOfTyping = false
    }
    
}

