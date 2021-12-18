//
//  BandListTableViewController.swift
//  Band List
//
//  Created by csuftitan on 11/5/21.
//

import UIKit

class BandListTableViewController: UITableViewController {
    
  
    //let albumImages: [UIImage] = [UIImage(named: "TS"), UIImage(1975)]
    
    var bands: [Band] = [] {
        didSet {
            Band.saveToFile(bands: bands)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let savedBands = Band.loadFromFile() {
            bands = savedBands
        } else {
            bands = Band.sampleBands
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bands.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BandCell", for: indexPath) as! BandTableViewCell
        let band = bands[indexPath.row]
        
        cell.update(with: band)
        cell.showsReorderControl = true
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let band = bands[indexPath.row]
//        print("\(band.name) \(indexPath)")
//    }

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    @IBSegueAction func addEditBand(_ coder: NSCoder, sender: Any?) -> AddEditBandTableViewController? {
        if let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell) {
            let bandToEdit = bands[indexPath.row]
            return AddEditBandTableViewController(coder: coder, band: bandToEdit)
        } else {//Adding Emoji
        return AddEditBandTableViewController(coder: coder, band: nil)
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bands.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedBand = bands.remove(at: fromIndexPath.row)
        bands.insert(movedBand, at: to.row)
    }
    
    @IBAction func unwindToBandTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source as? AddEditBandTableViewController,
              let band = sourceViewController.band else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            bands[selectedIndexPath.row] = band
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: bands.count, section: 0)
            bands.append(band)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
