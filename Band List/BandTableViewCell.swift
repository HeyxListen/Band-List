//
//  BandTableViewCell.swift
//  Band List
//
//  Created by csuftitan on 11/14/21.
//

import UIKit

class BandTableViewCell: UITableViewCell {
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var albumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with band: Band) {
        artistLabel.text = band.name
        genreLabel.text = band.genre
        albumLabel.text = band.famousAlbum
    }
}
