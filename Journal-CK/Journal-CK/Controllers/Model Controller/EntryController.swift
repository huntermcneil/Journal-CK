//
//  EntryController.swift
//  Journal-CK
//
//  Created by Hunter McNeil on 6/29/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func createEntryWith(title: String, body: String, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {
        
        let newEntry = Entry(title: title, body: body)
        
        save(entry: newEntry) { (result) in
            return completion(result)
        }
    }
    
    func save(entry: Entry, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {
        
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                print("There was an error saving the Entry: \(error) - \(error.localizedDescription)")
                return completion(.failure(.ckError(error)))
            }
            guard let record = record,
                let savedEntry = Entry(ckRecord: record) else {return completion(.failure(.couldNotUnwrap))}
            print("Saved Entry successfully")
            completion(.success(savedEntry))
            self.entries.append(savedEntry)
        }
        
    }
    
    func fetchEntriesWith(completion: @escaping (_ result: Result<[Entry], EntryError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.recordType, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("There was an error fetching the Entries - \(error) - \(error.localizedDescription)")
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            
            let fetchedEntries = records.compactMap { Entry(ckRecord: $0) }
            self.entries = fetchedEntries
        }
    }
    
}
