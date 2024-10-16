//
//  DummyViewController.swift
//  Bankey
//
//  Created by Ugwuta Kingsley on 16/10/2024.
//

import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    
    weak var delegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    
}

extension DummyViewController {
    
    func style(){
        view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: [])
        logoutButton.configuration = .filled()
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .primaryActionTriggered)
    }
    
    func layout(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}

//Actions
extension DummyViewController {
    @objc func didTapLogout(sender: UIButton){
        delegate?.didLogout()
    }
}
