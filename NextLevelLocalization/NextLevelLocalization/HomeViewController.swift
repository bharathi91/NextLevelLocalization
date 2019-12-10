
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblThree: UILabel!
    @IBOutlet weak var lblFour: UILabel!
    @IBOutlet weak var lblFive: UILabel!
    @IBOutlet weak var lblSix: UILabel!
    @IBOutlet weak var lblSeven: UILabel!
    @IBOutlet weak var lblEight: UILabel!
    @IBOutlet weak var lblNine: UILabel!
    @IBOutlet weak var lblTen: UILabel!
    @IBOutlet weak var langSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        langSwitch.setOn(false, animated: false)
        langSwitch.addTarget(self, action: #selector(doToggle(langSwitch:)), for: .valueChanged)
        BKLocalizationManager.sharedInstance.setCurrentBundle(forLanguage: UserDefaults.selectedLanguage)
        LanguageController.sharedInstance.enableLanguageSelection(isNavigationBarButton: true, forViewController: self)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(BKConstants.Notifications.LanguageChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: Notification.Name(BKConstants.Notifications.LanguageChangeNotification), object: nil)
        updateView()
    }
    @objc func doToggle(langSwitch: UISwitch) {
        if langSwitch.isOn && !langSwitch.isSelected {
            langSwitch.isSelected = true
            BKLanguageServiceManager.sharedInstance.getLanguagesFromServer(url: URL(string: "https://api.myjson.com/bins/156d5o")!, fromVC: self)
        } else {
            langSwitch.isSelected = false
        }
    }
    @objc func updateView() {
        lblOne.text = NSLocalizedString(BKConstants.Labels.key1, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblTwo.text = NSLocalizedString(BKConstants.Labels.key2, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblThree.text = NSLocalizedString(BKConstants.Labels.key3, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblFour.text = NSLocalizedString(BKConstants.Labels.key4, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblFive.text = NSLocalizedString(BKConstants.Labels.key5, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblSix.text = NSLocalizedString(BKConstants.Labels.key6, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblSeven.text = NSLocalizedString(BKConstants.Labels.key7, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblEight.text = NSLocalizedString(BKConstants.Labels.key8, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblNine.text = NSLocalizedString(BKConstants.Labels.key9, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblTen.text =  NSLocalizedString(BKConstants.Labels.key10, tableName: "", bundle: BKLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        changeBGColor()
    }
    func changeBGColor()  {
        let labels = contentView.subviews.compactMap { $0 as? UILabel }
        for label in labels {
            UIView.transition(with: label, duration: 0.2, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                label.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
            }) { (completed) in
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(self.scrollView.contentSize)
    }
    
}
