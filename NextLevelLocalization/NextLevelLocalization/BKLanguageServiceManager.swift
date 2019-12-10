

import Foundation
import UIKit

class BKLanguageServiceManager {
    private static var privateSharedInstance: BKLanguageServiceManager?
    static var sharedInstance: BKLanguageServiceManager {
        if privateSharedInstance == nil {
            privateSharedInstance = BKLanguageServiceManager()
            privateSharedInstance?.commonInit()
        }
        return privateSharedInstance!
    }
    var labelView:UIVisualEffectView = UIVisualEffectView()
    var labelVerifying:UILabel = UILabel()
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    func commonInit() {
            languagesArray = BKLocalizationManager.sharedInstance.getLocalLanguageVersions()
    }
    var languagesArray: [DictionaryLanguage]!
    func getLanguagesFromServer(url: URL,fromVC:UIViewController)  {
        self.showLoading()
        let task = URLSession.shared.dataTask(with: url as URL) { data, response, error in
            self.dismissLoading()
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as?  [String : Any]
                if let languagesArray = jsonResponse!["languages"] as? [[String : Any]] {
                    for lang in languagesArray {
                        let translations = lang["translations"] as? Dictionary<String,String>
                        let langName = lang["code"] as? String
                        let dict : Dictionary<String, Dictionary<String, String>> = [langName!: translations!]
                        let rt = BKLocalizable(translations:dict)
                        do {
                            _ = try rt.writeToBundle()
                        }catch {
                            print("error")
                        }
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        
        task.resume()

    }
    
    func showLoading(){
        if  let window = UIApplication.shared.delegate!.window {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
            labelVerifying.removeFromSuperview()
            labelView.removeFromSuperview()
            labelVerifying = UILabel(frame: CGRect(x: 0, y: 0, width: 195, height: 25))
            labelVerifying.textAlignment = .center
            labelVerifying.center = (window?.center)!
            labelVerifying.frame = CGRect(x: labelVerifying.frame.origin.x,
                                          y: labelVerifying.frame.origin.y + 40,
                                          width: labelVerifying.frame.width,
                                          height: labelVerifying.frame.height)
            labelVerifying.text = "Downloading Language Files"
            labelVerifying.textColor = UIColor.darkGray
            labelView.effect = blurEffect
            labelView.contentView.addSubview(spinner)
            labelView.backgroundColor = UIColor(white: 1, alpha: 1)
            labelView.contentView.addSubview(labelVerifying)
            labelView.frame = (window?.bounds)!
            spinner.center = ((window?.center)!)
            spinner.startAnimating()
            
            window?.addSubview(labelView)
            UIView.animate(withDuration: 0.2, animations: { [unowned self] () -> Void in
                self.labelView.alpha = 1
            })
        }
    }
    func dismissLoading() {
        DispatchQueue.main.async()  { [weak self] () -> Void in
            self?.labelView.removeFromSuperview()
            self?.labelVerifying.removeFromSuperview()
        }
    }
}
