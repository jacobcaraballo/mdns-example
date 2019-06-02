//
//  TableVC.swift
//  mDNS
//
//  Created by Pasquale Antonante on 15/05/16.
//  Copyright © 2016 Pasquale Antonante. All rights reserved.
//

import UIKit

class TableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
	var reflectBrowser: MDNSBrowser!
    @IBOutlet weak var servicesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		reflectBrowser = MDNSBrowser(type: "_jacobc._tcp.") {
			self.servicesTable.reloadData()
		}
        reflectBrowser.start()
        
        servicesTable.delegate = self
        servicesTable.dataSource = self
		
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reflectBrowser.mdnsList.count
	}
    
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "beacubeServiceCell", for: indexPath) as UITableViewCell
        let service = reflectBrowser.mdnsList[indexPath.row]
        cell.textLabel?.text = service.name
        cell.detailTextLabel?.text = service.ip + ":" + String(service.port)
        return cell
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let service = reflectBrowser.mdnsList[indexPath.row]
		service.write(string: "Hello, World!")
	}
    
}
