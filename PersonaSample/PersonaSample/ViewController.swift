//
//  ViewController.swift
//  PersonaSample
//
//  Created by Solid on 28/09/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblPersonIDTitle: UILabel!
    @IBOutlet weak var txtPersonID: UITextField!
        
    @IBOutlet weak var lblEnviormentTitle: UILabel!
    @IBOutlet weak var txtEnvironment: UITextField!
    
    @IBOutlet weak var lblLogs: UILabel!

    let pickerView = UIPickerView()
    var strSelectedEnvironment: String? = ""
    
    var personaWebView: WKWebView!
    let personaCallback = "https://personacallback"
    
    public let environmnts: [String] = ["SANDBOX", "PRODUCTION"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtPersonID.delegate = self
        
        lblLogs.isHidden = true
        
        setPicker()
    }
    
    @IBAction func startPersonaVerification(_ sender: Any) {
        /*
        - Enter "person_id" with one that you recieve from server
        - Select 'sandbox' OR 'production'
        */
        
        if let strPersonID = txtPersonID.text?.trimmingCharacters(in: CharacterSet.whitespaces), !strPersonID.isEmpty,
           let strEnvironment = txtEnvironment.text, !strEnvironment.isEmpty {
            /* MAKE API CALL TO GET hostedURL FROM YOUR SERVER
             - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#b53a7e6a-a1b0-4510-89e5-c69704d3a7f9
             */
            callAPIToGetHostedURL(strPersonID: strPersonID, strEnvironment: strEnvironment)
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

// MARK: - Webview methods
extension ViewController {
    func loadWebview(forHostedUrl: String) {
        // Create the web view and show it
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true

        if personaWebView == nil {
            personaWebView = WKWebView(frame: .zero, configuration: config)
            personaWebView.navigationDelegate = self
            personaWebView.allowsBackForwardNavigationGestures = false
            personaWebView.scrollView.bounces = false
            personaWebView.translatesAutoresizingMaskIntoConstraints = false
            personaWebView.backgroundColor = .white
            view.addSubview(personaWebView)
            
            NSLayoutConstraint.activate([
                personaWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                personaWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                personaWebView.topAnchor.constraint(equalTo: view.topAnchor),
                personaWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        let redirectURI = "&redirect-uri=\(personaCallback)"
        let strUrl  = forHostedUrl + redirectURI
        let hostedURL = URL(string: strUrl)
        let request = URLRequest(url: hostedURL!)
        personaWebView.load(request)
   }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("hellosign webview error : \(error)")
    }
    
    /// Handle navigation actions from the web view.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // Check if we are being redirected to our `redirectUri`. This happens once verification is completed.
        guard let redirectUri = navigationAction.request.url?.absoluteString, redirectUri.starts(with: personaCallback) else {
            // We're not being redirected, so load the URL.
            decisionHandler(.allow)
            return
        }

        // At this point we're done, so we don't need to load the URL.
        // verification is success..
        decisionHandler(.cancel)
        
        self.lblLogs.isHidden = false
        self.lblLogs.text = "Identity success....."

        //self.lblLogs.text = "Identity success.....\nInquiryID: \("inquiryID") \n\n Attributes: \(attributes)\n\nRelationships: \(relationships)"
        
        /* ON API CALL SUCCESS, MAKE API CALL TO SUBMIT KYC'
         - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#d9e1ff39-729e-4f3a-beb0-78cd48710087
         */
        self.callAPIToSubmitKYC()
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
    func callAPIToGetHostedURL(strPersonID: String, strEnvironment: String) {
        //ON SUCCESS..HOSTED URL WILL BE RECIVED..
        //PASS RECEIVED HOSTED URL TO LOAD WEBVIEW...
        self.loadWebview(forHostedUrl: "")
    }

    func callAPIToSubmitKYC() {
    }
}

