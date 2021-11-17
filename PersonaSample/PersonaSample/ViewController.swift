//
//  ViewController.swift
//  PersonaSample
//
//  Created by Solid on 28/09/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblEnquiryURLTitle: UILabel!
    @IBOutlet weak var txtEnquiryURL: UITextField!
    
    @IBOutlet weak var lblLogs: UILabel!

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var personaWebView: WKWebView!
    let personaCallback = "https://personacallback"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtEnquiryURL.delegate = self
        lblLogs.isHidden = true
    }
    
    @IBAction func startPersonaVerification(_ sender: Any) {
        self.lblLogs.isHidden = true
        self.lblLogs.text = ""
        
        if let strEnquiryURL = txtEnquiryURL.text?.trimmingCharacters(in: CharacterSet.whitespaces), !strEnquiryURL.isEmpty, isValidUrl(urlString: strEnquiryURL) {
            //PASS ENTERED HOSTED URL TO LOAD WEBVIEW...
            self.loadWebview(forHostedUrl: strEnquiryURL)
        } else {
            let alert = UIAlertController(title: "Enter valid Enquiry URL", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func activityIndicatorBegin() {
        activityIndicatorEnd()
        
        let currentWindow: UIWindow? = UIApplication.shared.windows.filter({$0.isKeyWindow}).first // UIApplication.shared.keyWindow
       
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        activityIndicator.center = currentWindow!.center
        activityIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            // Fallback on earlier versions
            activityIndicator.style = .whiteLarge
        }

        currentWindow?.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func activityIndicatorEnd() {
        self.activityIndicator.stopAnimating()
    }
    
    func isValidUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
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
        
        self.activityIndicatorBegin()

        let redirectURI = "&redirect-uri=\(personaCallback)"
        let strUrl  = forHostedUrl + redirectURI
        let hostedURL = URL(string: strUrl)
        let request = URLRequest(url: hostedURL!)
        personaWebView.load(request)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.activityIndicatorEnd()
        }
   }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicatorEnd()
        debugPrint("webview error : \(error)")
    }
    
    /// Handle navigation actions from the web view.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // Check if we are being redirected to our `redirectUri`. This happens once verification is completed.
        guard let redirectUri = navigationAction.request.url?.absoluteString, redirectUri.starts(with: personaCallback) else {
            // We're not being redirected, so load the URL.
            decisionHandler(.allow)
            return
        }
        
        let responseUrl = URL(string: redirectUri)!
        var responseDict = [String:String]()
        let components = URLComponents(url: responseUrl, resolvingAgainstBaseURL: false)!
        if let queryItems = components.queryItems {
            for item in queryItems {
                responseDict[item.name] = item.value!
            }
        }
        
        // At this point we're done, so we don't need to load the URL.
        // verification is success..
        decisionHandler(.cancel)

        
        self.txtEnquiryURL.text = ""
        self.personaWebView.removeFromSuperview()
        
        self.lblLogs.isHidden = false
        self.lblLogs.text = "Identity success.....\n\(responseDict)"

        
        /* ON API CALL SUCCESS, MAKE API CALL TO SUBMIT KYC'
         - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#d9e1ff39-729e-4f3a-beb0-78cd48710087
         */
        self.callAPIToSubmitKYC()
    }
}

// MARK: - API calls
extension ViewController {
    func callAPIToSubmitKYC() {
    }
}

