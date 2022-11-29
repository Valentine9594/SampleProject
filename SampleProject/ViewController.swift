//
//  ViewController.swift
//  SampleProject
//
//  Created by Neosoft on 29/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func setupNavigationBar(isHidden: Bool = true) {
        self.navigationController?.isNavigationBarHidden = isHidden
    }
    
}
