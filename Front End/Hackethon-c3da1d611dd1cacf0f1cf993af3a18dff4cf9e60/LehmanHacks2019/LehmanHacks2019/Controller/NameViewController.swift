//
//  NameViewController.swift
//  LehmanHacks2019
//
//  Created by Sabri Sönmez on 11/16/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit
import Lottie

class NameViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var animationView: LOTAnimatedControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        playAnimation(animationName: "2113-dog")
    }
    
    func playAnimation(animationName: String)
    {
        animationView.animationView.setAnimation(named: "\(animationName)")
        animationView.animationView.loopAnimation = true
        animationView.animationView.play()
    }
    
    @objc func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height + 50
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @IBAction func continuePressed(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
       self.performSegue(withIdentifier: "secondSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "secondSegue") {
            let vc = segue.destination as! DrawViewController
            vc.name = nameTextField.text!
        }
    }
    
}
