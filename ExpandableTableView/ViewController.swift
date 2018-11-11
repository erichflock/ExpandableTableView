//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by Erich Flock on 01.11.18.
//  Copyright © 2018 flock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var titleLabel: UILabel!
    
    var numberOfSections : Int?
    var numberOfRows : Int?
    
    var tableViewDatas: [TableViewData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.text  = "Expandable TableView With Customized Cells And ScrollView"
        
        // Create the data that willbe displayed in the sections and rows
        let tableViewData1 = TableViewData(isExpandable: false, sectionTitle: "First Section", rowTitle: "First Row")
        let tableViewData2 = TableViewData(isExpandable: false, sectionTitle: "Second Section", rowTitle: "Second Row")
        let tableViewData3 = TableViewData(isExpandable: false, sectionTitle: "Third Section", rowTitle: "Third Row")
        let tableViewData4 = TableViewData(isExpandable: false, sectionTitle: "Fourth Section", rowTitle: "Fourth Row")
        let tableViewData5 = TableViewData(isExpandable: false, sectionTitle: "Fifth Section", rowTitle: "Fifth Row")
        let tableViewData6 = TableViewData(isExpandable: false, sectionTitle: "Sixth Section", rowTitle: "Sixth Row")
    
        tableViewDatas.append(contentsOf: [tableViewData1, tableViewData2, tableViewData3, tableViewData4, tableViewData5, tableViewData6])
        
        numberOfSections = tableViewDatas.count
        numberOfRows = 3 // it can be any number
        tableView.register(UINib(nibName: "SectionTableViewCell", bundle: nil), forCellReuseIdentifier: "SectionTableViewCell")
        tableView.register(UINib(nibName: "SectionInRowTableViewCell", bundle: nil), forCellReuseIdentifier: "SectionInRowTableViewCell")
    }
    
    /// check how many sections are opened. It is used to calculate the correct table view height. 
    
    func getNumberOfSectionsOpened() -> Int {
        
        var numberOfSectionsOpened = 0
        for tableViewData in tableViewDatas {
            
            if tableViewData.isExpandable {
                numberOfSectionsOpened += 1
            }
        }
        
        return numberOfSectionsOpened
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewHeightConstraint.constant = CGFloat((numberOfSections ?? 0) * 48)
        return numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfRowsInSection = numberOfRows else { return 1 }
        guard let numberOfSections = numberOfSections else { return 1 }
        
        let numberOfSectionsOpened = getNumberOfSectionsOpened()
        
        if numberOfSectionsOpened > 0 {
            tableViewHeightConstraint.constant = CGFloat(numberOfRowsInSection * numberOfSectionsOpened * 48) + CGFloat(numberOfSections * 48)
        } else {
            tableViewHeightConstraint.constant = CGFloat(numberOfSections * 48)
        }
        
        if tableViewDatas[section].isExpandable {
            return numberOfRowsInSection + 1 // it always consider the section (header) as a row, so  in  order todisplay the correct number of rows, you should add 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            // SECTION
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "SectionTableViewCell") as? SectionTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = .green
            cell.titleLabel.text = tableViewDatas[indexPath.section].sectionTitle
            
            return cell
        } else {
            // ROW
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "SectionInRowTableViewCell") as? SectionInRowTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = .yellow
            cell.titleLabel.text = tableViewDatas[indexPath.section].rowTitle
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableViewDatas[indexPath.section].isExpandable {
            // close
           tableViewDatas[indexPath.section].isExpandable = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            // open
            tableViewDatas[indexPath.section].isExpandable = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
}

struct TableViewData {
    var isExpandable: Bool
    var sectionTitle: String
    var rowTitle: String
}

