//
//  ViewController.swift
//  PersonaSample
//
//  Created by Solid on 28/09/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblPersonIDTitle: UILabel!
    @IBOutlet weak var txtPersonID: UITextField!
    
    @IBOutlet weak var lblTempalteIDTitle: UILabel!
    @IBOutlet weak var txtTempalteID: UITextField!
    
    @IBOutlet weak var lblEnviormentTitle: UILabel!
    @IBOutlet weak var txtEnvironment: UITextField!
    
    @IBOutlet weak var lblLogs: UILabel!

    var personaHelper: PersonaHelper?
    let pickerView = UIPickerView()
    var strSelectedEnvironment: String? = ""
    
    public let environmnts: [String] = ["SANDBOX", "PRODUCTION"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtPersonID.delegate = self
        txtTempalteID.delegate = self
        
        setPicker()
        
        /* SET UP PERSONA HELPER*/
        setupPersona()
    }

    func setupPersona() {
        /* INITIALSE PERSONA HELPER */
        personaHelper = PersonaHelper(self)
        
        /* HANDLE PERSONA IDENTIFICATION SUCCESS */
        personaHelper?.onSuccess = { (inquiryID: String) -> Void in
            debugPrint("identity success... inquiryID is : \(inquiryID)")
            
            self.lblLogs.text = "Logs:\nIdentity success...\nInquiryID: \(inquiryID)"
            
            /* MAKE API CALL TO SUBMIT 'inquiry_id' TO YOUR SERVER
             - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#937e0241-2229-4aad-96e7-10abbd235933
             */
            self.callAPIToSubmitIDVerification(inquiryID: inquiryID)
        }
    }
    
    @IBAction func startPersonaVerification(_ sender: Any) {
        /* - Enter "template_id" with one that you recieve from server
        - Enter "person_id" with one that you recieve from server
        - Select 'sandbox' OR 'production'
        */
        
        if let strPersonID = txtPersonID.text?.trimmingCharacters(in: CharacterSet.whitespaces), !strPersonID.isEmpty,
           let strTemplateID = txtTempalteID.text?.trimmingCharacters(in: CharacterSet.whitespaces), !strTemplateID.isEmpty,
           let strEnvironment = txtEnvironment.text, !strTemplateID.isEmpty {
            /* MAKE API CALL TO GET 'template_id' FROM YOUR SERVER
             - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#b53a7e6a-a1b0-4510-89e5-c69704d3a7f9
             */
            callAPIToGetPersonaTemplateID(strPersonID: strPersonID, strTemplateID: strTemplateID, strEnvironment: strEnvironment)
        } else {
            let alert = UIAlertController(title: "Enter valid data", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true;
    }
}

// MARK: - Picker Delegates
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func setPicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let toolbar = UIToolbar()
        
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        //doneButton.tintColor = .primaryColor

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        //cancelButton.tintColor = .primaryColor

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        self.txtEnvironment?.inputAccessoryView = toolbar
        self.txtEnvironment?.inputView = pickerView
    }

    @objc func donePicker() {
        let pDleage = pickerView.delegate
        let str = pDleage?.pickerView?(self.pickerView, titleForRow: self.pickerView.selectedRow(inComponent: 0), forComponent: 0)
        self.txtEnvironment!.text = str
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return environmnts.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return environmnts[row]
    }
}

// MARK: - API calls
extension ViewController {

    func callAPIToGetPersonaTemplateID(strPersonID: String, strTemplateID: String, strEnvironment: String) {
        /* ON API CALL SUCCESS, MAKE REQUEST TO CREATE PERSONA INQUIRY WITH person_id, template_id AND environment
        */
        self.personaHelper?.startPersonaIdentity(withTemplateId: strTemplateID, withPersonId: strPersonID, forEnvironment: strEnvironment)
    }

    func callAPIToSubmitIDVerification(inquiryID: String) {
        /* ON API CALL SUCCESS, MAKE API CALL TO SUBMIT KYC'
         - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#d9e1ff39-729e-4f3a-beb0-78cd48710087
         */
        self.callAPIToSubmitKYC()
    }

    func callAPIToSubmitKYC() {
    }
}

