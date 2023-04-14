//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Ravi Dwivedi on 14/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    var arrData = [String]()
    @IBOutlet weak var tableView:UITableView!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setPullToRefresh()
    }
    
    private func setUI(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setPullToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string:"Loading...")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func  refreshData(sender:UIRefreshControl){
        arrData.append("Element \(arrData.count)")
        refreshControl.endRefreshing()
        tableView.reloadData()
        
    }
}

//MARK:- UITableViewDataSource

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        cell.textLabel?.text = arrData[indexPath.row]
        return cell
    }
    
}

//MARK:- UITableViewDelegate
extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
