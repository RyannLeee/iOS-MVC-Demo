//
//  LEESwiftVC.swift
//  LEEDemoForMVC
//
//  Created by yuanlee on 2019/8/25.
//  Copyright © 2019 YuanLee. All rights reserved.
//

import Foundation

class LEESwiftVC : LEEBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var large = LargeImageView()
    private let buttonTag = 10001
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SwiftTableView"
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: width(self.view), height: heigit(self.view)), style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = .zero
        self.tableView.separatorInset = .zero
        self.view.addSubview(self.tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "reuse"
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: reuseIdentifier)
        }
        if indexPath.row == 0 {
            cell.textLabel?.text = "hello"
        } else {
            cell.textLabel?.text = "world"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == UITableViewCell.AccessoryType.disclosureIndicator {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .disclosureIndicator
        }
        
    }
    
    /**
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SwiftTest-LEE"
        self.view.frame = CGRect.init(x: 0, y: statusBarAndNavigationBarHeight, width: MainScreenWidth, height: MainScreenHeight - statusBarAndNavigationBarHeight)
        self.view.backgroundColor = UIColor.white//GlobalColor //RGBColor(0x98CB00)
        //large.frame = CGRect.init(x: 0, y:autoScaleH(0), width: MainScreenWidth, height: heigit(self.view))
        //let image = UIImage.init(named: "BigPic2")
        //large.setImage((UIImage.init(named: "BigPic2") ?? nil)!)
        //self.view.addSubview(large)
        //NSLog("\(large)")
        
        for num in 0...2 {
            let button = UIButton.init(type: .custom)
            button.tag = num + buttonTag
            button.frame = CGRect.init(x: 30, y: 80 * num + 100, width: 100, height: 35)
            button.setTitleColor(GlobalColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: autoScaleF(17))
            button.layer.borderColor = GlobalColor.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 15
            switch num {
            case 0:
                button.setTitle(String.init("\(num)" + " AddNotificationObserver"), for: .normal)
                button.addTarget(self, action: #selector(addNotiObser), for: .touchUpInside)
            case 1:
                button.setTitle(String.init("\(num)" + " PostNotification"), for: .normal)
                button.addTarget(self, action: #selector(postNoti), for: .touchUpInside)
            case 2:
                button.setTitle(String.init("\(num)" + " RemoveNotificationObserver"), for: .normal)
                button.addTarget(self, action: #selector(removeNotiObser), for: .touchUpInside)
            default:
                break
            }
            button.width = button.sizeThatFits(CGSize.zero).width + 30
            button.centerX = self.view.width / 2;
            self.view.addSubview(button)
        }
    }
    
    @objc func notiReceive(_ notification: NSNotification) {
        print("Did receive notification: \(notification.name)")
    }
    
    @objc func addNotiObser() {
        print("Did add notification observer")
        LEEAddNotificationObserver(self, #selector(notiReceive(_:)), "yuanlee")
    }
    
    @objc func postNoti() {
        print("Did post notification")
        LEEPostNotification("yuanlee")
    }
    
    @objc func removeNotiObser() {
        print("Did remove notification observer")
        LEERemoveNotificationObserver(self)
    }
 */
}
