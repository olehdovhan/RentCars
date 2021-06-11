//
//  RentedCar+CoreDataProperties.swift
//  RentCars
//
//  Created by Oleh Dovhan on 11.06.2021.
//
//

import Foundation
import CoreData


extension RentedCar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RentedCar> {
        return NSFetchRequest<RentedCar>(entityName: "RentedCar")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var lastStarted: Date?
    @NSManaged public var mark: String?
    @NSManaged public var model: String?
    @NSManaged public var rating: Double
    @NSManaged public var timesDriven: Int16

}

extension RentedCar : Identifiable {

}
