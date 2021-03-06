//
//  Restaurant.swift
//  Yelp
//
//  Created by Tuze on 4/7/17.
//  Copyright © 2017 Tugce Keser. All rights reserved.
//

import UIKit
public class Restaurant:NSObject{
    
    var restaurantImage:URL?
    var restaurantName:String?
    var rastaurantFarAway:String?
    var restaurantAddress:String?
    var reviewsCount:Int?
    var reviewsAverage:Float?
    var restaurantType:String?
    
    init(dictionary: NSDictionary) {
        restaurantName = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            restaurantImage = URL(string: imageURLString!)!
        } else {
            restaurantImage = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.restaurantAddress = address
        
        /*let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }*/
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            rastaurantFarAway = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            rastaurantFarAway = nil
        }
        
        /*let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = URL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber*/
    }
    
    class func restaurants(array: [NSDictionary]) -> [Restaurant] {
        var businesses = [Restaurant]()
        for dictionary in array {
            let business = Restaurant(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, completion: @escaping ([Restaurant]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([Restaurant]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, completion: completion)

    
    }
}
