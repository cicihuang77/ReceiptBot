//
//  LogTableViewController.swift
//  ReceiptBot
//
//  Created by Jen on 4/9/18.
//  Copyright © 2018 iOS Decal - Jenny | CiCi | Victor. All rights reserved.
//

import UIKit

class LogTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var logTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedReceipts: [Receipt] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedReceipts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = logTableView.dequeueReusableCell(withIdentifier: "receiptCell") as? LogTableViewCell {
            let receipt = savedReceipts[indexPath.row]
            cell.category.text = receipt.category
            cell.amount.text = "\(String(describing: receipt.amount))"
            cell.date.text = "\(String(describing: receipt.date))"
            return cell
        }
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        logTableView.delegate = self
        logTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Allows user to delete dogs from the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let log = savedReceipts[indexPath.row]
            context.delete(log)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            // now that we've deleted a dog, need to update the savedDogs array again
            fetchDogsFromCoreData()
        }
        tableView.reloadData()
    }
    
    /// Uses the App Delegate's Context to get the dogs saved to Core Data
    func fetchDogsFromCoreData() {
        do {
            savedReceipts = try context.fetch(Receipt.fetchRequest())
        } catch {
            print("Fetching receipts from Core Data failed :( ")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}