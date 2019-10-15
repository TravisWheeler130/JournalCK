//
//  Entry.swift
//  CloudKitJournal
//
//  Created by Travis Wheeler on 10/14/19.
//  Copyright © 2019 Travis Wheeler. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    var title: String
    var bodyText: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, bodyText: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord){
        guard let title = ckRecord[EntryConstants.titleKey] as? String,
            let body = ckRecord[EntryConstants.bodyKey] as? String,
            let timestamp = ckRecord[EntryConstants.timestampKey] as? Date else {return nil}
        self.init(title: title, bodyText: body, timestamp: timestamp, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord {
    convenience init(entry: Entry){
        self.init(recordType: EntryConstants.RecordType, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: EntryConstants.titleKey)
        self.setValue(entry.bodyText, forKey: EntryConstants.bodyKey)
        self.setValue(entry.timestamp, forKey: EntryConstants.timestampKey)
    }
}

struct EntryConstants {
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
    static let RecordType = "Entry"
}
