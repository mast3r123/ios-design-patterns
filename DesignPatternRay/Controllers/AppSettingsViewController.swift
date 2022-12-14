//
//  AppSettingsViewController.swift
//  DesignPatternRay
//
//  Created by master on 9/15/22.
//

import UIKit

public class AppSettingsViewController: UITableViewController {
    
    //MARK: - Properties
    public let appSettings = AppSettings.shared
    private let cellIdentifier = "basicCell"
    
    //MARK: - View life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
}

//MARK: - UITableViewDataSource
extension AppSettingsViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionStrategyType.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let strategyType = QuestionStrategyType.allCases[indexPath.row]
        cell.textLabel?.text = strategyType.title()
        
        if appSettings.questionStrategyType == strategyType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension AppSettingsViewController {
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        appSettings.questionStrategyType = questionStrategyType
        tableView.reloadData()
    }
}
