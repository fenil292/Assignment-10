//
//  NewNoteVC.swift
//  myFileManager
//
//  Created by DCS on 03/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewNote: UIViewController {
    var filename:String?
    private let nameTextField:UITextField = {
        let textFiled = UITextField()
        textFiled.textColor = .black
        textFiled.placeholder = "Enter Note Title"
        textFiled.textAlignment = .center
        textFiled.backgroundColor = .white
        
        textFiled.layer.borderWidth = 1
        return textFiled
    }()
    
    private let contentTextView:UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = .systemFont(ofSize: 16)
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.layer.borderWidth = 1
        return textView
    }()
    
    private let saveButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        btn.backgroundColor = .blue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    /*private let deleteButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Delete", for: .normal)
        btn.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameTextField)
        
        view.addSubview(contentTextView)
        view.addSubview(saveButton)
        if let file = filename {
            nameTextField.text = file
            do {
                let filepath = FileManagerService.getDocDir().appendingPathComponent("\(file).txt")
                let fetchedContent = try String(contentsOf: filepath)
                print(fetchedContent)
                contentTextView.text = fetchedContent
            } catch {
                print(error)
            }
        }
        navigationController?.setNavigationBarHidden(false, animated: false)
        //view.addSubview(deleteButton)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextField.frame = CGRect(x: 40, y: 100, width: view.width - 80, height: 40)
        contentTextView.frame = CGRect(x: 40, y: nameTextField.bottom + 20, width: view.width - 80, height: 300)
        saveButton.frame = CGRect(x: 40, y: contentTextView.bottom + 20, width: view.width - 80, height: 40)
        
        //deleteButton.frame = CGRect(x: 40, y: saveButton.bottom + 20, width: view.width - 80, height: 40)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*do {
            let filepath = FileManagerService.getDocDir().appendingPathComponent("Ttt.txt")
            let fetchedContent = try String(contentsOf: filepath)
            print(fetchedContent)
            contentTextView.text = fetchedContent
        } catch {
            print(error)
        }*/
        
    }
    
    @objc private func saveNote()
    {
        let name = nameTextField.text!
        let content = contentTextView.text!
        let filePath = FileManagerService.getDocDir().appendingPathComponent("\(name).txt")
        do {
            try content.write(to: filePath, atomically: true, encoding: .utf8)
            var msg = "New Note Added."
            if filename != nil
            {
                filename = nil
                msg = "Note Updated."
            }
            var alert = UIAlertController()
            alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            nameTextField.text = ""
            contentTextView.text = ""
        } catch {
            print(error)
        }
    }
    
    @objc private func deleteNote()
    {
        /*let filepath = FileManagerService.getDocDir().appendingPathComponent("Temp.txt")
        do {
            try FileManager.default.removeItem(at: filepath)
            print("delete")
        } catch {
            print(error)
        }*/
        
    }
}
