//
//  OnboardingContainerVC.swift
//  Bankey
//
//  Created by Davit Natenadze on 04.02.23.
//

import UIKit

protocol OnboardingContainerVCDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerVC: UIViewController {
    
    let pageVC: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    
    weak var delegate: OnboardingContainerVCDelegate?
    
    override func viewDidLoad() {
          super.viewDidLoad()
        setup()
        style()
        layout()
      }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
         self.pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
         
        let page1 = OnboardingVC(heroImageName: "delorean", titleText: "Bankey is faster, easier to use and has a brand new look and feel, that will make you feel, like you are back in 1989.")
         let page2 = OnboardingVC(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
         let page3 = OnboardingVC(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com.")
         
         pages.append(page1)
         pages.append(page2)
         pages.append(page3)
         
         currentVC = pages.first!
         
         super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    
    private func setup() {
        
        view.backgroundColor = .systemBlue
        addChild(pageVC)
        view.addSubview(pageVC.view)
      pageVC.didMove(toParent: self)
      pageVC.dataSource = self
      pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageVC.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageVC.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageVC.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageVC.view.bottomAnchor),
        ])
        
      pageVC.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
    }
    
  }

  // MARK: - UIPageViewControllerDataSource

extension OnboardingContainerVC: UIPageViewControllerDataSource {
    

      func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
          return getPreviousViewController(from: viewController)
      }

      func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
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

// MARK: - Actions

extension OnboardingContainerVC {
    
    @objc func closeTapped() {
        delegate?.didFinishOnboarding()
     }
}
