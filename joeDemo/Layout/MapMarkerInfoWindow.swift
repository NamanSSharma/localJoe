//
//  mapMarkerInfoWindow.swift
//  joeDemo
//
//  Created by Yudhvir Raj on 2017-11-25.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class MapMarkerInfoWindow: UIView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var profile: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MapMarkerInfoWindow", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }

}
