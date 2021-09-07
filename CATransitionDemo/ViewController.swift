//
//  ViewController.swift
//  CATransitionDemo
//
//  Created by Jake Chasan on 6/1/16.
//  Copyright © 2016 Jake Chasan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Class Variables
    let transitions = ["oglFlip", "pageCurl", "pageUnCurl", "fade", "cube", "moveIn", "push", "reveal", "rippleEffect", "suckEffect", "cameraIris"];
    let directions = [CATransitionSubtype.fromLeft, CATransitionSubtype.fromRight, CATransitionSubtype.fromTop, CATransitionSubtype.fromBottom];
    let durations = [0.0, 0.15, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0];
    
    var imageName = "imageA.jpg";
    
    // MARK: Outlets
    @IBOutlet var transitionPicker: UIPickerView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        pickerView.delegate = self;
        pickerView.dataSource = self;
        
        pickerView.selectRow(transitions.count / 2, inComponent: 0, animated: false);
        pickerView.selectRow(directions.count / 2, inComponent: 1, animated: false);
        pickerView.selectRow(durations.count / 2, inComponent: 2, animated: false);
    }
    
    //Called when "View Transition" button tapped
    @IBAction func showTransition(_ sender: UIButton) {
        //Initialize the transition
        let animation = CATransition()
        
        //Set transition properties
        animation.type = CATransitionType(rawValue: transitions[pickerView.selectedRow(inComponent: 0)])
        animation.subtype = directions[pickerView.selectedRow(inComponent: 1)]
        animation.duration = durations[pickerView.selectedRow(inComponent: 2)]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        //Switch the image
        if imageName == "imageA.jpg" {
            imageView.image = UIImage(named: "imageB.jpg")
            imageName = "imageB.jpg"
        } else {
            imageView.image = UIImage(named: "imageA.jpg")
            imageName = "imageA.jpg"
        }
        
        //Add transition to imageView, so that the entire view does not refresh
        imageView.layer.add(animation, forKey: "animation")

    }
    
}


// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return transitions.count
            
        case 1:
            return directions.count
            
        case 2:
            return durations.count
            
        default:
            return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
}

extension ViewController: UIPickerViewDelegate {
    
    //This method is only necessary because the cameraIris transition sometimes does not go away after the animation is complete
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.view.layoutIfNeeded()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            return transitions[row]
            
        case 1:
            return directions[row].rawValue
            
        case 2:
            return String(durations[row]) + "s"
            
        default:
            return ""
        }
    }
    
}
