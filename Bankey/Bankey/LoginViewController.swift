//
//  ViewController.swift
//  Bankey
//
//  Created by Ugwuta Kingsley on 01/10/2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    let appTitle = UILabel()
    let appSubtitle = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        style()
        layout()
        
    }

}

extension LoginViewController {
    
    private func style(){
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: [])
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.isHidden = true
        
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        appTitle.text = "Bankey"
        appTitle.numberOfLines = 0
        appTitle.textColor = .black
        appTitle.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        appTitle.textAlignment = .center
        
        appSubtitle.translatesAutoresizingMaskIntoConstraints = false
        appSubtitle.text = "Your premium source for all \nthing banking!"
        appSubtitle.textColor = .black
        appSubtitle.numberOfLines = 0
        appSubtitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        appSubtitle.textAlignment = .center
    }
    
    private func layout(){
        view.addSubview(appTitle)
        view.addSubview(appSubtitle)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            //App title view
            appTitle.bottomAnchor.constraint(equalTo: appSubtitle.topAnchor, constant: -24),
            appTitle.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appTitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            //Subtitle view
            appSubtitle.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -16),
            appSubtitle.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appSubtitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            //LoginView
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            //Button
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            //Error Label
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
    
}

//MARK: - Actions
extension LoginViewController {
    
    @objc private func signInTapped(sender: UIButton){
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login(){
        guard let username = username, let password = password else {
            assertionFailure("Username && Password must not be nil")
            return
        }
        if username.isEmpty || password.isEmpty {
            configureErrorView(withMessage: "Username / Password cannot be empty")
            return
        }
        if username == "Bob" && password == "bob" {
            signInButton.configuration?.showsActivityIndicator = true
        }else{
            configureErrorView(withMessage: "Incorrect Username / Password")
        }
    }
    
    private func configureErrorView(withMessage message: String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}

#Preview{
    LoginViewController()
}
