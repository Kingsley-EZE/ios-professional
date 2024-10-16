//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Ugwuta Kingsley on 03/10/2024.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    let previousButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    var currentIndex = 0
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989.")
        let page2 = OnboardingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
        let page3 = OnboardingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        style()
        layout()
    }
    
    private func setUp(){
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
        previousButton.isHidden = true
        doneButton.isHidden = true
    }
    
    private func style(){
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Skip", for: [])
        //closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        closeButton.addTarget(self, action: #selector(didTapClose), for: .primaryActionTriggered)
        view.addSubview(closeButton)
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.setTitle("Previous", for: [])
        previousButton.addTarget(self, action: #selector(previousTapped), for: .primaryActionTriggered)
        view.addSubview(previousButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        view.addSubview(nextButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(didTapDone), for: .primaryActionTriggered)
        view.addSubview(doneButton)
        
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: closeButton.trailingAnchor, multiplier: 2),
            
            previousButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            previousButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        currentIndex = pages.firstIndex(of: viewController) ?? 0
        if currentIndex > 0 {
            previousButton.isHidden = false
        }else{
            previousButton.isHidden = true
        }
        
        if currentIndex == pages.count - 1 {
            nextButton.isHidden = true
            doneButton.isHidden = false
        }else{
            nextButton.isHidden = false
            doneButton.isHidden = true
        }
        
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        currentIndex = pages.firstIndex(of: viewController) ?? 0
        if currentIndex > 0 {
            previousButton.isHidden = false
        }else{
            previousButton.isHidden = true
        }
        
        if currentIndex == pages.count - 1 {
            nextButton.isHidden = true
            doneButton.isHidden = false
        }else{
            nextButton.isHidden = false
            doneButton.isHidden = true
        }
        
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

//MARK: - Actions
extension OnboardingContainerViewController {
    
    @objc func previousTapped(){
        /*if currentIndex > 0 {
            currentIndex -= 1
            pageViewController.setViewControllers([pages[currentIndex]], direction: .reverse, animated: true)
        }*/
    }
    
    @objc func nextTapped(){
        /*if currentIndex < pages.count - 1 {
            currentIndex += 1
            pageViewController.setViewControllers([pages[currentIndex]], direction: .forward, animated: true)
        }*/
    }
    
    @objc func didTapDone(){
        delegate?.didFinishOnboarding()
    }
    
    
    @objc func didTapClose(){
        delegate?.didFinishOnboarding()
    }
    
    @objc func doneTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
}
