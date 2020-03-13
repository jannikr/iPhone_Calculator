//
//  ViewController.swift
//  Taschenrechner
//
//  Created by Rückert, Jan on 11.10.19.
//  Copyright © 2019 Rückert, Jan. All rights reserved.
//
//  v2
//  - Operations log (size 5)
//  - Positive / Negative indicator
//  - Code optimazation


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var lastOperations: UILabel!
    @IBOutlet weak var orPN: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var first : Bool = true;
    var zahl1 : String = "";
    var zahl2 : String = "";
    var operations : [String] = [];

    @IBAction func number(_ sender: UIButton) {
        if (first){
            zahl1 += String(sender.tag);
            displayLabel.text = zahl1;
        } else {
            zahl2 += String(sender.tag);
            displayLabel.text = zahl2;
        }
        
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        //every time user use enterButton:
        
        //use second number
        first = false;
        //delete label-contet
        displayLabel.text = "";
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        
        //shows the last 5 operations
        func showOperation (_ operation : String) {
            if (operations.count > 4){
                operations.removeFirst(1);
            }
            operations.append(operation)
            lastOperations.text = operations.description
        }
        
        var ergebnis : Double!
        var stringOperation : String!
        
        switch sender.tag {
        case 10:
            ergebnis = (Double(zahl1)! * Double(zahl2)!);
            stringOperation = String(zahl1) + " * " + String(zahl2);
        case 11:
            ergebnis = (Double(zahl1)! - Double(zahl2)!);
            stringOperation = String(zahl1) + " - " + String(zahl2);
        case 12:
            ergebnis = (Double(zahl1)! + Double(zahl2)!);
            stringOperation = String(zahl1) + " + " + String(zahl2);
        case 13:
            ergebnis = (Double(zahl1)! / Double(zahl2)!);
            stringOperation = String(zahl1) + " / " + String(zahl2);
        default:
            print("Falsche Reihenfolge der Eingabe!")
        }
        
        //Call function to store operations
        showOperation(stringOperation);
        
        //Check Number: negative -> N, positive -> P
        (ergebnis<0) ? (orPN.text = "N") : (orPN.text = "P");
        
        //Refresh display
        displayLabel.text = String(ergebnis);
        
        //Prepare for next operation
        zahl1 = String(ergebnis);
        zahl2 = "";
        
        
    }
    
    @IBAction func startFromZero(_ sender: Any) {
        zahl1 = "";
        zahl2 = "";
        displayLabel.text = "0";
        operations = [];
        lastOperations.text = "Hinweis: AC löscht alle bisherigen Operationen!";
        first = true;
        
    }
}
