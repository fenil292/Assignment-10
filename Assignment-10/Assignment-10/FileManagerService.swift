//
//  FileManagerService.swift
//  myFileManager
//
//  Created by DCS on 03/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
class  FileManagerService {
    static func getDocDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Doc Dir: \(paths[0])")
        return paths[0]
    }
    static func getfiles() -> Array<String> {
        let fm = FileManager.default
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var files = [String]()
        do {
            let items = try fm.contentsOfDirectory(atPath: path.path)
            
            for item in items {
                //print("Found \(item)")
                if item.contains(".txt") {
                    files.append(item.components(separatedBy: ".").first ?? "")
                }
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
        return files
    }
}
