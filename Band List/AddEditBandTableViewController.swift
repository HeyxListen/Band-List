//
//  AddEditBandTableViewController.swift
//  Band List
//
//  Created by csuftitan on 11/14/21.
//

import UIKit

class AddEditBandTableViewController: UITableViewController {
    
    var band: Band?
    
    @IBOutlet var artistTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var albumTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    
    init?(coder: NSCoder, band: Band?) {
        self.band = band
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let band = band {
            artistTextField.text = band.name
            genreTextField.text = band.genre
            albumTextField.text = band.famousAlbum
            title = "Editing Band"
        } else {
            title = "Adding Band"
        }
        updateSaveButtonState()
    }
    
    func updateSaveButtonState(){
        let artistText = artistTextField.text ?? ""
        let genreText = genreTextField.text ?? ""
        let albumText = albumTextField.text ?? ""
        saveButton.isEnabled = !artistText.isEmpty && !genreText.isEmpty && !albumText.isEmpty
    }

    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else {
            return
        }
        let name = artistTextField.text ?? ""
        let genre = genreTextField.text ?? ""
        let famousAlbum = albumTextField.text ?? ""
        band = Band(name: name, genre: genre, famousAlbum: famousAlbum)
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}
