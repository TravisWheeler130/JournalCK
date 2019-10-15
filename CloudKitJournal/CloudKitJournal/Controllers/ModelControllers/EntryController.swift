//
//  EntryController.swift
//  CloudKitJournal
//
//  Created by Travis Wheeler on 10/14/19.
//  Copyright © 2019 Travis Wheeler. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    //MARK: - shared instance
    static let shared = EntryController()
    private init() {}
    
    //MARK: - Source of Truth
    var entries: [Entry] = []
    
    //MARK: - CRUD
    func save(entry: Entry, completion: @escaping (Bool) -> ()) {
        let record = CKRecord(entry: entry)
        CKContainer.default().privateCloudDatabase.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            guard let record = record,
                let entry = Entry(ckRecord: record) else { completion(false) ; return }
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func addEntryWith(title: String, bodyText: String, completion: @escaping (Bool) -> Void) {
        let newEntry = Entry(title: title, bodyText: bodyText)
        save(entry: newEntry, completion: completion)
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.RecordType, predicate: predicate)
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            guard let records = records else { completion(false) ; return }
            let entries = records.compactMap { Entry(ckRecord: $0)}
            self.entries = entries
            completion(true)
        }
    }
} // End of Class
