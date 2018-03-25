

import UIKit
import LUAutocompleteView
import Crashlytics

class MainViewController: UIViewController, HistoryNavigationDelegate {

	@objc var container: UIView?
	@objc var tabContainer: TabContainerView?
    var addressBar: AddressBar!
    var footerBar: FooterBar!
    private let autocompleteView = LUAutocompleteView()
	
    override func viewDidLoad() {
        super.viewDidLoad()

      self.view.backgroundColor = .yellow
        
        //Setting background image for MAIN VIEW CONTROLLER
        self.view.backgroundColor = Colors.radiumPink
        
        let padding = UIView().then { [unowned self] in
//            $0.backgroundColor = Colors.radiumDarkGray
            
            self.view.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.width.equalTo(self.view)
                if #available(iOS 11.0, *) {
                    make.height.equalTo(self.view.safeAreaInsets.top)
                } else {
                    make.height.equalTo(UIApplication.shared.statusBarFrame.height)
                }
                make.top.equalTo(self.view)
            }
        }
        
        tabContainer = TabContainerView(frame: .zero).then { [unowned self] in
			$0.addTabButton?.addTarget(self, action: #selector(self.addTab), for: .touchUpInside)
            $0.tabCountButton.addTarget(self, action: #selector(showTabTray), for: .touchUpInside)
            
            self.view.addSubview($0)
            $0.snp.makeConstraints { (make) in
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                } else {
                    make.top.equalTo(padding.snp.bottom)
                }
                make.left.equalTo(self.view)
                make.width.equalTo(self.view)
                make.height.equalTo(TabContainerView.standardHeight)
            }
        }
        
        addressBar = AddressBar(frame: .zero).then { [unowned self] in
			$0.tabContainer = self.tabContainer
			self.tabContainer?.addressBar = $0
			
            $0.setupNaviagtionActions(forTabConatiner: self.tabContainer!)
			$0.menuButton?.addTarget(self, action: #selector(self.showMenu(sender:)), for: .touchUpInside)
			
            self.view.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.top.equalTo(self.tabContainer!.snp.bottom)
                make.left.width.equalTo(self.view)
                make.height.equalTo(AddressBar.standardHeight)
            }
        }
        
        
		
		container = UIView().then { [unowned self] in
            self.tabContainer?.containerView = $0
            
			self.view.addSubview($0)
			$0.snp.makeConstraints { (make) in
				make.top.equalTo(addressBar.snp.bottom)
				make.width.equalTo(self.view)
				make.height.equalTo(WebContainer.standardHeight)
				make.left.equalTo(self.view)
			}
		}
        
        footerBar = FooterBar(frame: .zero).then { [unowned self] in
            $0.tabContainer = self.tabContainer
            self.tabContainer?.footerBar = $0
            
            $0.setupNaviagtionActions(forTabConatiner: self.tabContainer!)
            $0.menuButton?.addTarget(self, action: #selector(self.showMenu(sender:)), for: .touchUpInside)
            
            self.view.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.top.equalTo(self.container!.snp.bottom)
                make.left.width.equalTo(self.view)
                make.height.equalTo(FooterBar.standardHeight)
            }
        }
        
        self.view.addSubview(autocompleteView)
        autocompleteView.textField = addressBar.addressField
        autocompleteView.dataSource = self
        autocompleteView.delegate = self
        autocompleteView.rowHeight = 45
        autocompleteView.autocompleteCell = AutocompleteTableViewCell.self
        autocompleteView.throttleTime = 0.2

		tabContainer?.loadBrowsingSession()
        
        if UserDefaults.standard.bool(forKey: SettingsKeys.needToShowAdBlockAlert) {
            showAdBlockEnabled()
        }
        
        addressBar.addressField?.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabContainer?.currentTab?.webContainer?.takeScreenshot()
    }
    
    override func viewDidLayoutSubviews() {
        tabContainer?.setUpTabConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tabContainer?.setUpTabConstraints()
    }
    
    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }
    
    func showAdBlockEnabled() {
        UserDefaults.standard.set(false, forKey: SettingsKeys.needToShowAdBlockAlert)
        
        let av = UIAlertController(title: "Ad Block Enabled!", message: "Thank you for being an early adopter of Radium! As a token of my grattitude you have received the new Ad Block add on free of charge! This will block ads from known sources on web pages you visit. Happy browsing!", preferredStyle: .alert)
        av.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            self.showSettings()
        }))
        av.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        delay(0.5) {
            self.present(av, animated: true, completion: nil)
        }
    }
    
	@objc func addTab() {
		let _ = tabContainer?.addNewTab(container: container!)
	}
    
    //////////
    
    var usrTextField: UITextField?
    var pwdTextField: UITextField?
    
    ///func ibaction {
    
    
    
    //}

//    func usrTextField(textField: UITextField!){
//        usrTextField = textField
//        usrTextField?.placeholder = "IITU.KZ"
//    }
//
//    func pwdTextField(textField: UITextField!){
//        pwdTextField = textField
//        pwdTextField?.placeholder = "password"
//        pwdTextField?.isSecureTextEntry = true
//    }
//
//    func okHandler(alert: UIAlertAction!) {
//        let simpleVC = SimpleVC()
//        simpleVC.customInit(usrStr: (usrTextField?.text)!, pwdStr: (pwdTextField?.text)!)
//        self.navigationController?.pushViewController(simpleVC, animated: true)
//
//    }
    
	/////////
	@objc func showMenu(sender: UIButton) {
        
//        let alertController = UIAlertController(title: "Вход в меню",
//                                                message: nil,
//                                                preferredStyle: .alert)
//
//        alertController.addTextField(configurationHandler: usrTextField)
//        alertController.addTextField(configurationHandler: pwdTextField)
//
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okHandler)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//
//        self.present(alertController, animated: true)
        
        
        
        
        
        
        let convertedPoint = sender.convert(sender.center, to: self.view)

        let addBookmarkAction = MenuItem.item(named: "Добавить в закладки", action: { [unowned self] in
            self.addBookmark(btn: sender)
        })
        let bookmarkAction = MenuItem.item(named: "Закладки", action: { [unowned self] in
            self.showBookmarks()
        })

        let extensionAction = MenuItem.item(named: "Расширения", action: { [unowned self] in
            let _ = self.showExtensions(animated: true)
        })
        let historyAction = MenuItem.item(named: "История", action: { [unowned self] in
            self.showHistory()
        })
        let settingsAction = MenuItem.item(named: "Настройки", action: { [unowned self] in
            self.showSettings()
        })

        let menu = SharedDropdownMenu(menuItems: [addBookmarkAction, bookmarkAction, /*shareAction,*/ extensionAction, historyAction, settingsAction])
        menu.show(in: self.view, from: convertedPoint)
    }
    
    @objc func showExtensions(animated: Bool) -> ExtensionsTableViewController {
        let vc = ExtensionsTableViewController(style: .grouped)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.barTintColor = Colors.radiumGray
        
        if isiPadUI {
            nav.modalPresentationStyle = .formSheet
        }
        
        self.present(nav, animated: animated, completion: nil)
        
        return vc
    }
	
	@objc func showHistory() {
		let vc = HistoryTableViewController()
        vc.delegate = self
		let nav = UINavigationController(rootViewController: vc)
		nav.navigationBar.barTintColor = Colors.radiumGray
		
		if isiPadUI {
			nav.modalPresentationStyle = .formSheet
		}
		
		self.present(nav, animated: true, completion: nil)
	}
	
	@objc func showBookmarks() {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: 80, height: 97.5)
		let vc = BookmarkCollectionViewController(collectionViewLayout: flowLayout)
        vc.delegate = self
		let nav = UINavigationController(rootViewController: vc)
		nav.navigationBar.barTintColor = Colors.radiumGray
		
		if isiPadUI {
			nav.modalPresentationStyle = .formSheet
		}
		
		self.present(nav, animated: true, completion: nil)
	}
    
    @objc func addBookmark(btn: UIView) {
        let vc = AddBookmarkTableViewController(style: .grouped)
        vc.pageIconURL = tabContainer?.currentTab?.webContainer?.favicon?.getPreferredURL()
        vc.pageTitle = tabContainer?.currentTab?.webContainer?.webView?.title
        vc.pageURL = tabContainer?.currentTab?.webContainer?.webView?.url?.absoluteString
        let nav = UINavigationController(rootViewController: vc)
        
        if isiPadUI {
            nav.modalPresentationStyle = .popover
            nav.popoverPresentationController?.permittedArrowDirections = .up
            nav.popoverPresentationController?.sourceView = btn
            nav.popoverPresentationController?.sourceRect = btn.bounds
        }
        
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func didSelectEntry(with url: URL?) {
        guard let url = url else { return }
        tabContainer?.loadQuery(string: url.absoluteString)
    }
    
    func showSettings() {
        let vc = SettingsTableViewController(style: .grouped)
        let nav = UINavigationController(rootViewController: vc)
        
        if isiPadUI {
            nav.modalPresentationStyle = .formSheet
        }
        
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func showTabTray() {
        let vc = TabTrayViewController()
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Import methods
    
    @objc func openEditor(withSource source: String, andName name: String) {
        if let presentedController = self.presentedViewController {
            presentedController.dismiss(animated: false, completion: nil)
        }
        
        let vc = self.showExtensions(animated: false)
        delay(0.15) {
            vc.presentEditor(name: name, source: source)
        }
    }
}

extension MainViewController: LUAutocompleteViewDataSource {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, elementsFor text: String, completion: @escaping ([String]) -> Void) {
        let results = SuggestionManager.shared.queryDomains(forText: text).map { $0.urlString }
        completion(results)
    }
}

extension MainViewController: LUAutocompleteViewDelegate {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, didSelect text: String) {
        addressBar.addressField?.text = text
        _ = addressBar.textFieldShouldReturn(addressBar.addressField!)
    }
}
