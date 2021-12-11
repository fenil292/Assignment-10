//
//  Login.swift
//  Assignment-10
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Login: UIViewController {
    private let username:UITextField = {
       let textfield = UITextField()
        textfield.textColor = .black
        textfield.placeholder = "Username"
        textfield.textAlignment = .center
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.layer.cornerRadius = 15.0
        return textfield
    }()
    private let pwd:UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.placeholder = "Password"
        textfield.textAlignment = .center
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.layer.cornerRadius = 15.0
        return textfield
    }()
    private let btnlogin:UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(btn_login), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.4283069782, blue: 1, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login.jpg")!)
        view.backgroundColor = .white
        view.addSubview(username)
        view.addSubview(pwd)
        view.addSubview(btnlogin)
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    @objc func btn_login()
    {
        UserDefaults.standard.setValue(username.text, forKey: "uname")
        self.dismiss(animated: true)
        let vc = Notes()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        username.frame = CGRect(x: 20, y: 250, width: view.width - 40, height: 40)
        pwd.frame = CGRect(x: 20, y: username.bottom + 20, width: view.width - 40, height: 40)
        btnlogin.frame = CGRect(x: 20, y: pwd.bottom + 20, width: view.width - 40, height: 40)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = UserDefaults.standard.string(forKey: "uname")
        {
            let vc=Notes()
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
