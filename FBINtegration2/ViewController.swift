//
//  ViewController.swift
//  FBINtegration2
//
//  Created by R Shantha Kumar on 1/22/20.
//  Copyright © 2020 R Shantha Kumar. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    func loginManager (_ result:LoginResult){
        
        
        switch result {
        case .cancelled:
            print("login cancelled")
        case .failed(let error):
            print("login failed")
            case .success(let grantedERmisson,let declined,let token    ):
                let target = storyboard?.instantiateViewController(identifier: "facebook2") as! FacebookViewController
                
                present(target, animated: true, completion: nil)
                
                
            print("login success")
       
        }
        
        
    }
    
    @IBAction func login(_ sender: Any) {
        
        
        let login = LoginManager()
        
        login.logIn(permissions: [.publicProfile,.userFriends], viewController: self) { (LogiResult) in
            
            
            self.loginManager(LogiResult)
            
            
            
            
            
        }
        
    }
    
    
    

}

