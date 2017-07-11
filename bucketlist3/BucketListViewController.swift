//
//  ViewController.swift
//  bucketlist3
//
//  Created by Placoderm on 7/10/17.
//  Copyright © 2017 Placoderm. All rights reserved.
//

import UIKit

//CancelButtonDelegate sets BLVC as CBD
class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {

    var items = ["Go to moon", "Eat a candy bar", "Swim in the ocean"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //num of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //cells
    override func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    //swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    ////listen for user to select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected")
    //    //perform segue given sender
    //    performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    //listen for user to click on arrow
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //perform segue given sender
        performSegue(withIdentifier: "AddItemSegue", sender: indexPath)
    }
    
    //delegate - control cancel of modal view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //if something sent
        if let send_me = sender {
            
            //if sender is from bar button
            if send_me is UIBarButtonItem {
                let navigationController = segue.destination as! UINavigationController
                let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
                
                addItemTableViewController.delegate = self
            }
                
            //if sender is from accessory button
            else {
                let navigationController = segue.destination as! UINavigationController
                let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
                
                addItemTableViewController.delegate = self
                
                let indexPath = sender as! NSIndexPath //sender used
                print("SENDER:",indexPath)
                let item = items[indexPath.row]
                
                addItemTableViewController.item = item
                addItemTableViewController.indexPath = indexPath
            }
        }
        //if no sender
        else {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
        }
        
        ////click on add item
        //if segue.identifier == "AddItemSegue" {
            
        //    let navigationController = segue.destination as! UINavigationController
        //    let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            
        //    addItemTableViewController.delegate = self
        //}
            
        ////click on a row
        //else if segue.identifier == "EditItemSegue" {
            
        //    let navigationController = segue.destination as! UINavigationController
        //    let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            
        //    addItemTableViewController.delegate = self
            
        //    let indexPath = sender as! NSIndexPath //sender used
        //    print("SENDER:",indexPath)
        //    let item = items[indexPath.row]
            
        //    addItemTableViewController.item = item
        //    addItemTableViewController.indexPath = indexPath
        //}
    }
    //function that lets BLVC be CBD //cancel
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        print("I'm the hidden controller, but I am responding to the CANCEL button press on the top view controller")
        
        dismiss(animated: true, completion: nil)
    }
    //function that lets BLVC be CBD //save
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        
        if let ip = indexPath {
            items[ip.row] = text
        }
        
        else {
            print("Received Text from Top View: \(text)")
            items.append(text)
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

