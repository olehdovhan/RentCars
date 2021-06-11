//
//  ViewController.swift
//  RentCars
//
//  Created by Oleh Dovhan on 09.06.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
  
  lazy var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .short
    df.timeStyle = .none
    return df
  }()
  @IBOutlet var markLabel: UILabel!
  @IBOutlet var modelLabel: UILabel!
  @IBOutlet var carImageView: UIImageView!
  @IBOutlet var lastTimeStartedLabel: UILabel!
  @IBOutlet var numberOfTripsLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var segmentedControl: UISegmentedControl!
  @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
    
    updateSegmentedControl()
    
  }
  
  @IBAction func startTripPressed(_ sender: UIButton) {
  }
  
  @IBAction func ratePressed(_ sender: UIButton) {
  }
  
  private func insertDataFrom(selectedCar car: RentedCar) {
    carImageView.image = UIImage(data: car.imageData!)
    markLabel.text = car.mark
    modelLabel.text = car.model
    ratingLabel.text = "Rating: \(car.rating) / 10"
    numberOfTripsLabel.text = "Number of trips: \(car.timesDriven)"
    
    lastTimeStartedLabel.text = "Last time started: \(dateFormatter.string(from: car.lastStarted!))"
  }
  
  private func getDataFromFile() {
    let fetchRequest: NSFetchRequest<RentedCar> = RentedCar.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "mark != nil")
    
    var records = 0
    
    do {
      records = try context.count(for: fetchRequest)
      print("Is Data there already?")
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    guard records == 0 else { return }
    
    
    guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
          let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
    
    for dictionary in dataArray {
      let entity = NSEntityDescription.entity(forEntityName: "RentedCar", in: context)
      let car = NSManagedObject(entity: entity!, insertInto: context) as! RentedCar
      
      let carDictionary = dictionary as! [String : AnyObject]
      car.mark = carDictionary["mark"] as? String
      car.model = carDictionary["model"] as? String
      car.rating = carDictionary["rating"] as! Double
      car.lastStarted = carDictionary["lastStarted"] as? Date
      car.timesDriven = carDictionary["timesDriven"] as! Int16
      
      let imageName = carDictionary["imageName"] as? String
      let image = UIImage(named: imageName!)
      let imageData = image!.pngData()
      car.imageData = imageData
      
    }
  }
  
  private func updateSegmentedControl() {
    let fetchRequest: NSFetchRequest<RentedCar> = RentedCar.fetchRequest()
    let mark = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)
    
    do {
      let results = try context.fetch(fetchRequest)
      let car = results.first
      insertDataFrom(selectedCar: car!)
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getDataFromFile()
//    updateSegmentedControl()
  }
  
  
}

