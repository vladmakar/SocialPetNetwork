//
//  LoginViewController.swift
//  SocialPetNetwork
//
//  Created by Влад Макар on 2019-08-01.
//  Copyright © 2019 Влад Макар. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        doLogin()
        print("clicked")
    }
    @IBAction func signupButton(_ sender: Any) {
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func doLogin() -> Bool {
        let email = (emailInput.text)!
        let pass = passwordInput.text
        
        if( isValidEmail(emailStr: email) ){
            makeLoginRequest(email: email, pass: pass!)
        }
        return false
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func makeLoginRequest(  email : String , pass : String)-> String{
        let json: [String : Any] = ["email" : email, "password" : pass]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // creat post request
        let url = URL(string: "https://178.128.225.124:8443/login")
        
        var request = URLRequest(url: url!, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60.0)
        
        request.httpMethod = "POST"
        request.httpBody = jsonData
        print(jsonData)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,   error == nil else {
                print(error?.localizedDescription ?? "No Data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            
        }
        task.resume()
        return " " ;
    }
}
//performSegue(withIdentifier: "mainPage", sender: self)
