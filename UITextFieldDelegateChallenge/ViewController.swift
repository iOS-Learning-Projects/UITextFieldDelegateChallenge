//
//  ViewController.swift
//  UITextFieldDelegateChallenge
//
//  Created by Eduardo Vital Alencar Cunha on 30/05/17.
//  Copyright © 2017 Vital. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!

    @IBAction func submit(_ sender: UIButton) {
        NSLog("email: %@\nidade: %@\npassword: %@",
              self.emailTextFiled.text!,
              self.ageTextField.text!,
              self.passwordTextField.text!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createToolbarOfNumberPadInAgeTextField()

        // Add TapGesture that hide Keyboards
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    func hideKeyboard() {
        self.ageTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.emailTextFiled.resignFirstResponder()
    }

    func createToolbarOfNumberPadInAgeTextField() {
        // Creating Toolbar of NumberPad
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        numberToolbar.barStyle = .blackTranslucent

        // Creating BarButtonItems to the Toolbar of NumberPad
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelNumberPad))
        cancelBarButtonItem.tintColor = UIColor.white
        let spaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.goToNextFieldAfterNumberPad))
        doneBarButtonItem.tintColor = UIColor.white

        // Add BarButtonItems to Toolbar of NumberPad
        numberToolbar.items = [
            cancelBarButtonItem,
            spaceBarButtonItem,
            doneBarButtonItem
        ]
        numberToolbar.sizeToFit()

        // Add Toolbar to input acessory of ageTextField
        self.ageTextField.inputAccessoryView = numberToolbar
    }

    func cancelNumberPad() {
        self.ageTextField.resignFirstResponder()
    }

    func goToNextFieldAfterNumberPad(_ sender: UITextField) {
        self.view.viewWithTag(self.ageTextField.tag + 1)?.becomeFirstResponder()
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            self.view.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == .done {
            self.submit(self.submitButton)
        }
        return true
    }
}
