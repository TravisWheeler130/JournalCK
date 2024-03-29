//
//  EntryDetailViewController.swift
//  CloudKitJournal
//
//  Created by Travis Wheeler on 10/14/19.
//  Copyright © 2019 Travis Wheeler. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    //MARK: - Properties
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    //MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
            !title.isEmpty,
            !bodyTextView.text.isEmpty else {return}
        EntryController.shared.addEntryWith(title: title, bodyText: bodyTextView.text) { (true) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    @IBAction func mainViewTapped(_ sender: Any) {
        bodyTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
}

//MARK: - UITextFieldDelegate
extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
