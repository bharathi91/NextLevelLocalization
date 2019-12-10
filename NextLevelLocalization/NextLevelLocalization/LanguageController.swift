

import Foundation
import UIKit

class LanguageController: NSObject,LanguagePickerViewDelegate {
   
    private static var privateSharedInstance: LanguageController?
    static var sharedInstance: LanguageController {
        if privateSharedInstance == nil {
            privateSharedInstance = LanguageController()
        }
        return privateSharedInstance!
    }
    class func destroy() {
        privateSharedInstance = nil
    }
    var picker = LanguagePickerView()
    var bottomConstraintHidden: NSLayoutConstraint = NSLayoutConstraint()
    var bottomConstraintVisible: NSLayoutConstraint = NSLayoutConstraint()
    var bottomConstraintHiddenToolBar: NSLayoutConstraint = NSLayoutConstraint()
    var isHidden = true
    var viewController: UIViewController!
   
    @objc func showOrHidePicker()  {
        picker.reloadAllComponents()
        if isHidden == true {
            UIView.animate(withDuration: 0.2, animations: {
                if #available(iOS 11.0, *) {
                    if self.bottomConstraintHidden.isActive {
                        NSLayoutConstraint.deactivate([self.bottomConstraintHidden])
                        NSLayoutConstraint.activate([self.bottomConstraintVisible])
                        self.viewController.view.layoutIfNeeded()
                        self.viewController.view.setRecursiveUserInteraction(enable: false)
                    }
                }
            }) { (testBoolean) in
                self.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.2, animations: {
                if #available(iOS 11.0, *) {
                    if self.bottomConstraintVisible.isActive {
                        NSLayoutConstraint.deactivate([self.bottomConstraintVisible])
                        NSLayoutConstraint.activate([self.bottomConstraintHidden])
                        self.viewController.view.layoutIfNeeded()
                        self.viewController.view.setRecursiveUserInteraction(enable: true)
                        
                    }
                }
            }) { (testBoolean) in
                self.isHidden = true
            }
        }
    }
   
    func addPickerToView(){
        picker.tag = 1000
        picker.toolbar?.tag = 1001
        picker.languagePickerDelegate = self
        viewController.view.addSubview(picker)
        picker.reloadAllComponents()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.toolbar?.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(picker.toolbar!)
        viewController.view.addSubview(picker)
        if #available(iOS 11.0, *) {
            bottomConstraintHidden = self.picker.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor,constant: 300.0)
            bottomConstraintVisible = self.picker.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor,constant: 0.0)
            bottomConstraintHiddenToolBar = (self.picker.toolbar?.bottomAnchor.constraint(equalTo: self.picker.topAnchor,constant: 0.0))!
            NSLayoutConstraint.activate([
                picker.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor),
                picker.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor),
                (picker.toolbar?.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor))!,
                (picker.toolbar?.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor))!,
                bottomConstraintHidden,bottomConstraintHiddenToolBar
                ])
        }
        
    }
   
    func enableLanguageSelection(isNavigationBarButton: Bool = false,forViewController:UIViewController) {
        viewController = forViewController
        self.removeViews()
            let button:UIButton = UIButton()
            button.tag = 1002
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Change Language", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.addTarget(self, action: #selector(showOrHidePicker), for: .touchUpInside)
            if isNavigationBarButton == true {
                viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
            }else {
                viewController.view.addSubview(button)
                if #available(iOS 11.0, *) {
                    NSLayoutConstraint.activate([
                        button.widthAnchor.constraint(equalToConstant: 40.0),
                        button.heightAnchor.constraint(equalToConstant: 40.0),
                        button.topAnchor.constraint(equalTo: self.viewController.view.topAnchor,constant: 15.0),
                        button.trailingAnchor.constraint(equalTo: self.viewController.view.safeAreaLayoutGuide.trailingAnchor,constant: -15.0),
                        ])
                }
            }
        self.addPickerToView()
    }
    func removeViews()  {
        for view in viewController.view.subviews {
            if view.tag == 1000 || view.tag == 1001 || view.tag == 1002 {
                view.removeFromSuperview()
            }
        }
    }
    func didTapDone(lang: DictionaryLanguage) {
        showOrHidePicker()
        BKLocalizationManager.sharedInstance.setCurrentBundle(forLanguage: lang.code)
        UserDefaults.selectedLanguage = lang.code
        NotificationCenter.default.post(name: Notification.Name(BKConstants.Notifications.LanguageChangeNotification), object: nil)
        LanguageController.sharedInstance.picker.updateViewForLocalisation()
    }
    
    func didTapCancel() {
        showOrHidePicker()
    }
    
}

extension UIView {
    func setRecursiveUserInteraction(enable:Bool)  {
        for view in self.subviews {
            if view.tag == 1000 || view.tag == 1001 || view.tag == 1002 {
                view.isUserInteractionEnabled = true
            }else {
                view.isUserInteractionEnabled = enable
            }
        }
    }
}
// Required modals
struct DictionaryLanguage: Codable {
    let code: String
    var fullName: String
}

extension UserDefaults {
    
    class var selectedLanguage:String {
        get {
            if (standard.string(forKey: "SelectedLanguage") == nil) {
                return "en"
            }
            else {
                return standard.string(forKey: "SelectedLanguage")!
            }
        }
        set {
            standard.set(newValue, forKey: "SelectedLanguage")
            standard.synchronize()
        }
    }
}
struct BKConstants {
    struct Notifications {
        static let LanguageChangeNotification = "LanguageChanged"
    }
    struct Labels {
        static let key1 = "key1"
        static let key2 = "key2"
        static let key3 = "key3"
        static let key4 = "key4"
        static let key5 = "key5"
        static let key6 = "key6"
        static let key7 = "key7"
        static let key8 = "key8"
        static let key9 = "key9"
        static let key10 = "key10"
    }
}
