//
//  Notes.swift
//  Assignment-10
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Notes: UIViewController {
    private let myTable = UITableView()
    /*private let toolBar:UIToolbar = {
        let toolBar = UIToolbar()
        let item1 = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(add_note))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //let item2 = UIBarButtonItem(barButtonSystemItem: .camera, target:self, action: #selector(handleCamera))
        //let item3 = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(handleAdd))
        toolBar.items = [space, item1,space]
        return toolBar
    }()*/
    private let label1:UILabel = {
       let lbl = UILabel()
        lbl.text="Your Notes"
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 30.0)
        lbl.backgroundColor = .white
        lbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return lbl
    }()
    private let label2:UILabel = {
        let lbl = UILabel()
        lbl.text=""
        lbl.font = UIFont(name:"ArialRoundedMT", size: 12.0)
        lbl.backgroundColor = .white
        lbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return lbl
    }()
    private let btnadd:UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.addTarget(self, action: #selector(btn_add), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.4283069782, blue: 1, alpha: 1)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //myButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25
        return btn
    }()
    private let btnlogout:UIButton = {
        let btn = UIButton()
        btn.setTitle("Logout", for: .normal)
        btn.addTarget(self, action: #selector(btn_logout), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.4283069782, blue: 1, alpha: 1)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //myButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25
        return btn
    }()
    private var notes = [String]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        //var files = [String]()
        /*files = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )*/
        //files = FileManagerService.getfiles()
        
        notes = FileManagerService.getfiles()
        label2.text = "\(notes.count) Notes"
        myTable.reloadData()
        //label1.reloadInputViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myTable)
        //view.addSubview(toolBar)
        view.addSubview(label1)
        view.addSubview(btnadd)
        view.addSubview(btnlogout)
        view.addSubview(label2)
        myTable.dataSource = self
        myTable.delegate = self
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "citycell")
        navigationController?.setNavigationBarHidden(true, animated: false)
        /*notes=FileManagerService.getfiles()
        myTable.reloadData()*/
        /*notes=FileManagerService.getfiles()
        myTable.reloadData()*/
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //let toolBarHeight:CGFloat = view.safeAreaInsets.top + 20.0
        label1.frame = CGRect(x: 20, y: 20, width: 180, height: 50)
        label2.frame = CGRect(x: 20, y: label1.bottom-5, width: 100, height: 15)
        //btnadd.frame =
        //toolBar.frame = CGRect(x: 0, y: label1.bottom + 10, width: view.width, height: 40)
        myTable.frame = CGRect(x: 0,y: label2.bottom + 10, width: view.frame.size.width,
                               height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 150)
        btnadd.frame = CGRect(x: label1.right+100, y: 30, width: 50, height: 50)
        btnlogout.frame = CGRect(x: 20, y: myTable.bottom + 10, width: view.width - 40, height: 50)
    }
    
    @objc func btn_add()
    {
        let vc = NewNote()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btn_logout()
    {
        UserDefaults.standard.setValue(nil, forKey: "uname")
        let vc = Login()
        navigationController?.pushViewController(vc, animated: true)
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
extension Notes: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "citycell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print([indexPath.row])
        let vc = NewNote()
        vc.filename = notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let name = notes[indexPath.row]
        let filepath = FileManagerService.getDocDir().appendingPathComponent("\(name).txt")
        do {
            try FileManager.default.removeItem(at: filepath)
            print("delete")
            self.notes.remove(at: indexPath.row)
            label2.text = "\(notes.count) Notes"
            self.myTable.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print(error)
        }
    }
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     if section == 0 {
     return CGRect(x: 0,y: 0, width: view.frame.size.width,
     height: 100)
     }
     }*/
}

