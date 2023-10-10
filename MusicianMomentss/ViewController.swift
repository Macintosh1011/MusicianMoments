//
//  ViewController.swift
//  MusicianMomentss
//
//  Created by Idan Kestenbom on 10/4/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Login"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        emailField.layer.borderWidth = 2
        emailField.layer.sublayerTransform = CATransform3DMakeTranslation(4, 0, 0)
        emailField.textColor = .white
        emailField.layer.borderColor = UIColor.white.cgColor
        emailField.layer.cornerRadius = 10
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passField = UITextField()
        passField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        passField.layer.borderWidth = 2
        passField.textColor = .white
        passField.layer.sublayerTransform = CATransform3DMakeTranslation(4, 0, 0)
        passField.isSecureTextEntry = true
        passField.layer.borderColor = UIColor.white.cgColor
        passField.layer.cornerRadius = 10
        return passField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 123/255, green: 16/255, blue: 32/255, alpha: 1)
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            
            let alert = UIAlertController(title: "Missing Email/Password", message: "Being gay for Ayaan Khan is not cool Neel", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        //Get auth instance
        //attempt sign in
        //if failure, present alert to create account
        //if user continues, create account
        
        //check sign in on app launch
        //allow user to sign out with button
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                // show account creation
                print("Account creation failed")
                return
            }
            
            print("you have signed in")
            strongSelf.label.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.button.isHidden = true
        })
        

    }
    
    
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in})
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            
            
            
            
            
            
        }))
        
        present(alert, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
        
        
        emailField.frame = CGRect(x: 20, y: label.frame.origin.y+label.frame.size.height+10, width: view.frame.size.width-40, height: 80)
        
        passwordField.frame = CGRect(x: 20, y: emailField.frame.origin.y+emailField.frame.size.height+10, width: view.frame.size.width-40, height: 80)
        
        button.frame = CGRect(x: 20, y: passwordField.frame.origin.y+passwordField.frame.size.height+10, width: view.frame.size.width-40, height: 80)
        
    }
    
    }





