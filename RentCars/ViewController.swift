//
//  ViewController.swift
//  RentCars
//
//  Created by Oleh Dovhan on 09.06.2021.
//

import UIKit

class ViewController: UIViewController {

  
  @IBOutlet var markLabel: UILabel!
  
  @IBOutlet var modelLabel: UILabel!
  
  @IBOutlet var carImageView: UIImageView!
  
  @IBOutlet var lastTimeStartedLabel: UILabel!
  
  @IBOutlet var numberOfTripsLabel: UILabel!
  
  @IBOutlet var ratingLabel: UILabel!
  
  @IBOutlet var segmentedControl: UISegmentedControl!
  

  @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
  }
  
  @IBAction func startTripPressed(_ sender: UIButton) {
  }
  
  @IBAction func ratePressed(_ sender: UIButton) {
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

