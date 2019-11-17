//
//  Bundle-Decoder.swift
//  Moonshot
//
//  Created by dominator on 11/11/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import Foundation

extension Bundle{
    func loadFile<T: Codable>(_ named: String) -> T{
        guard let url = self.url(forResource: named, withExtension: nil) else{
            fatalError("unable to get url for file: \(named)")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("unable to load file: \(named) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "y-MM-dd"
        
        decoder.dateDecodingStrategy = .formatted(dateformatter)
        
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Unable to convert: data to \(T.self)")
        }
        
        return decodedData
    }
}
