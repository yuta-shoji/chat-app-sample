import UIKit

protocol InputContainerViewDelegate: AnyObject {
    func didTapSend(text: String)
}

class InputContainerView: UIView {
    let inputTextField = UITextField()
    
    let sendButton = UIButton(type: .system)
    
    var delegate: InputContainerViewDelegate?
    
    init() {
        inputTextField.borderStyle = .roundedRect
        
        super.init()
        self.autoresizingMask = .flexibleHeight
        self.backgroundColor = .systemYellow
        
        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.anchor(
            right: self.trailingAnchor,
            paddingRight: 8,
            width: 50,
            height: 50
        )
        
        
        inputTextField.anchor(
            top: self.topAnchor,
            left: self.leadingAnchor,
            bottom: self.layoutMarginsGuide.bottomAnchor,
            right: sendButton.leadingAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 8,
            paddingRight: 8
        )
        inputTextField.delegate = self
        
        self.addSubview(inputTextField)
        self.addSubview(sendButton)
    }
    
    func clearInputText() {
        inputTextField.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize.zero
    }
    
    @objc func didTapSend() {
        guard delegate != nil else { return }
        guard let message = inputTextField.text, inputTextField.text != "" else { return }
        delegate?.didTapSend(text: message)
    }
}

extension InputContainerView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
