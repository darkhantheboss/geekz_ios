

import UIKit

class FooterBar: UIView, UITextFieldDelegate {
    
    @objc static let standardHeight: CGFloat = 44
    
    @objc var backButton: UIButton?
    @objc var forwardButton: UIButton?
    @objc var refreshButton: UIButton?
    @objc var addressField: UITextField?
    @objc var menuButton: UIButton?
    
    @objc weak var tabContainer: TabContainerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.radiumGray
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        
        backButton = UIButton().then { [unowned self] in
            $0.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.setTitleColor(.gray, for: .disabled)
            $0.tintColor = .lightGray
            $0.isEnabled = false
            
            self.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.width.equalTo(32)
                make.centerY.equalTo(self)
            }
        }
        
            forwardButton = UIButton().then { [unowned self] in
                $0.setImage(UIImage(named: "forward")?.withRenderingMode(.alwaysTemplate), for: .normal)
                $0.setTitleColor(.black, for: .normal)
                $0.setTitleColor(.lightGray, for: .disabled)
                $0.isEnabled = false
                $0.tintColor = .lightGray
                
                self.addSubview($0)
                $0.snp.makeConstraints { (make) in
                    make.right.equalTo(self).offset(-10)
                    make.width.equalTo(32)
                    make.centerY.equalTo(self)
                }
            }
        
        
        menuButton = UIButton().then { [unowned self] in
            $0.setImage(UIImage(named: "menu"), for: .normal)
            
            self.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.width.equalTo(25)
                make.height.equalTo(25)
                make.centerY.equalTo(self)
                make.centerX.equalTo(self)
            }
        }
        
        
            
        
        
        refreshButton = UIButton(frame: CGRect(x: -5, y: 0, width: 12.5, height: 15)).then {
            $0.setImage(UIImage.imageFrom(systemItem: .refresh)?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .gray
            addressField?.rightView = $0
            addressField?.rightViewMode = .unlessEditing
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    @objc func setupNaviagtionActions(forTabConatiner tabContainer: TabContainerView) {
        backButton?.addTarget(tabContainer, action: #selector(tabContainer.goBack(sender:)), for: .touchUpInside)
        forwardButton?.addTarget(tabContainer, action: #selector(tabContainer.goForward(sender:)), for: .touchUpInside)
        refreshButton?.addTarget(tabContainer, action: #selector(tabContainer.refresh(sender:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func setAddressText(_ text: String?) {
        guard let _ = addressField else { return }
        
        if !addressField!.isFirstResponder {
            addressField?.text = text
            checkForLocalhost()
        }
    }
    
    @objc func setAttributedAddressText(_ text: NSAttributedString) {
        guard let _ = addressField else { return }
        
        if !addressField!.isFirstResponder {
            addressField?.attributedText = text
            checkForLocalhost()
        }
    }
    
    func checkForLocalhost() {
        if let address = addressField?.text, address.contains("localhost") {
            addressField?.text = ""
        }
    }
    
    // MARK: - Textfield Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tabContainer?.loadQuery(string: textField.text)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let string = textField.attributedText?.mutableCopy() as? NSMutableAttributedString {
            string.setAttributes([:], range: NSRange(0..<string.length))
            textField.attributedText = string
        }
        if let text = textField.text, !text.isEmpty {
            textField.selectAll(nil)
        }
    }
    
}

