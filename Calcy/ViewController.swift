//
//  ViewController.swift
//  Calcy
//
//  Created by Mitul Manish on 1/07/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var userIsInTheMiddleOfTyping = false
    
    private var brain = CalculatorBrain()
    
    @IBOutlet private weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func touchDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        
        get { return Double(display.text!)! }
        
        set { display.text = String(newValue) }
    }
    
    
    @IBAction private func performOperation(sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        } 
        
        if let mathematicalOperation = sender.currentTitle {
            brain.performOperation(mathematicalOperation)
        }
        displayValue = brain.result
    }
    
    
}

